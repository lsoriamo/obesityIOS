//
//  DeporteAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DeporteAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvDeporte: UIPickerView!
    @IBOutlet weak var pbDeporte: UIProgressView!
    
    let eleccion = ["No practico", "Más de 3 meses", "Entre 1 y 3 meses", "Menos de un mes"]
    var userId:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        pvDeporte.dataSource = self
        pvDeporte.delegate = self
        super.viewDidLoad()
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        ref.child("users/\(userId!)/data").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            if let deporteRecibido:Int = value?["ejercicio"] as? Int {
                
                if deporteRecibido == 0 {
                    self.pvDeporte.selectRow(0, inComponent: 0, animated: false)
                } else if deporteRecibido == 16 {
                    self.pvDeporte.selectRow(1, inComponent: 0, animated: false)
                } else if deporteRecibido == 5 {
                    self.pvDeporte.selectRow(2, inComponent: 0, animated: false)
                } else {
                    self.pvDeporte.selectRow(3, inComponent: 0, animated: false)
                }
                
            }
            
        }
        
        pbDeporte.setProgress(0.85, animated: false)
        
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
        
        if pvDeporte.selectedRow(inComponent: 0) == 0 {
            self.ref.child("users/\(userId!)/data/ejercicio").setValue(0)
        } else if pvDeporte.selectedRow(inComponent: 0) == 1 {
            self.ref.child("users/\(userId!)/data/ejercicio").setValue(16)
        } else if pvDeporte.selectedRow(inComponent: 0) == 2 {
            self.ref.child("users/\(userId!)/data/ejercicio").setValue(5)
        } else {
            self.ref.child("users/\(userId!)/data/ejercicio").setValue(1)
        }
        
        performSegue(withIdentifier: "toFechaIntervencionAssistantSegue", sender: nil)
    }
    
}
