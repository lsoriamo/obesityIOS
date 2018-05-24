//
//  NewAppointmentViewController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 24/5/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import SearchTextField

class NewAppointmentViewController: UIViewController {

    @IBOutlet weak var tfDoctor: SearchTextField!
    @IBOutlet weak var tfEspecialidad: UITextField!
    @IBOutlet weak var dpAppointmentDate: UIDatePicker!
    @IBOutlet weak var tfDescripcion: UITextField!
    @IBOutlet weak var tfLugar: UITextField!
    @IBOutlet weak var tfNoOlvidar: UITextField!
    
    var arrMedicos:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrMedicos.append("Soria, Luismi (endocrino)")
        arrMedicos.append("Aliaga, Alberto (endocrino)")
        arrMedicos.append("Amores, Jorge (cirujano)")
        
        tfDoctor.filterStrings(arrMedicos)

    }

}
