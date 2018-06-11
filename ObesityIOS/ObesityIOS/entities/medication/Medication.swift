//
//  Medication.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 7/6/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import Foundation

class Medication {
    
    var timestamp:Double = 0
    var iduser:String = ""
    var medicine:String = ""
    var observations:String = ""
    var begin_timestamp:Double = 0
    var end_timestamp:Double = 0
    var method:String = ""
    var days:String = ""
    var dosage:String = ""
    var createdBy:String = ""
    var userViewTimestamp:Double = 0
    var sideEffects:[MedicationSideEffect] = []
    
    init() {
    }
    
    init(timestamp:Double, iduser:String, medicine:String, observations:String, begin_timestamp:Double, end_timestamp:Double, method:String, days:String, dosage:String, createdBy:String, userViewTimestamp:Double, sideEffects:[MedicationSideEffect]) {
        
        self.timestamp = timestamp
        self.iduser = iduser
        self.observations = observations
        self.begin_timestamp = begin_timestamp
        self.end_timestamp = end_timestamp
        self.method = method
        self.days = days
        self.dosage = dosage
        self.createdBy = createdBy
        self.userViewTimestamp = userViewTimestamp
        self.sideEffects = sideEffects
    }
}
