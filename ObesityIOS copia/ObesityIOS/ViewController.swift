//
//  ViewController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 9/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate{
    

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var btnGoogleAccount: GIDSignInButton!
    @IBOutlet weak var btnGoSignUp: UIButton!
    
    var email: String = ""
    var pass: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        FirebaseApp.configure();
        //var ref = Database.database().reference();
        //ref.child("users/2IaSdrayoQStcjVXT2g01i0ebrl2/info")
        
    
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
        
        btnGoSignUp.titleLabel?.textAlignment = NSTextAlignment.center
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnAccessUserAccount(_ sender: Any) {
        email = tfEmail.text!
        pass = tfPass.text!
        
        // Comprobación de que el email o contraseña no estén vacíos y que el email cumpla con el patrón estándar
        
        let bolTestEmail:Bool = isValidEmail(emailToCheck: email)
        
        if email == "" || !bolTestEmail{
            // <-- Creando un elemento de Alert (Dialog en Android)
            let alert = UIAlertController(title: "Error", message: "Email no válido", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // Fin de Alert -->
        }else if pass == "" {
            // <-- Creando un elemento de Alert (Dialog en Android)
            let alert = UIAlertController(title: "Error", message: "Contraseña no válida", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // Fin de Alert -->
        } else {
            
            let user:User = User()
            
            user.email = email
            user.passhash = pass
            
            Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                if let error = error {
                    print("ERROR: \(error)")
                    
                    // Creando un elemento de Alert (Dialog en Android)
                    let alert = UIAlertController(title: "LOGIN INCORRECTO", message: "Email o contraseña incorrecta", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    // <-- Fin de Alert -->
                    
                    return
                }
                // Creando un elemento de Alert (Dialog en Android)
                let alert = UIAlertController(title: "LOGIN CORRECTO", message: "Acceso concedido", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                // <-- Fin de Alert -->
            }
        }
        
    }
    
    // Función que comprueba si el email introducido por el usuario cumple con el patrón estándar
    func isValidEmail(emailToCheck:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailToCheck)
    }
    
    //  <-- SNIP DE CÓDIGO PARA CREACIÓN DE USUARIO
    
    //            Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
    //
    //                if let error = error {
    //                    print("ERROR: \(error)")
    //                    return
    //                }
    //                // Creando un elemento de Alert (Dialog en Android)
    //                let alert = UIAlertController(title: "BIEN", message: "Login correcto", preferredStyle: UIAlertControllerStyle.alert)
    //                alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
    //                self.present(alert, animated: true, completion: nil)
    //                // <-- Fin de Alert -->
    //            }
    
    // FIN -->

}

