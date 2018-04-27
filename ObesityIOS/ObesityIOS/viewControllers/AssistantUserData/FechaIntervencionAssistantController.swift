//
//  FechaIntervencionAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class FechaIntervencionAssistantController: UIViewController {

    @IBOutlet weak var dpFechaIntervencion: UIDatePicker!
    @IBOutlet weak var pbFechaIntervencion: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pbFechaIntervencion.setProgress(0.9, animated: false)
        
        dpFechaIntervencion.datePickerMode = UIDatePickerMode.date

        
    }

    @IBAction func actionBtnSiguiente(_ sender: Any) {
        performSegue(withIdentifier: "toPesoObjetivoAssistantSegue", sender: nil)
    }
}
