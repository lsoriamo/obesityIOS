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

class NewAppointmentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var tfDoctor: SearchTextField!
    @IBOutlet weak var pvEspecialidad: UIPickerView!
    @IBOutlet weak var dpAppointmentDate: UIDatePicker!
    @IBOutlet weak var tfDescripcion: UITextField!
    @IBOutlet weak var tfLugar: UITextField!
    @IBOutlet weak var tfNoOlvidar: UITextField!
    
    var arrMedicos:[String] = []
    var arrMedicosAux:[DoctorAux] = []
    
    var arrEspecialidades:[String] = ["Endicronología", "Cirugía", "Anestesiología", "Psicología", "Atención primaria", "Medicina de familia", "Preparador físico", "Nutricionista", "Fisioterapia", "Sin determinar"]
    
    var userId:String?
    var nombreApellidosMedico:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        pvEspecialidad.dataSource = self
        pvEspecialidad.delegate = self
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        loadDoctorsArr()
        
        dpAppointmentDate.locale = Locale(identifier: "es_ES")

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrEspecialidades.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrEspecialidades[row]
    }
    
    func loadDoctorsArr() {
        
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
                        
                        doctorAux.apellidosNombre = self.nombreApellidosMedico!
                        
                        self.arrMedicosAux.append(doctorAux)
                        
                        self.arrMedicos.append(self.nombreApellidosMedico!)
                        
                        self.tfDoctor.filterStrings(self.arrMedicos)
                        
                    }
                    
                    
                }
                
                
            }
            
        }
        
    }
    
    @IBAction func actionBtnAddAppointment(_ sender: Any) {
        let doctorNombre:String = tfDoctor.text!
        let description:String = tfDescripcion.text!
        let things:String = tfNoOlvidar.text!
        let place:String = tfLugar.text!
        
        let typeEspecialidad = pvEspecialidad.selectedRow(inComponent: 0)
        var typeEnumEspecialidad = ""
        
        if doctorNombre.isEmpty {
            // Creando un elemento de Alert (Dialog en Android)
            let alert = UIAlertController(title: "", message: "El nombre del doctor no puede quedar vacío", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // <-- Fin de Alert -->
        } else {
            var idDoctor:String = ""
            
            for item in arrMedicosAux {
                if doctorNombre == item.apellidosNombre {
                    idDoctor = item.doctorId
                }
            }
            
            let dateActual = Date()
            
            let timestampActual:Int64 = Int64(((dateActual.timeIntervalSince1970) * 1000).rounded())
            
            let fechaHoraCita:Int64 = Int64(((dpAppointmentDate.date.timeIntervalSince1970) * 1000).rounded())
            
            if typeEspecialidad == 0 {
                typeEnumEspecialidad = "endocrino"
            } else if typeEspecialidad == 1 {
                typeEnumEspecialidad = "cirujano"
            } else if typeEspecialidad == 2 {
                typeEnumEspecialidad = "anestesista"
            } else if typeEspecialidad == 3 {
                typeEnumEspecialidad = "psicólogo"
            } else if typeEspecialidad == 4 {
                typeEnumEspecialidad = "primaria"
            } else if typeEspecialidad == 5 {
                typeEnumEspecialidad = "médico de familia"
            } else if typeEspecialidad == 6 {
                typeEnumEspecialidad = "preparador físico"
            } else if typeEspecialidad == 7 {
                typeEnumEspecialidad = "nutricionista"
            } else if typeEspecialidad == 8 {
                typeEnumEspecialidad = "fisioterapeuta"
            } else if typeEspecialidad == 9 {
                typeEnumEspecialidad = "otro"
            }
            
            let urlAppointment = "users/\(userId!)/appointment/cites/\(timestampActual)"
            
//            print("URL: \(urlAppointment)")
//            print("FECHA HORA CITA: \(fechaHoraCita)")
//            print("CREATEDBY: \"\"")
//            print("DESCRIPTION: \(description)")
//            print("THINGS: \(things)")
//            print("DOCTOR: \(doctorNombre)")
//            print("DOCTORID: \(idDoctor)")
//            print("IDUSER: \(userId!)")
//            print("PLACE: \(place)")
//            print("TIMESTAMP: \(timestampActual)")
//            print("TYPE: \(typeEspecialidad)")
//            print("TYPEENUM: \(typeEnumEspecialidad)")
            
            
            self.ref.child("\(urlAppointment)/citeTimestamp").setValue(fechaHoraCita)
            self.ref.child("\(urlAppointment)/createdBy").setValue("")
            self.ref.child("\(urlAppointment)/description").setValue(description)
            self.ref.child("\(urlAppointment)/things").setValue(things)
            self.ref.child("\(urlAppointment)/doctor").setValue(doctorNombre)
            self.ref.child("\(urlAppointment)/doctorId").setValue(idDoctor)
            self.ref.child("\(urlAppointment)/iduser").setValue(userId!)
            self.ref.child("\(urlAppointment)/place").setValue(place)
            self.ref.child("\(urlAppointment)/timestamp").setValue(timestampActual)
            self.ref.child("\(urlAppointment)/type").setValue(typeEspecialidad)
            self.ref.child("\(urlAppointment)/typeEnum").setValue(typeEnumEspecialidad)
            
            self.performSegue(withIdentifier: "toBackAgendaSegue", sender: nil)

        }
        
    }
    
    @IBAction func actionBtnAtras(_ sender: Any) {
        self.performSegue(withIdentifier: "toBackAgendaSegue", sender: nil)
    }
    
    
}
