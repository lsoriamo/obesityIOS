//
//  WaitConfirmationAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 2/5/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class WaitConfirmationAssistantController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setToolbarHidden(true, animated: false)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionBtnSignOut(_ sender: Any) {
        performSegue(withIdentifier: "toSignOutFromEndAssistant", sender: nil)
    }
    
}
