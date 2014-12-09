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
    private var iterator: ValidatorIterator?
    private var validators : Array<Validator>?
    private var validator : Validator?
    private var evaluatedValue: AnyObject?
    private var fieldView: NSObject?
    private var nextFieldValidator: FieldValidator?
    private var formValidator: FormValidator?
    private var validationErrorHint: ValidationError?
    private var errorHints: Array<String>?
    private var fieldInput : () -> AnyObject?
    public var delegate: FieldValidatorDelegate?
    
    
    public init(rules: Array<Validator>, addValidator: FieldValidator?,
        form: FormValidator, inputValue: () -> AnyObject) {
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
    
    public func value() -> AnyObject {
        return fieldInput()!
    }
}
