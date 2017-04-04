//
//  FieldValidator.swift
//  FormValidator
//
//  Created by JMariano on 11/11/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

import UIKit

//An object to validate a field
open class FieldValidator: NSObject {
    fileprivate var iterator: ValidatorIterator?
    fileprivate var validators : Array<Validator>?
    fileprivate var validator : Validator?
    fileprivate var evaluatedValue: AnyObject?
    fileprivate var fieldView: NSObject?
    fileprivate var nextFieldValidator: FieldValidator?
    fileprivate var formValidator: FormValidator?
    fileprivate var validationErrorHint: ValidationError?
    fileprivate var errorHints: Array<String>?
    fileprivate var fieldInput : () -> AnyObject?
    open var delegate: FieldValidatorDelegate?
    
    
    public init(rules: Array<Validator>, addValidator: FieldValidator?,
        form: FormValidator, inputValue: @escaping () -> AnyObject) {
        //super.init()
        iterator = ValidatorIterator(listItems: rules)
        fieldInput = inputValue
        nextFieldValidator = addValidator
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
    
    open func value() -> AnyObject {
        return fieldInput()!
    }
}
