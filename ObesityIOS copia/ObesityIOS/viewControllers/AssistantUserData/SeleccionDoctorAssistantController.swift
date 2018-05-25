//
//  SeleccionDoctorAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SeleccionDoctorAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvSeleccionDoctor: UIPickerView!
    @IBOutlet weak var pbSeleccionDoctor: UIProgressView!
    
    var medicos:[String] = []
    var userId:String?
    var idHospitalSelected:String?

    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        pvSeleccionDoctor.dataSource = self
        pvSeleccionDoctor.delegate = self
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        idHospitalSelected = UserDefaults.standard.string(forKey: "hospitalSelected")
        
        ref.child("medicalCenters/\(idHospitalSelected!)/doctors").observeSingleEvent(of: .value) { (snapshot) in
            
            let dicDoctores = snapshot.value as? NSDictionary
            
            print(dicDoctores!.allKeys)
            
            for idDoctor in dicDoctores!.allKeys {
                self.ref.child("medicalCenters/\(self.idHospitalSelected!)/doctors/\(idDoctor)").observeSingleEvent(of: .value) { (snapshot) in
                    
                    let value = snapshot.value as? NSDictionary
                    
                    let nombre = value?["name"] as? String ?? ""
                    let apellidos = value?["surname"] as? String ?? ""

                    self.medicos.append("\(apellidos), \(nombre)")

                    self.pvSeleccionDoctor.reloadAllComponents()
                }
            }
        }
        
        pbSeleccionDoctor.setProgress(1, animated: false)

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return medicos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return medicos[row]
    }
    
    @IBAction func actionBtnFinalizar(_ sender: Any) {
        performSegue(withIdentifier: "toWaitConfirmationAssistantSegue", sender: nil)
    }
    
}
