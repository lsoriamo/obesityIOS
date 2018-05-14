//
//  TratamientoReflujoAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TratamientoReflujoAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvTratamientoReflujo: UIPickerView!
    @IBOutlet weak var pbTratamientoReflujo: UIProgressView!
    
    let confirmacion = ["Sí", "No"]
    var userId:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        pvTratamientoReflujo.dataSource = self
        pvTratamientoReflujo.delegate = self
        super.viewDidLoad()
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        pbTratamientoReflujo.setProgress(0.816, animated: false)
        
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
        
        pvTratamientoReflujo.selectedRow(inComponent: 0) == 0 ? self.ref.child("users/\(userId!)/data/tto_reflujo").setValue(true) : self.ref.child("users/\(userId!)/data/tto_reflujo").setValue(false)
        
        performSegue(withIdentifier: "toDeporteAssistantSegue", sender: nil)
    }
    
}
