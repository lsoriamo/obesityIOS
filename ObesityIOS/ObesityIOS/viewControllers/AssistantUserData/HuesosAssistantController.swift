//
//  HuesosAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class HuesosAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvHuesos: UIPickerView!
    @IBOutlet weak var pbHuesos: UIProgressView!
    
    let confirmacion = ["Si", "No"]
    
    override func viewDidLoad() {
        pvHuesos.dataSource = self
        pvHuesos.delegate = self
        super.viewDidLoad()

        pbHuesos.setProgress(0.646, animated: false)
        
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
    
    @IBAction func actionBtnSIguiente(_ sender: Any) {
        performSegue(withIdentifier: "toEnfermedadCardiacaAssistantSegue", sender: nil)
    }
    
}
