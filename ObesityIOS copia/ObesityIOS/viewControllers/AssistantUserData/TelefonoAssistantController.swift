//
//  TelefonoAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 23/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TelefonoAssistantController: UIViewController {
    
    @IBOutlet weak var tfTelefono: UITextField!
    @IBOutlet weak var pbTelefono: UIProgressView!
    
    var telefono:String?
    var userId:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        ref.child("users/\(userId!)/info").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let telefonoRecibido:String = value?["phone"] as? String ?? ""
            
            
            if telefonoRecibido != "" {
                
                self.tfTelefono.text = telefonoRecibido
                
            }
            
            
        }
        
        pbTelefono.setProgress(0.102, animated: false)

        // Do any additional setup after loading the view.
    }

    @IBAction func actionBtnSiguiente(_ sender: Any) {
        telefono = tfTelefono.text
        
        if !telefono!.isEmpty {
            self.ref.child("users/\(userId!)/info/phone").setValue(telefono)
        }
        
        performSegue(withIdentifier: "toSexoAssistantSegue", sender: nil)
    }
}
