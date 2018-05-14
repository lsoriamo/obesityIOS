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
        
        userId = UserDefaults.standard.string(forKey: "userId")

        dpFechaIntervencion.datePickerMode = UIDatePickerMode.date
        dpFechaIntervencion.isHidden = true
        btnCancelarFecha.isHidden = true
        
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
        }
        
        performSegue(withIdentifier: "toPesoObejtivoAssistantSegue", sender: nil)
    }
}
