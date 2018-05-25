//
//  SignUpController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 2/5/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import SearchTextField

class SignUpController: UIViewController {
    
    @IBOutlet weak var btnRegistrar: UIButton!
    
    @IBOutlet weak var tfEmail: SearchTextField!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var tfPassRep: UITextField!
    
    var email:String?
    var pass:String?
    var passRep:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Autocomplete SearchTextField email
        tfEmail.inlineMode = true
        tfEmail.startFilteringAfter = "@"
        tfEmail.startSuggestingInmediately = true
        tfEmail.filterStrings(["gmail.com", "gmail.es", "yahoo.com", "hotmail.com", "hotmail.es", "us.es"])
        
        btnRegistrar.layer.cornerRadius = 4
        navigationController?.setToolbarHidden(false, animated: false)

    }
    @IBAction func actionBtnFinalizar(_ sender: Any) {
        email = tfEmail.text!
        pass = tfPass.text!
        passRep = tfPassRep.text!
        
        let bolTestEmail:Bool = isValidEmail(emailToCheck: email!)
        
        if  email!.isEmpty || pass!.isEmpty || passRep!.isEmpty{
            // <-- Creando un elemento de Alert (Dialog en Android)
            let alert = UIAlertController(title: "", message: "Debe rellenar todos los campos", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // Fin de Alert -->
        } else if !bolTestEmail{
            // <-- Creando un elemento de Alert (Dialog en Android)
            let alert = UIAlertController(title: "", message: "Email no válido", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // Fin de Alert -->
        } else if pass!.count < 8 {
            // <-- Creando un elemento de Alert (Dialog en Android)
            let alert = UIAlertController(title: "", message: "La contraseña debe tener al menos 8 caracteres", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // Fin de Alert -->
        } else if pass != passRep {
            // <-- Creando un elemento de Alert (Dialog en Android)
            let alert = UIAlertController(title: "", message: "Las contraseñas no coinciden", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // Fin de Alert -->
        } else {
            //  <-- SNIP DE CÓDIGO PARA CREACIÓN DE USUARIO
            
            //            Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            //
            //                if let error = error {
            //                    print("ERROR: \(error)")
            //                    return
            //                }
            //            }
            
            // FIN -->
            
            performSegue(withIdentifier: "toLoginUsuarioSegue", sender: nil)
            
            // <-- Creando un elemento de Alert (Dialog en Android)
            let alert = UIAlertController(title: "", message: "Hemos enviado un correo de verificación a \(email!). Pulsa el enlace que te hemos enviado y accede de nuevo con el correo electrónico y la contraseña que introdujiste antes", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // Fin de Alert -->
            
        }
    }
    
    // Función que comprueba si el email introducido por el usuario cumple con el patrón estándar
    func isValidEmail(emailToCheck:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailToCheck)
    }
    
}
