//
//  MedicationSideEffect.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 7/6/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import Foundation

class MedicationSideEffect {
    var timestamp:Int64 = 0
    var cuando:String = ""
    var donde:String = ""
    var porque:String = ""
    
    init() {
    }
    
    init(timestamp:Int64, cuando:String, donde:String, porque:String) {
        self.timestamp = timestamp
        self.cuando = cuando
        self.donde = donde
        self.porque = porque
    }
}
