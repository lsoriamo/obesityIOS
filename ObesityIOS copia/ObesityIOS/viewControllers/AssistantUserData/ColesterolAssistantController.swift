//
//  ColesterolAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ColesterolAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvColesterol: UIPickerView!
    @IBOutlet weak var pbColesterol: UIProgressView!
    
    let confirmacion = ["Si", "No"]
    var userId:String?
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        pvColesterol.dataSource = self
        pvColesterol.delegate = self
        super.viewDidLoad()
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        ref.child("users/\(userId!)/data").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            if let isColesterol:Bool = value?["hiperlipidemia"] as? Bool {
                
                if isColesterol {
                    self.pvColesterol.selectRow(0, inComponent: 0, animated: false)
                } else {
                    self.pvColesterol.selectRow(1, inComponent: 0, animated: false)
                }
                
            }
            
        }
        
        pbColesterol.setProgress(0.544, animated: false)

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
        
        pvColesterol.selectedRow(inComponent: 0) == 0 ? self.ref.child("users/\(userId!)/data/hiperlipidemia").setValue(true) : self.ref.child("users/\(userId!)/data/hiperlipidemia").setValue(false)
        
        performSegue(withIdentifier: "toPiedrasAssistantSegue", sender: nil)
    }
    

}
