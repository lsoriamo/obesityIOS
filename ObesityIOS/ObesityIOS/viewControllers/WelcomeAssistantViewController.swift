//
//  WelcomeAssistantViewController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 17/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class WelcomeAssistantViewController: UIViewController {
    
    var emailWelcomeRecibido:String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setToolbarHidden(false, animated: true);
        if emailWelcomeRecibido != nil {
            print(emailWelcomeRecibido!)
        } else {
            print("No hay email")
        }

        // Do any additional setup after loading the view.
    }

}
