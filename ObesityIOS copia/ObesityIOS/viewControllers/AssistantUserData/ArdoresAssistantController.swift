//
//  ArdoresAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ArdoresAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvArdores: UIPickerView!
    @IBOutlet weak var pbArdores: UIProgressView!
    
    let eleccion = ["No", "Sí, esporádico", "Sí, frecuentemente"]
    var userId:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        pvArdores.dataSource = self
        pvArdores.delegate = self
        super.viewDidLoad()
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        ref.child("users/\(userId!)/data").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            if let ardoresRecibidos:Int = value?["ardores"] as? Int {
                
               self.pvArdores.selectRow(ardoresRecibidos, inComponent: 0, animated: false)
                
            }
            
        }

        pbArdores.setProgress(0.782, animated: false)
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
        
        self.ref.child("users/\(userId!)/data/ardores").setValue(pvArdores.selectedRow(inComponent: 0))
        
        performSegue(withIdentifier: "toReflujoAssistantSegue", sender: nil)
    }
    

}
