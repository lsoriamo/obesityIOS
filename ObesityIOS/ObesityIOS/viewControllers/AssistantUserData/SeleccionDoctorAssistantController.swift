//
//  SeleccionDoctorAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class SeleccionDoctorAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvSeleccionDoctor: UIPickerView!
    @IBOutlet weak var pbSeleccionDoctor: UIProgressView!
    
    // ARRAY TIENE QUE SER CARGADO POR BASE DE DATOS
    var medicos = ["Aliaga Verdugo, Alberto", "Soria Morillo, Luismi", "Morales Conde, Salvador", "Amores Ortiz, Jorge"]
    
    override func viewDidLoad() {
        pvSeleccionDoctor.dataSource = self
        pvSeleccionDoctor.delegate = self
        super.viewDidLoad()
        
        pbSeleccionDoctor.setProgress(1, animated: false)

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return medicos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return medicos[row]
    }
    
    @IBAction func actionBtnFinalizar(_ sender: Any) {
        performSegue(withIdentifier: "toWaitConfirmationAssistantSegue", sender: nil)
    }
    
}
