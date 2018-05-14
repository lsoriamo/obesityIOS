//
//  AlcoholAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AlcoholAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pvAlcohol: UIPickerView!
    @IBOutlet weak var pbAlcohol: UIProgressView!
    
    let eleccion = ["Nunca", "Una vez al mes", "Una vez a la semana", "Varias veces a la semana"]
    var userId:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        pvAlcohol.dataSource = self
        pvAlcohol.delegate = self
        super.viewDidLoad()
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        pbAlcohol.setProgress(0.748, animated: false)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return eleccion.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return eleccion[row]
    }
    
    @IBAction func actionBtnSiguiente(_ sender: Any) {
        
        self.ref.child("users/\(userId!)/data/alcohol").setValue(pvAlcohol.selectedRow(inComponent: 0))

        performSegue(withIdentifier: "toArdoresAssistantSegue", sender: nil)
    }
    
}
