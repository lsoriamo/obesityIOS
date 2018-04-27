//
//  ColesterolAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class ColesterolAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvColesterol: UIPickerView!
    @IBOutlet weak var pbColesterol: UIProgressView!
    
    let confirmacion = ["Si", "No"]

    override func viewDidLoad() {
        pvColesterol.dataSource = self
        pvColesterol.delegate = self
        super.viewDidLoad()
        
        pbColesterol.setProgress(0.75, animated: false)

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
        performSegue(withIdentifier: "toPiedrasAssistantSegue", sender: nil)
    }
    

}
