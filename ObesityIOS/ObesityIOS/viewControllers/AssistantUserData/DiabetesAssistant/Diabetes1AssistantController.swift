//
//  Diabetes1AssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 24/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class Diabetes1AssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pvDiabetes1: UIPickerView!
    @IBOutlet weak var pbDiabetes1: UIProgressView!
    
    let confirmacion = ["Si", "No"]
    
    override func viewDidLoad() {
        pvDiabetes1.dataSource = self
        pvDiabetes1.delegate = self
        super.viewDidLoad()
        
        pbDiabetes1.setProgress(0.5, animated: false)
        
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
    }
}
