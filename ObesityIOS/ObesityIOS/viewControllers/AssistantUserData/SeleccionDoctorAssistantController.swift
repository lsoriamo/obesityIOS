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
    var indexHospitalSelected:Int?

    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        pvSeleccionDoctor.dataSource = self
        pvSeleccionDoctor.delegate = self
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        indexHospitalSelected = UserDefaults.standard.integer(forKey: "hospitalSelected")
        
//        ref.child("medicalCenters/\()").observeSingleEvent(of: .value) { (snapshot) in
//            
//            let dicHospitales = snapshot.value as? NSDictionary
//            
//            print(dicHospitales!.allKeys)
//            
//            for idHospital in dicHospitales!.allKeys {
//                self.ref.child("medicalCenters/\(idHospital)/doctors").observeSingleEvent(of: .value) { (snapshot) in
//                    
////                    let value = snapshot.value as? NSDictionary
////                    let nombreHospital = value?["name"] as? String ?? ""
////
////                    self.equiposMedico.append(nombreHospital)
////
////                    self.pvEquipoMedico.reloadAllComponents()
//                }
//            }
//        }
        
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
