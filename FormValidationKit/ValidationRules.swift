//
//  Validators.swift
//  FormValidator
//
//  Created by JMariano on 11/11/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}



open class StringUtility: NSObject {
    open class func stringIsNotEmpty(_ str: String) -> Bool {
        let cleanString = str.trimmingCharacters(in: CharacterSet.whitespaces)
        if cleanString.isEmpty {
            return false
        }
        return true
    }
}

open class RegextUtility: NSObject {
    open class func isValidFormat(_ regEx:String, str:String) -> Bool {
        let emailRegEx = regEx
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: str)
        return result
    }
}

open class NotRequired: NSObject, Validator {
    open var error: ValidationError?
    
    public init(validationError: ValidationError) {
        error = validationError
    }
    
    open func validate(_ value: AnyObject) -> Bool {
        return true
    }
    
    open func validationError() {
        print("Field is required")
    }
}

open class Required: NSObject, Validator {
    open var error: ValidationError?
    
    public init(validationError: ValidationError) {
        error = validationError
    }
    
    open func validate(_ value: AnyObject) -> Bool {
        return StringUtility.stringIsNotEmpty(value as! String)
    }
    
    open func validationError() {
        print("Field is required")
    }
}

open class Email: NSObject, Validator {
    open var error: ValidationError?
    
    public init(validationError: ValidationError) {
        error = validationError
    }
    
    open func validate(_ value: AnyObject) -> Bool {
        let string : String = value as! String
        
        //only validate if the field is not empty
        if string.isEmpty {
            return true
        }else{
            return RegextUtility.isValidFormat("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}", str: value as! String)
        }
    }

    open func validationError() {
        print("Text is not E-mail")
    }
}

open class MatchesField: NSObject, Validator {
    open var error: ValidationError?
    var compareValue: String?
    var compareWithField: FieldValidator?
    
    public init(compareWithValidator: FieldValidator, validationError: ValidationError) {
        compareWithField = compareWithValidator
        error = validationError
    }
    
    open func validate(_ value: AnyObject) -> Bool {
        return value as! String == (compareWithField!.value() as! String) && StringUtility.stringIsNotEmpty(value as! String)
    }
    
    open func validationError() {
        print("Fields do not match")
    }
}


open class MinimumLength: NSObject, Validator {
    open var error: ValidationError?
    var minLength: Int?
    
    public init(minimumLength: Int, validationError: ValidationError) {
        minLength = minimumLength
        error = validationError
    }
    
    open func validate(_ value: AnyObject) -> Bool {
        let string : String = value as! String
        if string.isEmpty {
            return true
        }else{
            return string.characters.count >= minLength
        }
    }
    
    open func validationError() {
        print("Minimum length not met")
    }
}

open class MaximumLength: NSObject, Validator {
    open var error: ValidationError?
    var maxLength: Int?
    
    public init(maximumLength: Int, validationError: ValidationError) {
        maxLength = maximumLength
        error = validationError
    }
    
    open func validate(_ value: AnyObject) -> Bool {
        let string : String = value as! String
        if string.isEmpty {
            return true
        }else{
            return string.characters.count <= maxLength
        }
    }
    
    open func validationError() {
        print("Max length not met")
    }
}

open class ExactLength: NSObject, Validator  {
    open var error: ValidationError?
    var exactLength: Int?
    public init(expectedLength: Int, validationError: ValidationError) {
        exactLength = expectedLength
        error = validationError
    }
    
    open func validate(_ value: AnyObject) -> Bool {
        return (value as! String).characters.count == exactLength
    }
    
    open func validationError() {
        print("Length not as expected")
    }
}

open class GreaterThan: NSObject, Validator  {
    open var error: ValidationError?
    var greaterVal: Int?
    public init(greaterValue: Int, validationError: ValidationError) {
        greaterVal = greaterValue
        error = validationError
    }
    
    open func validate(_ value: AnyObject) -> Bool {
        return Int(value as! String)  > greaterVal!
    }
    
    open func validationError() {
        print("Value not greater than number")
    }
}

open class LessThan: NSObject, Validator  {
    open var error: ValidationError?
    var lessVal: Int?
    public init(lessValue: Int, validationError: ValidationError) {
        lessVal = lessValue
        error = validationError
    }
    
    open func validate(_ value: AnyObject) -> Bool {
        return Int(value as! String) < lessVal
    }
    
    open func validationError() {
        print("Value not less than number")
    }
}

open class Numeric: NSObject, Validator  {
    open var error: ValidationError?
    
    public init(validationError: ValidationError) {
        error = validationError
    }
    
    open func validate(_ value: AnyObject) -> Bool {
        return Int(value as! String) != nil
    }
    open func validationError() {
        print("Value is not numeric")
    }
}

open class Decimal: NSObject, Validator  {
    open var error: ValidationError?
    
    public init(validationError: ValidationError) {
        error = validationError
    }
    
    open func validate(_ value: AnyObject) -> Bool {
        let str = value as! String
        let scanner = Scanner(string: str)
        return scanner.scanFloat(nil)
    }
    
    open func validationError() {
        print("Value is not a coke float")
    }
}
