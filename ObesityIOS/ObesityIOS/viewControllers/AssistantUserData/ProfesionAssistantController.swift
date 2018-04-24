//
//  ProfesionAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 23/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class ProfesionAssistantController: UIViewController {

    @IBOutlet weak var tfProfesion: UITextField!
    @IBOutlet weak var pbProfesion: UIProgressView!
    
    var profesion:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pbProfesion.setProgress(0.2, animated: false)
        
        // Do any additional setup after loading the view.
    }

    @IBAction func actionBtnSiguiente(_ sender: Any) {
        
        profesion = tfProfesion.text
        
        if profesion!.isEmpty {
            performSegue(withIdentifier: "toFechaNacimientoAssistantSegue", sender: nil)
        } else {
            // Falta pasar por segue profesión
            performSegue(withIdentifier: "toFechaNacimientoAssistantSegue", sender: nil)
        }
        
    }
}
