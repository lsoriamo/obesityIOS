//
//  PesoAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 24/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PesoAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pbPeso: UIProgressView!
    @IBOutlet weak var pvPeso: UIPickerView!
    
    var pesos = [Int]()
    var userId:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        pvPeso.dataSource = self
        pvPeso.delegate = self
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
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
        UserDefaults.standard.set(pesos[pvPeso.selectedRow(inComponent: 0)], forKey: "pesoUsuario")
        
        self.ref.child("users/\(userId!)/data/peso").setValue(pesos[pvPeso.selectedRow(inComponent: 0)])
        
        performSegue(withIdentifier: "toFotoAssistantSegue", sender: nil)
    }
    
    func cargarPesos() -> Array<Int> {
        for i in 50...350 {
            pesos.append(i)
        }
        return pesos
    }
}
