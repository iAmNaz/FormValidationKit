//
//  FormValidator.swift
//  FormValidator
//
//  Created by JMariano on 11/12/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

import UIKit

open class FormValidator: NSObject, FormValidation {
    open var initialValidator : FieldValidator?
    var errors: Int = 0
    open var delegate: FormValidationDelegate?
    
    public override init() {
        super.init()
    }
    
    open func validate() {
        errors = 0
        initialValidator?.validate()
    }
    
    open func addFieldError() {
        errors += 1
    }
    
    open func submit() {
        validate()
        
        if errors > 0 {
            delegate?.didFailFormValidation(self)
        }else{
            delegate?.didPassFormValidation(self)
        }
    }
}
