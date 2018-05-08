//
//  FechaNacimientoAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 24/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class FechaNacimientoAssistantController: UIViewController {

    @IBOutlet weak var pbFechaNacimiento: UIProgressView!
    @IBOutlet weak var dpFechaNacimiento: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "MM/dd/yyyy"
        
        let date = dateFormatter.date(from: "01/01/1990")
        
        pbFechaNacimiento.setProgress(0.204, animated: false)

        dpFechaNacimiento.datePickerMode = UIDatePickerMode.date
        dpFechaNacimiento.date = date!
        
    }

    @IBAction func actionBtnSiguiente(_ sender: Any) {
        
        performSegue(withIdentifier: "toAlturaAssistantSegue", sender: nil)
    }
}
