//
//  TratamientoReflujoAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class TratamientoReflujoAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvTratamientoReflujo: UIPickerView!
    @IBOutlet weak var pbTratamientoReflujo: UIProgressView!
    
    let confirmacion = ["Sí", "No"]
    
    override func viewDidLoad() {
        pvTratamientoReflujo.dataSource = self
        pvTratamientoReflujo.delegate = self
        super.viewDidLoad()

        pbTratamientoReflujo.setProgress(0.9, animated: false)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return confirmacion.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return confirmacion[row]
    }
    
    @IBAction func actionBtnSiguiente(_ sender: Any) {
        performSegue(withIdentifier: "toDeporteAssistantSegue", sender: nil)
    }
    
}
