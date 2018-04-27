//
//  PiedrasAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class PiedrasAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pvPiedras: UIPickerView!
    @IBOutlet weak var pbPiedras: UIProgressView!
    
    let confirmacion = ["Si", "No"]

    override func viewDidLoad() {
        pvPiedras.dataSource = self
        pvPiedras.delegate = self
        super.viewDidLoad()

        pbPiedras.setProgress(0.75, animated: false)

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
        performSegue(withIdentifier: "toHigadoAssistantSegue", sender: nil)
    }
}
