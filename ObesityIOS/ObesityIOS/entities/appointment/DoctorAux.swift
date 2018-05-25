//
//  DoctorAux.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 25/5/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import Foundation

class DoctorAux {
    var doctorId:String = ""
    var medicalCenterId:String = ""
    
    init() {
    }
    
    init(doctorId:String, medicalCenterId:String) {
        self.doctorId = doctorId
        self.medicalCenterId = medicalCenterId
    }
}
