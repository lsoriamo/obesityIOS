//
//  WelcomeAssistantViewController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 17/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class WelcomeAssistantViewController: UIViewController {
    
    @IBOutlet weak var pbWelcome: UIProgressView!
    
    var emailWelcomeRecibido:String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setToolbarHidden(false, animated: true);
        if emailWelcomeRecibido != nil {
            print(emailWelcomeRecibido!)
        } else {
            print("No hay email")
        }
        
        pbWelcome.setProgress(0.034, animated: false)
        
    }
    
    
    //Falta aplicar lógica para pasar parámetros
    
    @IBAction func actionBtnSignOut(_ sender: Any) {
        performSegue(withIdentifier: "toLoginSignOutSegue", sender: nil)
    }
    
    @IBAction func actionBtnSiguiente(_ sender: Any) {
        performSegue(withIdentifier: "toNombreApellidosAssistantSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNombreApellidosAssistantSegue" {
            
        }
    }
}
