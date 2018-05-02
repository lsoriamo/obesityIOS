//
//  LesionArticularAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class LesionArticularAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvLesionArticular: UIPickerView!
    @IBOutlet weak var pbLesionArticular: UIProgressView!
    
    let confirmacion = ["Si", "No"]
    
    override func viewDidLoad() {
        pvLesionArticular.dataSource = self
        pvLesionArticular.delegate = self
        super.viewDidLoad()
        
        pbLesionArticular.setProgress(0.51, animated: false)
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
        performSegue(withIdentifier: "toColesterolAssistantSegue", sender: nil)
    }
}
