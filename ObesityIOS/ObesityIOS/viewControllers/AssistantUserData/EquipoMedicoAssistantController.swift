//
//  EquipoMedicoAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EquipoMedicoAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvEquipoMedico: UIPickerView!
    @IBOutlet weak var pbEquipoMedico: UIProgressView!
    
    var equiposMedico:[String] = []
    var userId:String?

    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        pvEquipoMedico.dataSource = self
        pvEquipoMedico.delegate = self
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")

        ref.child("medicalCenters").observeSingleEvent(of: .value) { (snapshot) in
            
            let dicHospitales = snapshot.value as? NSDictionary
            
            print(dicHospitales!.allKeys)
            
            for idHospital in dicHospitales!.allKeys {
                self.ref.child("medicalCenters/\(idHospital)").observeSingleEvent(of: .value) { (snapshot) in

                    let value = snapshot.value as? NSDictionary
                    let nombreHospital = value?["name"] as? String ?? ""
                    
                    self.equiposMedico.append(nombreHospital)
                    
                    self.pvEquipoMedico.reloadAllComponents()
                }
            }
        }
        
        pbEquipoMedico.setProgress(0.975, animated: false)

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return equiposMedico.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return equiposMedico[row]
    }
    
    // Función que permite extraer el id del hospital seleccionado por el usuario, y lo añade a las preferencias para futuras pantallas
    func getIdHospitalSelected(index: Int) {
        
        var arrIdsHospital:[String]?
        var idHospitalSelected:String?
        
        ref.child("medicalCenters").observeSingleEvent(of: .value) { (snapshot) in
            
            let dicHospitales = snapshot.value as? NSDictionary
            
            arrIdsHospital = dicHospitales?.allKeys as? [String]
            
            idHospitalSelected = arrIdsHospital![index]
            UserDefaults.standard.set(idHospitalSelected, forKey: "hospitalSelected")
            
        }
    }

    @IBAction func actionBtnSiguiente(_ sender: Any) {
        
        getIdHospitalSelected(index: pvEquipoMedico.selectedRow(inComponent: 0))
        
        performSegue(withIdentifier: "toSeleccionDoctorAssistantSegue", sender: nil)
    }
}
