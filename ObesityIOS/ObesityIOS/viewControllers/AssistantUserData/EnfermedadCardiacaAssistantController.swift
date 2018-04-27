//
//  EnfermedadCardiacaAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class EnfermedadCardiacaAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvEnfermedadCardiaca: UIPickerView!
    @IBOutlet weak var pbEnfermedadCardiaca: UIProgressView!
    
    let confirmacion = ["Si", "No"]
    
    override func viewDidLoad() {
        pvEnfermedadCardiaca.dataSource = self
        pvEnfermedadCardiaca.delegate = self
        super.viewDidLoad()

        pbEnfermedadCardiaca.setProgress(0.85, animated: false)

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
        performSegue(withIdentifier: "toFumadorAssistantSegue", sender: nil)
    }
    
}
