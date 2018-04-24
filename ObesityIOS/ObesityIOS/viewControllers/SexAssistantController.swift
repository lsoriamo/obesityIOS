//
//  SexAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 23/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class SexAssistantController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var pbSexo: UIProgressView!
    
    @IBOutlet weak var pickerViewSex: UIPickerView!
    
    let sex = ["Hombre", "Mujer", "Otro"]
    
    
    override func viewDidLoad() {
        pickerViewSex.dataSource = self
        pickerViewSex.delegate = self
        super.viewDidLoad()
        
        pbSexo.setProgress(0.2, animated: false)

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
        //Falta implementar la lógica de guardar el sexo del usuario
        self.performSegue(withIdentifier: "toProfesionAssistantSegue", sender: nil)
    }
    
}
