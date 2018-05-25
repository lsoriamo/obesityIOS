//
//  LesionArticularAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class LesionArticularAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvLesionArticular: UIPickerView!
    @IBOutlet weak var pbLesionArticular: UIProgressView!
    
    let confirmacion = ["Si", "No"]
    var userId:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        pvLesionArticular.dataSource = self
        pvLesionArticular.delegate = self
        super.viewDidLoad()
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        ref.child("users/\(userId!)/data").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            if let isLesionArticular:Bool = value?["lesion_articular"] as? Bool {
                
                if isLesionArticular {
                    self.pvLesionArticular.selectRow(0, inComponent: 0, animated: false)
                } else {
                    self.pvLesionArticular.selectRow(1, inComponent: 0, animated: false)
                }
                
            }
            
        }
        
        pbLesionArticular.setProgress(0.51, animated: false)
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
        
        pvLesionArticular.selectedRow(inComponent: 0) == 0 ? self.ref.child("users/\(userId!)/data/lesion_articular").setValue(true) : self.ref.child("users/\(userId!)/data/lesion_articular").setValue(false)
        
        performSegue(withIdentifier: "toColesterolAssistantSegue", sender: nil)
    }
}
