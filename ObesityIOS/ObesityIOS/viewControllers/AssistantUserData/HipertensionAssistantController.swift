//
//  HipertensionAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 24/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HipertensionAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pbHipertension: UIProgressView!
    
    @IBOutlet weak var pvHipertension: UIPickerView!
    
    let confirmacion = ["Si", "No"]
    var userId:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        pvHipertension.dataSource = self
        pvHipertension.delegate = self
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")

        pbHipertension.setProgress(0.34, animated: false)

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
        
        pvHipertension.selectedRow(inComponent: 0) == 0 ? self.ref.child("users/\(userId!)/data/hipertension").setValue(true) : self.ref.child("users/\(userId!)/data/hipertension").setValue(false)
        
        performSegue(withIdentifier: "toDiabetes1AssistantSegue", sender: nil)
    }
}
