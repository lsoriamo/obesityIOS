//
//  PesoObjetivoAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class PesoObjetivoAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvPesoObjetivo: UIPickerView!
    @IBOutlet weak var pbPesoObjetivo: UIProgressView!
    
    var pesos = [Int]()
    
    var pesoUsuario:Int?
    
    override func viewDidLoad() {
        pvPesoObjetivo.dataSource = self
        pvPesoObjetivo.delegate = self
        super.viewDidLoad()

        pbPesoObjetivo.setProgress(0.935, animated: false)
        
        pesos = cargarPesos()
//        pvPesoObjetivo.
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
    
    func cargarPesos() -> Array<Int> {
        for i in 50...350 {
            pesos.append(i)
        }
        
        return pesos
    }

    @IBAction func actionBtnSiguiente(_ sender: Any) {
        performSegue(withIdentifier: "toEquipoMedicoAssistantSegue", sender: nil)
    }
}
