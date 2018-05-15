//
//  Diabetes1AssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 24/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Diabetes1AssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pvDiabetes1: UIPickerView!
    @IBOutlet weak var pbDiabetes1: UIProgressView!
    
    let confirmacion = ["Si", "No"]
    var userId:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        pvDiabetes1.dataSource = self
        pvDiabetes1.delegate = self
        super.viewDidLoad()
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        ref.child("users/\(userId!)/data").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            if let isDiabetes1:Bool = value?["diabetes1"] as? Bool {
                
                if isDiabetes1 {
                    self.pvDiabetes1.selectRow(0, inComponent: 0, animated: false)
                } else {
                    self.pvDiabetes1.selectRow(1, inComponent: 0, animated: false)
                }
                
            }
            
        }
        
        pbDiabetes1.setProgress(0.374, animated: false)
        
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
        
        pvDiabetes1.selectedRow(inComponent: 0) == 0 ? self.ref.child("users/\(userId!)/data/diabetes1").setValue(true) : self.ref.child("users/\(userId!)/data/diabetes1").setValue(false)
        
        performSegue(withIdentifier: "toDiabetes2AssistantSegue", sender: nil)
    }
}
