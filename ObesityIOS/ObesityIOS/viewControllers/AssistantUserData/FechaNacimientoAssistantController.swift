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
        
        pbFechaNacimiento.setProgress(0.25, animated: false)

        dpFechaNacimiento.datePickerMode = UIDatePickerMode.date
        
        // Do any additional setup after loading the view.
    }

    @IBAction func actionBtnSiguiente(_ sender: Any) {
        
        performSegue(withIdentifier: "toAlturaAssistantSegue", sender: nil)
    }
}
