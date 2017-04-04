//
//  ArrayIteratorNZ.swift
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


open class ValidatorIterator: NSObject, IteratorNZ {
    var mutableList: Array<Validator>?
    var position: Int
    
    required public init(listItems: Array<Validator>) {
        mutableList = listItems
        position = 0;
    }
    
    func next() -> Validator {
        let object = mutableList?[position]
        position += 1;
        return object!;
    }
    
    func hasNext() -> Bool {
        if (position >= mutableList?.count || mutableList?[position] == nil) {
            return false;
        } else {
            return true;
        }
    }
    
    open func reset() {
        position = 0
    }
}
