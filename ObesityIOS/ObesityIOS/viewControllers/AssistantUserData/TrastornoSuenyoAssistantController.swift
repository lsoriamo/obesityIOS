//
//  TrastornoSuenyoAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 25/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class TrastornoSuenyoAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvTrastornoSuenyo: UIPickerView!
    @IBOutlet weak var pbTrastornoSuenyo: UIProgressView!
    
    let confirmacion = ["Si", "No"]
    
    override func viewDidLoad() {
        pvTrastornoSuenyo.dataSource = self
        pvTrastornoSuenyo.delegate = self
        super.viewDidLoad()

        pbTrastornoSuenyo.setProgress(0.65, animated: false)
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
        performSegue(withIdentifier: "toLesionArticularAssistantSegue", sender: nil)
    }
    
}
