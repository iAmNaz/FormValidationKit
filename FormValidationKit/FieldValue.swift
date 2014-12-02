//
//  FieldValue.swift
//  FormValidator
//
//  Created by JMariano on 11/12/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

import UIKit

public class FieldValue: NSObject {
    public class func textValue(object: NSObject) -> String {
        var text : String?
        if object.respondsToSelector(Selector("text")) {
            if object is UITextField {
                text = (object as UITextField).text
            }else if object is UITextView {
                text = (object as UITextView).text
            } else if object is UILabel {
                text = (object as UILabel).text
            }
        }
        return text!
    }
}
