//
//  AlturaAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 24/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class AlturaAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pvAltura: UIPickerView!
    @IBOutlet weak var pbAltura: UIProgressView!
    
    var alturas = [Int]()
    
    override func viewDidLoad() {
        pvAltura.dataSource = self
        pvAltura.delegate = self
        super.viewDidLoad()
        
        pbAltura.setProgress(0.238, animated: false)
        
        alturas = cargarAlturas()
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return alturas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(alturas[row])
    }

    @IBAction func actionBtnSiguiente(_ sender: Any) {
        performSegue(withIdentifier: "toPesoAssistantSegue", sender: nil)
    }
    
    func cargarAlturas() -> Array<Int> {
        for i in 100...250 {
            alturas.append(i)
        }
        
        return alturas
    }
}
