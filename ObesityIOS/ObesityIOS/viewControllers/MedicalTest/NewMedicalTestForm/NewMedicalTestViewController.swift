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
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        dpFechaCita.locale = Locale(identifier: "es_ES")
        
        tfTipoPrueba.filterStrings(arrTipoPrueba)
        
        loadDoctorsArr()

    }
    
    func loadDoctorsArr() {
        
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
                        
                        doctorAux.apellidosNombre = self.nombreApellidosMedico!
                        
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
        
        let tipoPrueba:String = tfTipoPrueba.text!
        var innerTypePrueba:Int = 0
        let descripcion:String = tfDescripcionPrueba.text!
        let medicoIndica:String = tfMedico.text!
        let comentarioMedico:String = tfComentarioMedico.text!
        let personaPrueba:String = tfPersonaPrueba.text!
        let lugarCita:String = tfLugarCita.text!
        
        if tipoPrueba.isEmpty {
            // Creando un elemento de Alert (Dialog en Android)
            let alert = UIAlertController(title: "", message: "El tipo de prueba no puede quedar vacío", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // <-- Fin de Alert -->
        } else {
            
            var idDoctor:String = ""
            var idDoctor2:String = ""
            
            for item in arrMedicosAux {
                if medicoIndica == item.apellidosNombre {
                    idDoctor = item.doctorId
                }
            }
            
            for item in arrMedicosAux {
                if personaPrueba == item.apellidosNombre {
                    idDoctor2 = item.doctorId
                }
            }
            
            if tipoPrueba.caseInsensitiveCompare("Estudio gastroudenal") == ComparisonResult.orderedSame {
                innerTypePrueba = 1
            } else if tipoPrueba.caseInsensitiveCompare("Gastroscopia") == ComparisonResult.orderedSame {
                innerTypePrueba = 2
            } else if tipoPrueba.caseInsensitiveCompare("Ecografía abdominal") == ComparisonResult.orderedSame || tipoPrueba.caseInsensitiveCompare("Ecografia abdominal") == ComparisonResult.orderedSame {
                innerTypePrueba = 3
            } else if tipoPrueba.caseInsensitiveCompare("Pruebas preanestesia") == ComparisonResult.orderedSame {
                innerTypePrueba = 4
            } else if tipoPrueba.caseInsensitiveCompare("Analítica") == ComparisonResult.orderedSame || tipoPrueba.caseInsensitiveCompare("Analitica") == ComparisonResult.orderedSame {
                innerTypePrueba = 5
            } else {
                innerTypePrueba = 0
            }
            
            let dateActual = Date()
            
            let timestampActual:Int64 = Int64(((dateActual.timeIntervalSince1970) * 1000).rounded())
            
            let timestampCita:Int64 = Int64((dpFechaCita.date.timeIntervalSince1970 * 1000).rounded())
            
            let urlMedicalTest = "users/\(userId!)/medical_tests/cites/\(timestampActual)"
            
            
            self.ref.child("\(urlMedicalTest)/createdBy").setValue("")
            
            
            self.ref.child("\(urlMedicalTest)/description").setValue(descripcion)
            self.ref.child("\(urlMedicalTest)/doctorCite").setValue(personaPrueba)
            self.ref.child("\(urlMedicalTest)/doctorCiteId").setValue(idDoctor2)
            self.ref.child("\(urlMedicalTest)/iduser").setValue(userId!)
            self.ref.child("\(urlMedicalTest)/name").setValue(tipoPrueba)
            self.ref.child("\(urlMedicalTest)/innerType").setValue(innerTypePrueba)

            // Duda sobre "pendingType", lo escribo en firebase con el mismo valor que innerType
            self.ref.child("\(urlMedicalTest)/pendingType").setValue(innerTypePrueba)

            // Duda, no sé que fecha es, la pongo por defecto por ahora
            self.ref.child("\(urlMedicalTest)/pictureTimestamp").setValue(0)

            self.ref.child("\(urlMedicalTest)/placeCite").setValue(lugarCita)
            self.ref.child("\(urlMedicalTest)/placeCiteId").setValue("")
            self.ref.child("\(urlMedicalTest)/prescriberName").setValue(medicoIndica)
            self.ref.child("\(urlMedicalTest)/prescriberId").setValue(idDoctor)
            self.ref.child("\(urlMedicalTest)/prescriberComment").setValue(comentarioMedico)
            self.ref.child("\(urlMedicalTest)/timestamp").setValue(timestampActual)
            self.ref.child("\(urlMedicalTest)/timestampCite").setValue(timestampCita)

            // Duda, no sé que fecha es, la pongo por defecto por ahora
            self.ref.child("\(urlMedicalTest)/timestampDone").setValue(0)

            // Duda, no sé que fecha es, la pongo por defecto por ahora
            self.ref.child("\(urlMedicalTest)/timestampResults").setValue(0)

            // Duda, no sé que fecha es, la pongo por defecto por ahora
            self.ref.child("\(urlMedicalTest)/userViewTimestamp").setValue(0)


            self.performSegue(withIdentifier: "toBackIntroPruebasMedicasSegue", sender: nil)
            


        }
        
    }
    
    @IBAction func actionBtnAtras(_ sender: Any) {
        self.performSegue(withIdentifier: "toBackIntroPruebasMedicasSegue", sender: nil)
    }
}
