//
//  Validators.swift
//  FormValidator
//
//  Created by JMariano on 11/11/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

import UIKit


public class StringUtility: NSObject {
    public class func stringIsNotEmpty(str: String) -> Bool {
        let cleanString = str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if cleanString.isEmpty {
            return false
        }
        return true
    }
}

public class RegextUtility: NSObject {
    public class func isValidFormat(regEx:String, str:String) -> Bool {
        let emailRegEx = regEx
        var emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest?.evaluateWithObject(str)
        return result!
    }
}

public class NotRequired: NSObject, Validator {
    public var error: ValidationError?
    
    public init(validationError: ValidationError) {
        error = validationError
    }
    
    public func validate(value: AnyObject) -> Bool {
        return true
    }
    
    public func validationError() {
        println("Field is required")
    }
}

public class Required: NSObject, Validator {
    public var error: ValidationError?
    
    public init(validationError: ValidationError) {
        error = validationError
    }
    
    public func validate(value: AnyObject) -> Bool {
        return StringUtility.stringIsNotEmpty(value as String)
    }
    
    public func validationError() {
        println("Field is required")
    }
}

public class Email: NSObject, Validator {
    public var error: ValidationError?
    
    public init(validationError: ValidationError) {
        error = validationError
    }
    
    public func validate(value: AnyObject) -> Bool {
        var string : String = value as String
        
        //only validate if the field is not empty
        if string.isEmpty {
            return true
        }else{
            return RegextUtility.isValidFormat("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}", str: value as String)
        }
    }

    public func validationError() {
        println("Text is not E-mail")
    }
}

public class MatchesField: NSObject, Validator {
    public var error: ValidationError?
    var compareValue: String?
    var compareWithField: FieldValidator?
    
    public init(compareWithValidator: FieldValidator, validationError: ValidationError) {
        compareWithField = compareWithValidator
        error = validationError
    }
    
    public func validate(value: AnyObject) -> Bool {
        return value as String == (compareWithField!.value() as String) && StringUtility.stringIsNotEmpty(value as String)
    }
    
    public func validationError() {
        println("Fields do not match")
    }
}


public class MinimumLength: NSObject, Validator {
    public var error: ValidationError?
    var minLength: Int?
    
    public init(minimumLength: Int, validationError: ValidationError) {
        minLength = minimumLength
        error = validationError
    }
    
    public func validate(value: AnyObject) -> Bool {
        var string : String = value as String
        if string.isEmpty {
            return true
        }else{
            return countElements(value as String) >= minLength
        }
    }
    
    public func validationError() {
        println("Minimum length not met")
    }
}

public class MaximumLength: NSObject, Validator {
    public var error: ValidationError?
    var maxLength: Int?
    
    public init(maximumLength: Int, validationError: ValidationError) {
        maxLength = maximumLength
        error = validationError
    }
    
    public func validate(value: AnyObject) -> Bool {
        var string : String = value as String
        if string.isEmpty {
            return true
        }else{
            return countElements(value as String) <= maxLength
        }
    }
    
    public func validationError() {
        println("Max length not met")
    }
}

public class ExactLength: NSObject, Validator  {
    public var error: ValidationError?
    var exactLength: Int?
    public init(expectedLength: Int, validationError: ValidationError) {
        exactLength = expectedLength
        error = validationError
    }
    
    public func validate(value: AnyObject) -> Bool {
        return countElements(value as String) == exactLength
    }
    
    public func validationError() {
        println("Length not as expected")
    }
}

public class GreaterThan: NSObject, Validator  {
    public var error: ValidationError?
    var greaterVal: Int?
    public init(greaterValue: Int, validationError: ValidationError) {
        greaterVal = greaterValue
        error = validationError
    }
    
    public func validate(value: AnyObject) -> Bool {
        return (value as String).toInt() > greaterVal
    }
    
    public func validationError() {
        println("Value not greater than number")
    }
}

public class LessThan: NSObject, Validator  {
    public var error: ValidationError?
    var lessVal: Int?
    public init(lessValue: Int, validationError: ValidationError) {
        lessVal = lessValue
        error = validationError
    }
    
    public func validate(value: AnyObject) -> Bool {
        return (value as String).toInt() < lessVal
    }
    
    public func validationError() {
        println("Value not less than number")
    }
}

public class Numeric: NSObject, Validator  {
    public var error: ValidationError?
    
    public init(validationError: ValidationError) {
        error = validationError
    }
    
    public func validate(value: AnyObject) -> Bool {
        return (value as String).toInt() != nil
    }
    public func validationError() {
        println("Value is not numeric")
    }
}

public class Decimal: NSObject, Validator  {
    public var error: ValidationError?
    
    public init(validationError: ValidationError) {
        error = validationError
    }
    
    public func validate(value: AnyObject) -> Bool {
        var str = value as String
        let scanner = NSScanner(string: str)
        return scanner.scanFloat(nil)
    }
    
    public func validationError() {
        println("Value is not a float")
    }
}