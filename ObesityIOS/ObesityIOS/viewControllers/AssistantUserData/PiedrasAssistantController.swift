//
//  PiedrasAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PiedrasAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pvPiedras: UIPickerView!
    @IBOutlet weak var pbPiedras: UIProgressView!
    
    let confirmacion = ["Si", "No"]
    var userId:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        pvPiedras.dataSource = self
        pvPiedras.delegate = self
        super.viewDidLoad()
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")

        pbPiedras.setProgress(0.578, animated: false)

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return confirmacion.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return confirmacion[row]
    }

    @IBAction func actionBtnSiguiente(_ sender: Any) {
        pvPiedras.selectedRow(inComponent: 0) == 0 ? self.ref.child("users/\(userId!)/data/vesicula").setValue(true) : self.ref.child("users/\(userId!)/data/vesicula").setValue(false)
        performSegue(withIdentifier: "toHigadoAssistantSegue", sender: nil)
    }
}
