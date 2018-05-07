//
//  FumadorAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class FumadorAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvFumador: UIPickerView!
    @IBOutlet weak var pbFumador: UIProgressView!
    
    let eleccion = ["No fumo", "Menos de 10", "Entre 10 y 20", "Más de una cajetilla"]
    
    override func viewDidLoad() {
        pvFumador.dataSource = self
        pvFumador.delegate = self
        super.viewDidLoad()

        pbFumador.setProgress(0.714, animated: false)
    
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
        performSegue(withIdentifier: "toAlcoholAssistantSegue", sender: nil)
    }
}
