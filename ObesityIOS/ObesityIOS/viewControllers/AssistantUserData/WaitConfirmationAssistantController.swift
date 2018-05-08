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

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setToolbarHidden(true, animated: false)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionBtnSignOut(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        performSegue(withIdentifier: "toSignOutFromEndAssistant", sender: nil)
    }
    
}
