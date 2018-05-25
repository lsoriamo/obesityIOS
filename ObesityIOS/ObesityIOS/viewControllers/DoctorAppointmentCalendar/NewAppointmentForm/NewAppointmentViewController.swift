//
//  NewAppointmentViewController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 24/5/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import SearchTextField
import FirebaseDatabase

class NewAppointmentViewController: UIViewController {

    @IBOutlet weak var tfDoctor: SearchTextField!
    @IBOutlet weak var tfEspecialidad: UITextField!
    @IBOutlet weak var dpAppointmentDate: UIDatePicker!
    @IBOutlet weak var tfDescripcion: UITextField!
    @IBOutlet weak var tfLugar: UITextField!
    @IBOutlet weak var tfNoOlvidar: UITextField!
    
    var arrMedicos:[String] = []
    var arrMedicosAux:[DoctorAux] = []
    
    var userId:String?
    var nombreApellidosMedico:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        loadDoctorsArr()
        
        dpAppointmentDate.locale = Locale(identifier: "es_ES")
        
//        arrMedicos.append("Soria, Luismi (endocrino)")
//        arrMedicos.append("Aliaga, Alberto (endocrino)")
//        arrMedicos.append("Amores, Jorge (cirujano)")
//
//        tfDoctor.filterStrings(arrMedicos)

    }
    
    func loadDoctorsArr() {
        userId = UserDefaults.standard.string(forKey: "userId")
        
        
        ref.child("access/confirmation/\(userId!)").observeSingleEvent(of: .value) { (snapshot) in
            
            let dicDoctorIds = snapshot.value as? NSDictionary
            
            for doctorId in dicDoctorIds!.allKeys {
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
                        
                        self.arrMedicos.append(self.nombreApellidosMedico!)
                        
                        self.tfDoctor.filterStrings(self.arrMedicos)
                        
                    }
                    
                    
                    
                    
                }
                
                
                
            }
            
        }
        
    }
    
    @IBAction func actionBtnAddAppointment(_ sender: Any) {
    }
    
}
