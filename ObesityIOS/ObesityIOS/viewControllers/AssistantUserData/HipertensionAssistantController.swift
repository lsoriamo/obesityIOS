//
//  HipertensionAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 24/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class HipertensionAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pbHipertension: UIProgressView!
    
    @IBOutlet weak var pvHipertension: UIPickerView!
    
    let confirmacion = ["Si", "No"]
    
    override func viewDidLoad() {
        pvHipertension.dataSource = self
        pvHipertension.delegate = self
        super.viewDidLoad()

        pbHipertension.setProgress(0.45, animated: false)

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
        performSegue(withIdentifier: "toDiabetes1AssistantSegue", sender: nil)
    }
}
