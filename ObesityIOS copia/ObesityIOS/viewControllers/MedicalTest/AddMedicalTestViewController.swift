//
//  AddMedicalTestViewController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 24/5/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import SearchTextField

class AddMedicalTestViewController: UIViewController {

    @IBOutlet weak var tfTipoPrueba: SearchTextField!
    @IBOutlet weak var tfDescripcionPrueba: UITextField!
    @IBOutlet weak var tfMedico: SearchTextField!
    @IBOutlet weak var tfComentarioMedico: UITextField!
    @IBOutlet weak var dpFechaCita: UIDatePicker!
    @IBOutlet weak var tfPersonaPrueba: SearchTextField!
    @IBOutlet weak var tfLugarCita: UITextField!
    
    var arrTipoPrueba:[String] = ["Estudio gastroudenal", "Gastroscopia", "Ecografía abdominal", "Pruebas preanestesia", "Analítica"]
    
    var arrMedicos:[String] = ["Aliaga, Alberto", "Amores, Jorge", "Soria, Luismi"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dpFechaCita.locale = Locale(identifier: "es_ES")
        
        tfTipoPrueba.filterStrings(arrTipoPrueba)
        tfMedico.filterStrings(arrMedicos)
        tfPersonaPrueba.filterStrings(arrMedicos)

    }
    @IBAction func actionAddMedicalTest(_ sender: Any) {
        
    }
    
}
