//
//  Iterator.swift
//  FormValidator
//
//  Created by JMariano on 11/11/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

import UIKit

protocol IteratorNZ {
    init(listItems: Array<Validator>)
    func next() -> Validator
    func hasNext() -> Bool
    func reset() 
}
