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
        
        alturas = cargarAlturas()
        
        ref.child("users/\(userId!)/data").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let alturaRecibida:Int = value?["altura"] as? Int ?? -1
            
            if alturaRecibida != -1 {
                
                let indexAltura = self.findAltura(altura: alturaRecibida)
                
                self.pvAltura.selectRow(indexAltura, inComponent: 0, animated: false)
                
            } else {
                
                self.pvAltura.selectRow(70, inComponent: 0, animated: true)
                
            }
            
        }
        
        pbAltura.setProgress(0.238, animated: false)
        
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
    
    func findAltura(altura:Int) -> Int {
        
        var i:Int = 0
        
        for a in alturas {
            if a == altura {
                return i
            }
            i = i+1
        }
        
        return -1
        
    }
    
    func cargarAlturas() -> Array<Int> {
        for i in 100...250 {
            alturas.append(i)
        }
        
        return alturas
    }
}
