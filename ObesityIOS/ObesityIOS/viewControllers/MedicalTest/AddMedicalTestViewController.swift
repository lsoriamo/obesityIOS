//
//  AddMedicalTestViewController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 24/5/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import SearchTextField
import FirebaseDatabase

class AddMedicalTestViewController: UIViewController {

    @IBOutlet weak var tfTipoPrueba: SearchTextField!
    @IBOutlet weak var tfDescripcionPrueba: UITextField!
    @IBOutlet weak var tfMedico: SearchTextField!
    @IBOutlet weak var tfComentarioMedico: UITextField!
    @IBOutlet weak var dpFechaCita: UIDatePicker!
    @IBOutlet weak var tfPersonaPrueba: SearchTextField!
    @IBOutlet weak var tfLugarCita: UITextField!
    
    var userId:String?
    var nombreApellidosMedico:String?
    
    var arrTipoPrueba:[String] = ["Estudio gastroudenal", "Gastroscopia", "Ecografía abdominal", "Pruebas preanestesia", "Analítica"]
    
    var arrMedicos:[String] = []
    var arrMedicosAux:[DoctorAux] = []
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        dpFechaCita.locale = Locale(identifier: "es_ES")
        
        tfTipoPrueba.filterStrings(arrTipoPrueba)
        
        loadDoctorsArr()

    }
    
    func loadDoctorsArr() {
        userId = UserDefaults.standard.string(forKey: "userId")
        
        ref.child("access/confirmation/\(userId!)").observeSingleEvent(of: .value) { (snapshot) in
            
            let dicDoctorsIds = snapshot.value as? NSDictionary
            
            for doctorId in dicDoctorsIds!.allKeys {
                self.ref.child("access/confirmation/\(self.userId!)/\(doctorId)").observeSingleEvent(of: .value) { (snapshot) in
                    
                    let doctorAux:DoctorAux = DoctorAux()
                    
                    let value = snapshot.value as? NSDictionary
                    
                    let medicalCenterId = value?["medicalCenterId"] as? String ?? ""
                    
                    doctorAux.doctorId = doctorId as! String
                    doctorAux.medicalCenterId = medicalCenterId
                    
                    self.ref.child("doctors/\(doctorId)").observeSingleEvent(of: .value) { (snapshot) in
                        
                        let value2 = snapshot.value as? NSDictionary
                        
                        let nombreMedico = value2?["name"] as? String ?? ""
                        let apellidosMedico = value2?["surname"] as? String ?? ""
                        
                        self.nombreApellidosMedico = "\(apellidosMedico), \(nombreMedico)"
                        
                        self.arrMedicosAux.append(doctorAux)
                        
                        print(self.nombreApellidosMedico!)
                        
                        self.arrMedicos.append(self.nombreApellidosMedico!)
                        self.tfMedico.filterStrings(self.arrMedicos)
                        self.tfPersonaPrueba.filterStrings(self.arrMedicos)
                    }
                    
                }
            }
        }
    }
    
    @IBAction func actionAddMedicalTest(_ sender: Any) {
        
    }
    
}
