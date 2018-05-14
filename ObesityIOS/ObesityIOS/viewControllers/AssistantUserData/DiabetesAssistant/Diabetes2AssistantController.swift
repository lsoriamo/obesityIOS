//
//  Diabetes2AssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 24/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Diabetes2AssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvDiabetes2: UIPickerView!
    @IBOutlet weak var pbDiabetes2: UIProgressView!
    
    let confirmacion = ["Si", "No"]
    var userId:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        pvDiabetes2.dataSource = self
        pvDiabetes2.delegate = self
        super.viewDidLoad()
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        pbDiabetes2.setProgress(0.408, animated: false)

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
        
        pvDiabetes2.selectedRow(inComponent: 0) == 0 ? self.ref.child("users/\(userId!)/data/diabetes2").setValue(true) : self.ref.child("users/\(userId!)/data/diabetes2").setValue(false)
        
        performSegue(withIdentifier: "toMedicacionPrescritaDiabetesAssistantSegue", sender: nil)
    }
}
