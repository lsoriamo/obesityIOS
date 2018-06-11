//
//  NewChooseMedicationFormViewController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 11/6/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import SearchTextField

class NewChooseMedicationFormViewController: UIViewController {

    @IBOutlet weak var tfNombreMedicamento: SearchTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func actionBtnSiguiente(_ sender: Any) {
        
        let nombreMedicamentoElegido = tfNombreMedicamento.text
        
        if nombreMedicamentoElegido!.isEmpty{
            // Creando un elemento de Alert (Dialog en Android)
            let alert = UIAlertController(title: "", message: "El nombre del medicamento no puede estar vacío", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // <-- Fin de Alert -->
        } else {
            
            UserDefaults.standard.set(nombreMedicamentoElegido, forKey: "nombreMedicamento")
            
            performSegue(withIdentifier: "toNewMedicationFormSegue", sender: nil)
        }
    }
    
}
