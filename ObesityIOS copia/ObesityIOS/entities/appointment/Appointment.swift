//
//  Appointment.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 18/5/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import Foundation

class Appointment {
    var timestamp:Int64 = -1
    var citeTimestamp:Int64 = -1
    var doctorId:String = ""
    var doctor:String = ""
    var description:String = ""
    var place:String = ""
    var things:String = ""
    var idUser:String = ""
    var type:Int = -1
    var typeEnum:String = ""
    var createdBy:String = ""
    var userViewTimestamp:Int64 = -1
    
    init() {
    }
    
    init(timestamp:Int64, citeTimestamp:Int64, doctorId:String, doctor:String, descripction:String, description:String, place:String, things:String,
         idUser:String, type:Int, createdBy:String, userViewTimestamp:Int64) {
        self.timestamp = timestamp
        self.citeTimestamp = citeTimestamp
        self.doctorId = doctorId
        self.doctor = doctor
        self.description = description
        self.place = place
        self.things = things
        self.idUser = idUser
        self.type = type
        self.createdBy = createdBy
        self.userViewTimestamp = userViewTimestamp
    }
    
}
