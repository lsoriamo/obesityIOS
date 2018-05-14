//
//  DiabetesMedicacionPrescritaController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 24/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DiabetesMedicacionPrescritaController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvMedicamentoPrescrito: UIPickerView!
    @IBOutlet weak var pbMedicamentoPrescrito: UIProgressView!
    
    let medicamentosPrescritos = ["No padezco", "Antidabéticos orales", "Insulina", "Ambos tratamientos"]
    var userId:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        pvMedicamentoPrescrito.dataSource = self
        pvMedicamentoPrescrito.delegate = self
        super.viewDidLoad()
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        pbMedicamentoPrescrito.setProgress(0.442, animated: false)

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return medicamentosPrescritos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return medicamentosPrescritos[row]
    }
    
    @IBAction func actionBtnSIguiente(_ sender: Any) {
        
        self.ref.child("users/\(userId!)/data/diabetes_prescripcion").setValue(pvMedicamentoPrescrito.selectedRow(inComponent: 0))
        
        performSegue(withIdentifier: "toTrastornoSueñoAssistantSegue", sender: nil)
    }
    
}
