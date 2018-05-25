//
//  ProfesionAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 23/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ProfesionAssistantController: UIViewController {

    @IBOutlet weak var tfProfesion: UITextField!
    @IBOutlet weak var pbProfesion: UIProgressView!
    
    var userId:String?
    var profesion:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        ref.child("users/\(userId!)/info").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let profesionRecibida:String = value?["profesion"] as? String ?? ""
            
            
            if profesionRecibida != "" {
                
                self.tfProfesion.text = profesionRecibida
                
            }
            
        }

        pbProfesion.setProgress(0.17, animated: false)
        
    }

    @IBAction func actionBtnSiguiente(_ sender: Any) {
        
        profesion = tfProfesion.text
        
        if !profesion!.isEmpty {
            self.ref.child("users/\(userId!)/info/profesion").setValue(profesion)
        }
        
        performSegue(withIdentifier: "toFechaNacimientoAssistantSegue", sender: nil)
        
    }
}
