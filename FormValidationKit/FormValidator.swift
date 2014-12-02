//
//  FormValidator.swift
//  FormValidator
//
//  Created by JMariano on 11/12/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

import UIKit

public class FormValidator: NSObject, FormValidation {
    public var initialValidator : FieldValidator?
    var errors: Int = 0
    public var delegate: FormValidationDelegate?
    
    public override init() {
        super.init()
    }
    
    public func validate() {
        errors = 0
        initialValidator?.validate()
    }
    
    public func addFieldError() {
        ++errors
    }
    
    public func submit() {
        validate()
        
        if errors > 0 {
            delegate?.didFailFormValidation(self)
        }else{
            delegate?.didPassFormValidation(self)
        }
    }
}