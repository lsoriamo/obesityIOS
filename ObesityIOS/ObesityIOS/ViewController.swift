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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        FirebaseApp.configure();
        var ref = Database.database().reference();
        ref.child("users/2IaSdrayoQStcjVXT2g01i0ebrl2/info")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

