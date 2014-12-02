//
//  FieldValidator.swift
//  FormValidator
//
//  Created by JMariano on 11/11/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

import UIKit

//An object to validate a field
public class FieldValidator: NSObject {
    var iterator: ValidatorIterator?
    var validators : Array<Validator>?
    var validator : Validator?
    var evaluatedValue: AnyObject?
    var fieldView: NSObject?
    var nextFieldValidator: FieldValidator?
    var formValidator: FormValidator?
    var validationErrorHint: ValidationError?
    var errorHints: Array<String>?
    public var delegate: FieldValidatorDelegate?
    public var fieldInput : () -> AnyObject?
    
    
    public init(inputValue: () -> AnyObject, rules: Array<Validator>, nextValidator: FieldValidator?,
        form: FormValidator) {
        //super.init()
        iterator = ValidatorIterator(listItems: rules)
        fieldInput = inputValue
        nextFieldValidator = nextValidator
        formValidator = form
        errorHints = Array<String>()
    }
    
    func validate() {
        errorHints?.removeAll()
        evaluatedValue = fieldInput()
        iterator?.reset()
        nextRule()
    }
    
    func nextRule() {
        if iterator!.hasNext() {
            validator = iterator?.next()
            if validator!.validate(evaluatedValue!) {
                nextRule()
            }else{
                //append error messages
                errorHints?.append(validator!.error!.hint!)

                //report error to form
                formValidator?.addFieldError()
                nextRule()
            }
        }else{
            delegate?.didEvaluateField(self, errors:errorHints!, form: formValidator!)
            nextFieldValidator?.validate()
        }
    }
    
    public func value() -> AnyObject {
        return fieldInput()!
    }
}
