//
//  PesoObjetivoAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 26/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PesoObjetivoAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvPesoObjetivo: UIPickerView!
    @IBOutlet weak var pbPesoObjetivo: UIProgressView!
    
    var pesos = [Int]()
    var userId:String?
    
    var ref: DatabaseReference!
    
    var pesoUsuario:Int?
    var pesoUsuarioObjetivoAprox:Int?
    
    var indexPesoUsuario:Int?
    
    override func viewDidLoad() {
        pvPesoObjetivo.dataSource = self
        pvPesoObjetivo.delegate = self
        super.viewDidLoad()
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        pesos = cargarPesos()
        
        ref.child("users/\(userId!)/data").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let pesoRecibido:Int = value?["peso_objetivo"] as? Int ?? -1
            
            if pesoRecibido != -1 {
                
                let indexPeso = self.findPeso(peso: pesoRecibido)
                
                self.pvPesoObjetivo.selectRow(indexPeso, inComponent: 0, animated: false)
                
            } else {
                
                self.pesoUsuario = UserDefaults.standard.integer(forKey: "pesoUsuario")
                
                self.pesoUsuarioObjetivoAprox = self.pesoUsuario! - (self.pesoUsuario! / 10)
                self.indexPesoUsuario = self.findPesoObjetivoAprox(peso: self.pesoUsuarioObjetivoAprox!)
                
                self.pvPesoObjetivo.selectRow(self.indexPesoUsuario!, inComponent: 0, animated: true)
                
            }
            
        }
        
        pbPesoObjetivo.setProgress(0.935, animated: false)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pesos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pesos[row])
    }
    
    func findPeso(peso:Int) -> Int {
        var i:Int = 0
        
        for p in pesos {
            if p == peso {
                return i
            }
            i = i+1
        }
        
        return 0
    }
    
    func findPesoObjetivoAprox(peso: Int) -> Int {
        var i = 0
        
        for p in pesos {
            
            if p == peso {
                return i
            }
            
            i = i+1
        }
        return 0
    }
    
    func cargarPesos() -> Array<Int> {
        for i in 50...350 {
            pesos.append(i)
        }
        
        return pesos
    }

    @IBAction func actionBtnSiguiente(_ sender: Any) {
        
        self.ref.child("users/\(userId!)/data/peso_objetivo").setValue(pesos[pvPesoObjetivo.selectedRow(inComponent: 0)])
        
        performSegue(withIdentifier: "toEquipoMedicoAssistantSegue", sender: nil)
    }
}
