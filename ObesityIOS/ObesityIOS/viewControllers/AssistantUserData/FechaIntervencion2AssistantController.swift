//
//  FechaIntervencion2AssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 7/5/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class FechaIntervencion2AssistantController: UIViewController {

    @IBOutlet weak var btnSeleccionarFecha: UIButton!
    @IBOutlet weak var btnCancelarFecha: UIButton!
    @IBOutlet weak var dpFechaIntervencion: UIDatePicker!
    
    
    var isSelectedFecha = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dpFechaIntervencion.datePickerMode = UIDatePickerMode.date
        dpFechaIntervencion.isHidden = true
        btnCancelarFecha.isHidden = true
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
        performSegue(withIdentifier: "toPesoObejtivo2AssistantSegue", sender: nil)
    }
}
