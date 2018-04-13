//
//  WelcomeViewController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 13/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var lbWelcomeUser: UILabel!
    
    var emailWelcomeRecibido:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if emailWelcomeRecibido != nil {
            lbWelcomeUser.text = "Bienvenido \(emailWelcomeRecibido!)"
        } else {
            lbWelcomeUser.text = "Bienvenido anónimo"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
