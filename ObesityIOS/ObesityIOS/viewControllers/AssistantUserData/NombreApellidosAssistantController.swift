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
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        ref.child("users/\(userId!)/info").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let nombreRecibido:String = value?["name"] as? String ?? ""
            let apellidosRecibidos:String = value?["surname"] as? String ?? ""
            
            // Comprobamos que el usuario haya introducido su nombre y apellidos antes
            if nombreRecibido != "" &&
                apellidosRecibidos != "" {
                
                self.tfNombre.text = nombreRecibido
                self.tfApellidos.text = apellidosRecibidos
                
            } else {
                
                // Fecha de primer uso de app
                let fechaPrimerUsoApp = Date().timeIntervalSince1970
                
                self.ref.child("users/\(self.userId!)/data/fecha_primer_uso_app").setValue(fechaPrimerUsoApp)
                
                // Cargamos los datos de nombre y apellidos en el caso de que se rescataran
                // de Google account
                if let nombre = UserDefaults.standard.string(forKey: "givenName") {
                    self.tfNombre.text = nombre
                    
                }
                
                if let apellidos = UserDefaults.standard.string(forKey: "familyName") {
                    self.tfApellidos.text = apellidos
                    
                }
            }
            
            
        }
        
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
            
            let email = UserDefaults.standard.string(forKey: "email")
            let image = UserDefaults.standard.string(forKey: "imageURL")
            
            self.ref.child("users/\(userId!)/info/name").setValue(nombre)
            
            self.ref.child("users/\(userId!)/info/surname").setValue(apellidos)
            
            self.ref.child("users/\(userId!)/info/nickname").setValue("\(nombre!) \(apellidos!)")
            
            self.ref.child("users/\(userId!)/info/email").setValue(email)
            
            self.ref.child("users/\(userId!)/info/avatar").setValue(image)
            
            self.ref.child("users/\(userId!)/info/image").setValue(image)
            
            self.ref.child("users/\(userId!)/info/id").setValue(userId!)
            
            self.ref.child("users/\(userId!)/info/iduser").setValue(userId!)
            
            self.ref.child("users/\(userId!)/info/passhash").setValue("")
            
            self.ref.child("users/\(userId!)/data/iduser_data").setValue(-1)
            
            self.ref.child("users/\(userId!)/data/user_id").setValue(userId!)
            
            performSegue(withIdentifier: "toTelefonoAssistantSegue", sender: nil)
        }
    }
    

}
