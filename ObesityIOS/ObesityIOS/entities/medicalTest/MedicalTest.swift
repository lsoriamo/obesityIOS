//
//  MedicalTest.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 30/5/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import Foundation

class MedicalTest {
    
    var citeTimestamp:Int64 = 0
    var name:String = ""
    
    init() {
    }
    
    init(citeTimestamp:Int64, name:String) {
        self.citeTimestamp = citeTimestamp
        self.name = name
    }
}
