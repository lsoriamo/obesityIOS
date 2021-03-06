//
//  DiariamenteXHorasViewController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 7/6/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class DiariamenteXHorasViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var dpPrimeraToma: UIDatePicker!
    @IBOutlet weak var pvCadaXHoras: UIPickerView!
    @IBOutlet weak var pvUnidadDosis: UIPickerView!
    @IBOutlet weak var tfNumeroDosis: UITextField!
    
    let numeroHoras = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
    
    let unidadDosis = ["Pastilla/s", "Gota/s", "Ampolla/s", "Aplicación/es", "Mililitro/s", "Gramo/s", "Supositorio/s", "Pieza/s", "Unidad/s", "Miligramo/s", "Cápsula/s", "Inhalación/es"]
    
    override func viewDidLoad() {
        pvUnidadDosis.dataSource = self
        pvCadaXHoras.delegate = self
        pvUnidadDosis.dataSource = self
        pvUnidadDosis.delegate = self
        super.viewDidLoad()

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return numeroHoras.count
        } else {
            return unidadDosis.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return numeroHoras[row]
        } else {
            return unidadDosis[row]
        }
    }

}
