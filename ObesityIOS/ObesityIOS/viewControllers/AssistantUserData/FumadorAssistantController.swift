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
    
    let eleccion = ["No fumo", "Fumo menos de 10 cigarros al día", "Fumo entre 10 y 20 cigarros al día", "Fumo más de una cajetilla al día"]
    
    override func viewDidLoad() {
        pvFumador.dataSource = self
        pvFumador.delegate = self
        super.viewDidLoad()

        pbFumador.setProgress(0.9, animated: false)
    
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
