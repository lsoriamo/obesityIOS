//
//  AlturaAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 24/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AlturaAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pvAltura: UIPickerView!
    @IBOutlet weak var pbAltura: UIProgressView!
    
    var alturas = [Int]()
    var userId:String?
    
    var rowSelected:Int?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        pvAltura.dataSource = self
        pvAltura.delegate = self
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        pbAltura.setProgress(0.238, animated: false)
        
        alturas = cargarAlturas()
        
        pvAltura.selectRow(70, inComponent: 0, animated: true)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return alturas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        rowSelected = row
        return String(alturas[row])
    }

    @IBAction func actionBtnSiguiente(_ sender: Any) {
        
        self.ref.child("users/\(userId!)/data/altura").setValue(alturas[rowSelected!])

        performSegue(withIdentifier: "toPesoAssistantSegue", sender: nil)
    }
    
    func cargarAlturas() -> Array<Int> {
        for i in 100...250 {
            alturas.append(i)
        }
        
        return alturas
    }
}
