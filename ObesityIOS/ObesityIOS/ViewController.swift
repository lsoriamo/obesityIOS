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
    
    var email: String = ""
    var pass: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        FirebaseApp.configure();
        //var ref = Database.database().reference();
        //ref.child("users/2IaSdrayoQStcjVXT2g01i0ebrl2/info")
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            print("Error de Google count en view")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
    }

    @IBAction func btnAccessUserAccount(_ sender: Any) {
        email = tfEmail.text!
        pass = tfPass.text!
        
        // Comprobación de que el email o contraseña no estén vacíos
        
        //TODO falta completar la comprobación de de patrón de email
        if email == "" || pass == "" {
            // Creando un elemento de Alert (Dialog en Android)
            let alert = UIAlertController(title: "Error", message: "Introduce tu email y contraseña", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // <-- Fin de Alert -->
        } else {
            
            let user:User = User()
            
            user.email = email
            user.passhash = pass
            
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
            
            Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                if let error = error {
                    print("ERROR: \(error)")
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
    
    // TODO Por acabar
//    @IBAction func btnAccessGoogleAccount(_ sender: Any) {
//        let user:User = User()
//
//        user.email = email
//        user.passhash = pass
//
//        Auth.auth().signIn(with: credential) { (user, error) in
//            if let error = error {
//                // ...
//                return
//            }
//            // User is signed in
//            // ...
//        }
//    }
    
}

