//
//  HuesosAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HuesosAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvHuesos: UIPickerView!
    @IBOutlet weak var pbHuesos: UIProgressView!
    
    let confirmacion = ["Si", "No"]
    var userId:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        pvHuesos.dataSource = self
        pvHuesos.delegate = self
        super.viewDidLoad()
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        ref.child("users/\(userId!)/data").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            if let iaOsteoporosis:Bool = value?["osteoporosis"] as? Bool {
                
                if iaOsteoporosis {
                    self.pvHuesos.selectRow(0, inComponent: 0, animated: false)
                } else {
                    self.pvHuesos.selectRow(1, inComponent: 0, animated: false)
                }
                
            }
            
        }

        pbHuesos.setProgress(0.646, animated: false)
        
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
    
    @IBAction func actionBtnSIguiente(_ sender: Any) {
        
        pvHuesos.selectedRow(inComponent: 0) == 0 ? self.ref.child("users/\(userId!)/data/osteoporosis").setValue(true) : self.ref.child("users/\(userId!)/data/osteoporosis").setValue(false)
        
        performSegue(withIdentifier: "toEnfermedadCardiacaAssistantSegue", sender: nil)
    }
    
}
