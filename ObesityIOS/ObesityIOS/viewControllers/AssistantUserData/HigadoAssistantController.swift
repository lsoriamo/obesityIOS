//
//  HigadoAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class HigadoAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvHigado: UIPickerView!
    @IBOutlet weak var pbHigado: UIProgressView!
    
    let confirmacion = ["Si", "No"]

    
    override func viewDidLoad() {
        pvHigado.dataSource = self
        pvHigado.delegate = self
        super.viewDidLoad()

        pbHigado.setProgress(0.612, animated: false)
        
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
        performSegue(withIdentifier: "toHuesosAssistantSegue", sender: nil)
    }
    
}
