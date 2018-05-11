//
//  NombreApellidosAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 23/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NombreApellidosAssistantController: UIViewController {

    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfApellidos: UITextField!
    @IBOutlet weak var pbNombreApellidos: UIProgressView!
    
    var ref: DatabaseReference!
    
    var nombre:String?
    var apellidos:String?
    
    var userId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        if let nombre = UserDefaults.standard.string(forKey: "givenName") {
            tfNombre.text = nombre
        }
        
        if let apellidos = UserDefaults.standard.string(forKey: "familyName") {
            tfApellidos.text = apellidos
        }
        
        userId = UserDefaults.standard.string(forKey: "userId")
        print("EL USERID ES: \(userId!)")
        
        pbNombreApellidos.setProgress(0.068, animated: false)


    }
    
    @IBAction func actionBtnSiguiente(_ sender: Any) {
        
        nombre = tfNombre.text
        apellidos = tfApellidos.text
        
        if nombre!.isEmpty || apellidos!.isEmpty {
            // Creando un elemento de Alert (Dialog en Android)
            let alert = UIAlertController(title: "", message: "El nombre y los apellidos no pueden estar vacíos", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // <-- Fin de Alert -->
        } else {
            
            self.ref.child("users/\(userId!)/info/name").setValue(nombre)
            self.ref.child("users/\(userId!)/info/surname").setValue(apellidos)
            
            performSegue(withIdentifier: "toTelefonoAssistantSegue", sender: nil)
        }
    }
    

}
