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
        pbSexo.setProgress(0.136, animated: false)

        // Do any additional setup after loading the view.
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
        print("Ha seleccionado el index: ", pickerViewSex.selectedRow(inComponent: 0))
        
        self.ref.child("users/\(userId!)/info/sex").setValue(pickerViewSex.selectedRow(inComponent: 0))
        
        self.performSegue(withIdentifier: "toProfesionAssistantSegue", sender: nil)
    }
    
}
