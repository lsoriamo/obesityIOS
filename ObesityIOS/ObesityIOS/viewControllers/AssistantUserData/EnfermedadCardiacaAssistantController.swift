//
//  EnfermedadCardiacaAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EnfermedadCardiacaAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvEnfermedadCardiaca: UIPickerView!
    @IBOutlet weak var pbEnfermedadCardiaca: UIProgressView!
    
    let confirmacion = ["Si", "No"]
    var userId:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        pvEnfermedadCardiaca.dataSource = self
        pvEnfermedadCardiaca.delegate = self
        super.viewDidLoad()
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        ref.child("users/\(userId!)/data").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            if let isCardiaca:Bool = value?["cardiaca"] as? Bool {
                
                if isCardiaca {
                    self.pvEnfermedadCardiaca.selectRow(0, inComponent: 0, animated: false)
                } else {
                    self.pvEnfermedadCardiaca.selectRow(1, inComponent: 0, animated: false)
                }
                
            }
            
        }

        pbEnfermedadCardiaca.setProgress(0.68, animated: false)

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
        
        pvEnfermedadCardiaca.selectedRow(inComponent: 0) == 0 ? self.ref.child("users/\(userId!)/data/cardiaca").setValue(true) : self.ref.child("users/\(userId!)/data/cardiaca").setValue(false)
        
        performSegue(withIdentifier: "toFumadorAssistantSegue", sender: nil)
    }
    
}
