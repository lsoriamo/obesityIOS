//
//  SexAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 23/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SexAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var pbSexo: UIProgressView!
    
    @IBOutlet weak var pickerViewSex: UIPickerView!
    
    let sex = ["Mujer", "Hombre", "Otro"]
    var userId:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        pickerViewSex.dataSource = self
        pickerViewSex.delegate = self
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        ref.child("users/\(userId!)/info").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let sexoRecibido:Int = value?["sex"] as? Int ?? -1
            
            
            if sexoRecibido != -1 {
                
                self.pickerViewSex.selectRow(sexoRecibido, inComponent: 0, animated: false)
                
            }
            
            
        }
        pbSexo.setProgress(0.136, animated: false)

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sex.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sex[row]
    }
    
    
    @IBAction func actionBtnSiguienteSex(_ sender: Any) {
        
        self.ref.child("users/\(userId!)/info/sex").setValue(pickerViewSex.selectedRow(inComponent: 0))
        
        self.performSegue(withIdentifier: "toProfesionAssistantSegue", sender: nil)
    }
    
}
