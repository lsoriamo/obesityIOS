//
//  FechaNacimientoAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 24/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FechaNacimientoAssistantController: UIViewController {

    @IBOutlet weak var pbFechaNacimiento: UIProgressView!
    @IBOutlet weak var dpFechaNacimiento: UIDatePicker!
    
    var userId:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        self.dpFechaNacimiento.datePickerMode = UIDatePickerMode.date
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        ref.child("users/\(userId!)/data").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let fechaNacimientoRecibidaUnix:Double = value?["nacimiento"] as? Double ?? -1
            
            if fechaNacimientoRecibidaUnix != -1 {
                
                let fechaNacimientoRecibidaDate:Date = Date(timeIntervalSince1970: TimeInterval(fechaNacimientoRecibidaUnix))
                
                self.dpFechaNacimiento.date = fechaNacimientoRecibidaDate
                
                print(fechaNacimientoRecibidaDate)
                
            } else {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat =  "MM/dd/yyyy"
                
                let date = dateFormatter.date(from: "01/01/1990")
                
                self.dpFechaNacimiento.date = date!
                
            }
            
        }
        
         pbFechaNacimiento.setProgress(0.204, animated: false)
        
    }

    @IBAction func actionBtnSiguiente(_ sender: Any) {
        let fechaNacimiento = dpFechaNacimiento.date.timeIntervalSince1970
        
        self.ref.child("users/\(userId!)/data/nacimiento").setValue(fechaNacimiento)

        performSegue(withIdentifier: "toAlturaAssistantSegue", sender: nil)
    }
}
