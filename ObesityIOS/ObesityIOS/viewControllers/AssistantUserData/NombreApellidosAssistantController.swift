//
//  NombreApellidosAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 23/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class NombreApellidosAssistantController: UIViewController {

    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfApellidos: UITextField!
    
    var nombre:String?
    var apellidos:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionBtnSiguiente(_ sender: Any) {
        
        nombre = tfNombre.text
        apellidos = tfApellidos.text
        
        if nombre!.isEmpty || apellidos!.isEmpty {
            // Creando un elemento de Alert (Dialog en Android)
            let alert = UIAlertController(title: "", message: "El nombre o los apellidos no se pueden quedar vacíos", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // <-- Fin de Alert -->
        } else {
            performSegue(withIdentifier: "toTelefonoAssistantSegue", sender: nil)
        }
    }
    

}
