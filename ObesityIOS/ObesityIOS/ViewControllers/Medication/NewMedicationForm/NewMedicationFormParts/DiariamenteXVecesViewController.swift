//
//  DiariamenteXVecesViewController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 7/6/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class DiariamenteXVecesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {


    @IBOutlet weak var pvNumeroVeces: UIPickerView!
    @IBOutlet weak var pvUnidadDosis: UIPickerView!
    @IBOutlet weak var tfNumeroDosis: UITextField!
    @IBOutlet weak var btnAnadirHora: UIButton!
    @IBOutlet weak var tbHoras: UITableView!
    
    let numeroVeces = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    
    let unidadDosis = ["Pastilla/s", "Gota/s", "Ampolla/s", "Aplicación/es", "Mililitro/s", "Gramo/s", "Supositorio/s", "Pieza/s", "Unidad/s", "Miligramo/s", "Cápsula/s", "Inhalación/es"]
    
    override func viewDidLoad() {
        pvNumeroVeces.dataSource = self
        pvNumeroVeces.delegate = self
        pvUnidadDosis.dataSource = self
        pvUnidadDosis.delegate = self
        super.viewDidLoad()

        tbHoras.isHidden = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return numeroVeces.count
        } else {
            return unidadDosis.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return numeroVeces[row]
        } else {
            return unidadDosis[row]
        }
    }

}
