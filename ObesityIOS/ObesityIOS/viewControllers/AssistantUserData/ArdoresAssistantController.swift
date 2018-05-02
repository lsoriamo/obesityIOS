//
//  ArdoresAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class ArdoresAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvArdores: UIPickerView!
    @IBOutlet weak var pbArdores: UIProgressView!
    
    let eleccion = ["No", "Sí, esporádico", "Sí, frecuentemente"]
    
    override func viewDidLoad() {
        pvArdores.dataSource = self
        pvArdores.delegate = self
        super.viewDidLoad()

        pbArdores.setProgress(0.782, animated: false)
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
        performSegue(withIdentifier: "toReflujoAssistantSegue", sender: nil)
    }
    

}
