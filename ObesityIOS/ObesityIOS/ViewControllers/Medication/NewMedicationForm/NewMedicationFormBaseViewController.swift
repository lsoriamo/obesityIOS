//
//  NewMedicationFormBaseViewController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 7/6/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class NewMedicationFormBaseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var dpFechaInicio: UIDatePicker!
    @IBOutlet weak var dpFechaFinalizacion: UIDatePicker!
    @IBOutlet weak var pvModoAdministracion: UIPickerView!
    @IBOutlet weak var btnAsignarFechaFinalizacion: UIButton!
    @IBOutlet weak var btnCancelarFechaFinalizacion: UIButton!
    
    let eleccion = ["Diariamente X veces", "Diariamente cada X horas", "Cada X días", "Días de la semana", "X días con descanso"]
    
    var isSelectedFechaFinalizacion = false
    var indexModoAdministracionSelected:Int?
    var timestampInicioSelected:Double?
    var timestampFinalizacionSelected:Double?
    
    override func viewDidLoad() {
        pvModoAdministracion.dataSource = self
        pvModoAdministracion.delegate = self
        super.viewDidLoad()
        
        dpFechaInicio.locale = Locale(identifier: "es_ES")
        dpFechaFinalizacion.locale = Locale(identifier: "es_ES")
        
        indexModoAdministracionSelected = UserDefaults.standard.integer(forKey: "indexModoAdministracionSelected")
        
        timestampInicioSelected = UserDefaults.standard.double(forKey: "timestampInicioMedicacionDate")
        timestampFinalizacionSelected = UserDefaults.standard.double(forKey: "timestampFinalizacionMedicacionDate")
        
        if indexModoAdministracionSelected != nil {
            pvModoAdministracion.selectRow(indexModoAdministracionSelected!, inComponent: 0, animated: false)
        }
        
        if timestampInicioSelected != 0 {
            
            let fechaInicioSelected = Date(timeIntervalSince1970: timestampInicioSelected!)
            
            dpFechaInicio.date = fechaInicioSelected
        }
        
        if timestampFinalizacionSelected != 0 {
            
            let fechaFinalizacionSelected = Date(timeIntervalSince1970: timestampFinalizacionSelected!)
            
            dpFechaFinalizacion.date = fechaFinalizacionSelected
            
            isSelectedFechaFinalizacion = true
            dpFechaFinalizacion.isHidden = false
            btnCancelarFechaFinalizacion.isHidden = false
            btnAsignarFechaFinalizacion.isHidden = true
            
        } else {
            dpFechaFinalizacion.isHidden = true
            btnCancelarFechaFinalizacion.isHidden = true
            
        }
    

    }
    
    @IBAction func actionBtnAsignarFecha(_ sender: Any) {
        isSelectedFechaFinalizacion = true
        
        btnAsignarFechaFinalizacion.isHidden = true
        dpFechaFinalizacion.isHidden = false
        btnCancelarFechaFinalizacion.isHidden = false
    }
    
    @IBAction func actionBtnCancelar(_ sender: Any) {
        isSelectedFechaFinalizacion = false
        
        btnAsignarFechaFinalizacion.isHidden = false
        dpFechaFinalizacion.isHidden = true
        btnCancelarFechaFinalizacion.isHidden = true
    
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return eleccion.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return eleccion[row]
    }

    @IBAction func actionBtnSiguiente(_ sender: Any) {
        var modoAdministracion:String = ""
        var fechaInicioTimestamp:Int64 = 0
        var fechaFinalizacionTimestamp:Int64 = 0
        
        modoAdministracion = eleccion[pvModoAdministracion.selectedRow(inComponent: 0)]
        fechaInicioTimestamp = Int64(dpFechaInicio.date.timeIntervalSince1970 * 1000)
        fechaFinalizacionTimestamp = Int64(dpFechaFinalizacion.date.timeIntervalSince1970 * 1000)
        
        print("IS SELECTED FECHA: \(isSelectedFechaFinalizacion)")
        
        if isSelectedFechaFinalizacion {
            
            if dpFechaFinalizacion.date < dpFechaInicio.date {
                // Creando un elemento de Alert (Dialog en Android)
                let alert = UIAlertController(title: "", message: "La fecha de finalización no puede ser anterior a la de inicio", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                // <-- Fin de Alert -->
            } else {
                UserDefaults.standard.set(fechaFinalizacionTimestamp, forKey: "fechaFinalizacionMedicacionTimestamp")
                UserDefaults.standard.set(modoAdministracion, forKey: "modoAdministracion")
                UserDefaults.standard.set(fechaInicioTimestamp, forKey: "fechaInicioMedicacionTimestamp")
                
                // Auxiliares
                UserDefaults.standard.set(pvModoAdministracion.selectedRow(inComponent: 0), forKey: "indexModoAdministracionSelected")
                UserDefaults.standard.set(dpFechaInicio.date.timeIntervalSince1970, forKey: "timestampInicioMedicacionDate")
                UserDefaults.standard.set(dpFechaFinalizacion.date.timeIntervalSince1970, forKey: "timestampFinalizacionMedicacionDate")
                
                if modoAdministracion == "Diariamente X veces" {
                    performSegue(withIdentifier: "toDiariamenteXVecesSegue", sender: nil)
                    
                } else if modoAdministracion == "Diariamente cada X horas" {
                    performSegue(withIdentifier: "toDiariamenteXHorasSegue", sender: nil)
                    
                } else if modoAdministracion == "Cada X días" {
                    performSegue(withIdentifier: "toCadaXDiasSegue", sender: nil)
                    
                } else if modoAdministracion == "Días de la semana" {
                    performSegue(withIdentifier: "toDiasDeLaSemanaSegue", sender: nil)
                    
                } else if modoAdministracion == "X días con descanso" {
                    performSegue(withIdentifier: "toXDiasDeDescansoSegue", sender: nil)
                    
                }
            }
            
            
        } else {
            
            UserDefaults.standard.set(modoAdministracion, forKey: "modoAdministracion")
            UserDefaults.standard.set(fechaInicioTimestamp, forKey: "fechaInicioMedicacionTimestamp")
            UserDefaults.standard.set(0, forKey: "fechaFinalizacionMedicacionTimestamp")
            
            // Auxiliares
            UserDefaults.standard.set(pvModoAdministracion.selectedRow(inComponent: 0), forKey: "indexModoAdministracionSelected")
            UserDefaults.standard.set(dpFechaInicio.date.timeIntervalSince1970, forKey: "timestampInicioMedicacionDate")
            UserDefaults.standard.set(0, forKey: "timestampFinalizacionMedicacionDate")
            
            
            if modoAdministracion == "Diariamente X veces" {
                performSegue(withIdentifier: "toDiariamenteXVecesSegue", sender: nil)
                
            } else if modoAdministracion == "Diariamente cada X horas" {
                performSegue(withIdentifier: "toDiariamenteXHorasSegue", sender: nil)
                
            } else if modoAdministracion == "Cada X días" {
                performSegue(withIdentifier: "toCadaXDiasSegue", sender: nil)
                
            } else if modoAdministracion == "Días de la semana" {
                performSegue(withIdentifier: "toDiasDeLaSemanaSegue", sender: nil)
                
            } else if modoAdministracion == "X días con descanso" {
                performSegue(withIdentifier: "toXDiasDeDescansoSegue", sender: nil)
                
            }
        }
        
    }
}
