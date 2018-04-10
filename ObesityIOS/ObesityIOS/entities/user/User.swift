//
//  User.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 10/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import Foundation

class User {
    var iduser: String = ""
    var name: String = ""
    var surname: String = ""
    var nickname: String = ""
    var passhash: String = ""
    var email: String = ""
    var image: String = ""
    var sex: Int = 0
    var profesion: String = ""
    var phone: String = ""
    
    init(iduser: String, name:String, surname:String, nickname:String, passhash:String, email:String,
         image:String, sex: Int, profesion:String, phone:String) {
        self.iduser = iduser
        self.name = name
        self.surname = surname
        self.nickname = nickname
        self.passhash = passhash
        self.email = email
        self.image = image
        self.sex = sex
        self.profesion = profesion
        self.phone = phone
    }
    
    init() {
    }
}
