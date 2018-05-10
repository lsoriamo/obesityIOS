//
//  WelcomeAssistantViewController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 17/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleSignIn

class WelcomeAssistantViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    @IBOutlet weak var pbWelcome: UIProgressView!
    @IBOutlet weak var labelTitleWelcome: UILabel!
    
    var nombreWelcomeRecibido:String?
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setToolbarHidden(false, animated: true);
        
        nombreWelcomeRecibido = UserDefaults.standard.string(forKey: "givenName")
        
        if nombreWelcomeRecibido != nil {
            print(nombreWelcomeRecibido!)
            
            labelTitleWelcome.text = "Bienvenido a Preobar \(nombreWelcomeRecibido!)"
            
        } else {
            print("No hay nombre")
        }
        
        pbWelcome.setProgress(0.034, animated: false)
        
    }
    
    
    //Falta aplicar lógica para pasar parámetros
    
    @IBAction func actionBtnSignOut(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        self.performSegue(withIdentifier: "toLoginSignOutSegue", sender: nil)
    }
    
    @IBAction func actionBtnSiguiente(_ sender: Any) {
        performSegue(withIdentifier: "toNombreApellidosAssistantSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNombreApellidosAssistantSegue" {
            
        }
    }
}
