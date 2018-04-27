//
//  DeporteAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class DeporteAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvDeporte: UIPickerView!
    @IBOutlet weak var pbDeporte: UIProgressView!
    
    let eleccion = ["Nunca", "Hace años que no hago deporte", "Menos de un mes", "Entre 1 y 3 meses", "Más de 3 meses"]
    
    override func viewDidLoad() {
        pvDeporte.dataSource = self
        pvDeporte.delegate = self
        super.viewDidLoad()
        
        pbDeporte.setProgress(0.9, animated: false)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return eleccion.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return eleccion[row]
    }
    
    @IBAction func actionBtnSiguiente(_ sender: Any) {
        performSegue(withIdentifier: "toFechaIntervencionAssistantSegue", sender: nil)
    }
    
}
