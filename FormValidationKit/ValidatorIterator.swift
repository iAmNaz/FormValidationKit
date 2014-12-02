//
//  ArrayIteratorNZ.swift
//  FormValidator
//
//  Created by JMariano on 11/11/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

import UIKit

public class ValidatorIterator: NSObject, IteratorNZ {
    var mutableList: Array<Validator>?
    var position: Int
    
    required public init(listItems: Array<Validator>) {
        mutableList = listItems
        position = 0;
    }
    
    func next() -> Validator {
        var object = mutableList?[position]
        position++;
        return object!;
    }
    
    func hasNext() -> Bool {
        if (position >= mutableList?.count || mutableList?[position] == nil) {
            return false;
        } else {
            return true;
        }
    }
    
    public func reset() {
        position = 0
    }
}
