//
//  PesoAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 24/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class PesoAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pbPeso: UIProgressView!
    @IBOutlet weak var pvPeso: UIPickerView!
    
    var pesos = [Int]()
    
    override func viewDidLoad() {
        pvPeso.dataSource = self
        pvPeso.delegate = self
        super.viewDidLoad()
        
        pbPeso.setProgress(0.272, animated: false)

        pesos = cargarPesos()
        
        pvPeso.selectRow(100, inComponent: 0, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pesos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pesos[row])
    }

    @IBAction func actionBtnSiguiente(_ sender: Any) {
        UserDefaults.standard.set(pvPeso.selectedRow(inComponent: 0), forKey: "pesoUsuario")
        
        performSegue(withIdentifier: "toFotoAssistantSegue", sender: nil)
    }
    
    func cargarPesos() -> Array<Int> {
        for i in 50...350 {
            pesos.append(i)
        }
        return pesos
    }
}
