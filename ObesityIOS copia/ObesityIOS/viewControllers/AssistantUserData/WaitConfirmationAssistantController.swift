//
//  WaitConfirmationAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 2/5/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleSignIn

class WaitConfirmationAssistantController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    @IBOutlet weak var lbTituloWaitConfimation: UILabel!
    
    var nombreWaitConfirmation:String?
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setToolbarHidden(true, animated: false)

        nombreWaitConfirmation = UserDefaults.standard.string(forKey: "givenName") ?? ""
        
        lbTituloWaitConfimation.text = "Bienvenido a Preobar \(nombreWaitConfirmation!)"
        
    }
    
    @IBAction func actionBtnSignOut(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        performSegue(withIdentifier: "toSignOutFromEndAssistant", sender: nil)
    }
    
}
