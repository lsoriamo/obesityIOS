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
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "MM/dd/yyyy"
        
        let date = dateFormatter.date(from: "01/01/1990")
        
        pbFechaNacimiento.setProgress(0.204, animated: false)

        dpFechaNacimiento.datePickerMode = UIDatePickerMode.date
        dpFechaNacimiento.date = date!
        
    }

    @IBAction func actionBtnSiguiente(_ sender: Any) {
        let fechaNacimiento = dpFechaNacimiento.date.timeIntervalSince1970
        
        //NO ES SEGURO SI ES ESTA RUTA!
//        self.ref.child("users/\(userId!)/info/fecha_nacimiento").setValue(fechaNacimiento)

        performSegue(withIdentifier: "toAlturaAssistantSegue", sender: nil)
    }
}
