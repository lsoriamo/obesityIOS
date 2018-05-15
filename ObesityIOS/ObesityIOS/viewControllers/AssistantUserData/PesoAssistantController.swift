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
        
        pesos = cargarPesos()
        
        ref.child("users/\(userId!)/data").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let pesoRecibido:Int = value?["peso"] as? Int ?? -1
            
            if pesoRecibido != -1 {
                
                let indexPeso = self.findPeso(peso: pesoRecibido)
                
                self.pvPeso.selectRow(indexPeso, inComponent: 0, animated: false)
                
            } else {
                
                self.pvPeso.selectRow(100, inComponent: 0, animated: true)
                
            }
            
        }
        
        pbPeso.setProgress(0.272, animated: false)

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
    
    func findPeso(peso:Int) -> Int {
        var i:Int = 0
        
        for p in pesos {
            if p == peso {
                return i
            }
            i = i+1
        }
        
        return 0
    }
    
    func cargarPesos() -> Array<Int> {
        for i in 50...350 {
            pesos.append(i)
        }
        return pesos
    }
}
