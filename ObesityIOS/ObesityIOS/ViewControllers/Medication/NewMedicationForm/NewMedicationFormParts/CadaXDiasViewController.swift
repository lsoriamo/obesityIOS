//
//  CadaXDiasViewController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 7/6/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class CadaXDiasViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pvUnidadDosis: UIPickerView!
    @IBOutlet weak var pvCadaXDias: UIPickerView!
    @IBOutlet weak var tfNumeroDosis: UITextField!
    @IBOutlet weak var btnAnadirHora: UIButton!
    @IBOutlet weak var tvHoras: UITableView!
    
    let numeroDias = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]
    
    let unidadDosis = ["Pastilla/s", "Gota/s", "Ampolla/s", "Aplicación/es", "Mililitro/s", "Gramo/s", "Supositorio/s", "Pieza/s", "Unidad/s", "Miligramo/s", "Cápsula/s", "Inhalación/es"]
    
    override func viewDidLoad() {
        pvCadaXDias.dataSource = self
        pvCadaXDias.delegate = self
        pvUnidadDosis.dataSource = self
        pvUnidadDosis.delegate = self
        super.viewDidLoad()
        
        tvHoras.isHidden = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return numeroDias.count
        } else {
            return unidadDosis.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return numeroDias[row]
        } else {
            return unidadDosis[row]
        }
    }
    
    @IBAction func actionBtnAnadirHora(_ sender: Any) {
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
        datePicker.datePickerMode = UIDatePickerMode.time
        vc.view.addSubview(datePicker)
        let editRadiusAlert = UIAlertController(title: "Elija una hora", message: "", preferredStyle: UIAlertControllerStyle.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        editRadiusAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        self.present(editRadiusAlert, animated: true)
    }

}
