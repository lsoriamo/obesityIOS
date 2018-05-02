//
//  EquipoMedicoAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class EquipoMedicoAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvEquipoMedico: UIPickerView!
    @IBOutlet weak var pbEquipoMedico: UIProgressView!
    
    // ARRAY TIENE QUE SER CARGADO POR BASE DE DATOS
    var equiposMedico = ["Quirón Sagrado Corazón (Sevilla, España)"]
    
    override func viewDidLoad() {
        pvEquipoMedico.dataSource = self
        pvEquipoMedico.delegate = self
        super.viewDidLoad()
        
        pbEquipoMedico.setProgress(0.975, animated: false)

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return equiposMedico.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return equiposMedico[row]
    }

    @IBAction func actionBtnSiguiente(_ sender: Any) {
        performSegue(withIdentifier: "toSeleccionDoctorAssistantSegue", sender: nil)
    }
}
