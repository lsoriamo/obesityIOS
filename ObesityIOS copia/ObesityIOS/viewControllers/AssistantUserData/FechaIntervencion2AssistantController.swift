//
//  FechaIntervencion2AssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 7/5/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FechaIntervencion2AssistantController: UIViewController {

    @IBOutlet weak var btnSeleccionarFecha: UIButton!
    @IBOutlet weak var btnCancelarFecha: UIButton!
    @IBOutlet weak var dpFechaIntervencion: UIDatePicker!
    @IBOutlet weak var pbFechaIntervencion: UIProgressView!
    
    var isSelectedFecha = false
    var userId:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        dpFechaIntervencion.datePickerMode = UIDatePickerMode.date
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        ref.child("users/\(userId!)/data").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let fechaIntervencionRecibidaUnix:Double = value?["fecha_intervencion"] as? Double ?? -1
            
            if fechaIntervencionRecibidaUnix != -1 {
                
                self.isSelectedFecha = true
                self.dpFechaIntervencion.isHidden = false
                self.btnCancelarFecha.isHidden = false
                self.btnSeleccionarFecha.isHidden = true
                
                let fechaIntervencionRecibidaDate:Date = Date(timeIntervalSince1970: TimeInterval(fechaIntervencionRecibidaUnix))
                
                self.dpFechaIntervencion.date = fechaIntervencionRecibidaDate
                
            } else {
                
                self.dpFechaIntervencion.isHidden = true
                self.btnCancelarFecha.isHidden = true
                
            }
            
        }

        pbFechaIntervencion.setProgress(0.884, animated: false)
    }
    
    @IBAction func actionBtnSeleccionarFecha(_ sender: Any) {
        isSelectedFecha = true
        
        btnSeleccionarFecha.isHidden = true
        btnCancelarFecha.isHidden = false
        dpFechaIntervencion.isHidden = false
    }
    
    @IBAction func actionBtnCancelarFecha(_ sender: Any) {
        isSelectedFecha = false
        btnCancelarFecha.isHidden = true
        btnSeleccionarFecha.isHidden = false
        dpFechaIntervencion.isHidden = true
    }
    
    @IBAction func actionBtnSiguiente(_ sender: Any) {
        let fechaIntervencion = dpFechaIntervencion.date.timeIntervalSince1970
        
        if isSelectedFecha {
            self.ref.child("users/\(userId!)/data/fecha_intervencion").setValue(fechaIntervencion)
        } else {
            self.ref.child("users/\(userId!)/data/fecha_intervencion").setValue(-1)
        }
        
        performSegue(withIdentifier: "toPesoObejtivoAssistantSegue", sender: nil)
    }
}
