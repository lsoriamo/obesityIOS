//
//  MedicalTest.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 30/5/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import Foundation

class MedicalTest {
    
    var timestamp:Int64 = 0
    var citeTimestamp:Int64 = 0
    var name:String = ""
    
    init() {
    }
    
    init(timestamp:Int64, citeTimestamp:Int64, name:String) {
        self.timestamp = timestamp
        self.citeTimestamp = citeTimestamp
        self.name = name
    }
}
