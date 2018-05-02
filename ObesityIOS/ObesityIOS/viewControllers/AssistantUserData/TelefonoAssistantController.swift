//
//  TelefonoAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 23/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class TelefonoAssistantController: UIViewController {
    
    @IBOutlet weak var tfTelefono: UITextField!
    @IBOutlet weak var pbTelefono: UIProgressView!
    
    var telefono:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pbTelefono.setProgress(0.102, animated: false)

        // Do any additional setup after loading the view.
    }

    @IBAction func actionBtnSiguiente(_ sender: Any) {
        telefono = tfTelefono.text
        
        if telefono!.isEmpty {
            performSegue(withIdentifier: "toSexoAssistantSegue", sender: nil)
        } else {
            // Habría que pasar el teléfono
            performSegue(withIdentifier: "toSexoAssistantSegue", sender: nil)
        }
    }
}
