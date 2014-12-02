//
//  ValidatorInterfaces.swift
//  FormValidator
//
//  Created by JMariano on 11/11/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//
public struct ValidationError {
    public var hint: String?
    public init (hint: String) {
        self.hint = hint
    }
}

public protocol FieldValidatorDelegate {
    func didEvaluateField(field: FieldValidator, errors: Array<String>, form: FormValidator)
}

@objc public protocol FieldValidationStates{
    func errorFieldState()
    func defaultFieldState()
}

@objc public  protocol Field: FieldValidationStates{
    
}

public protocol FormValidation {
    var delegate: FormValidationDelegate? {get set}
    func validate()
    func addFieldError()
}

public protocol FieldValidatorObject {
    func nextValidator()
}

public protocol Validator {
    var error: ValidationError? {get set}
    func validate(value: AnyObject) ->Bool
    func validationError()
}

public protocol FormValidationDelegate {
    func didPassFormValidation(form: FormValidation)
    func didFailFormValidation(form: FormValidation)
}