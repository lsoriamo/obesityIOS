//
//  DiasDeLaSemanaViewController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 7/6/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class DiasDeLaSemanaViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var cbLunes: UIButton!
    @IBOutlet weak var cbMartes: UIButton!
    @IBOutlet weak var cbMiercoles: UIButton!
    @IBOutlet weak var cbJueves: UIButton!
    @IBOutlet weak var cbViernes: UIButton!
    @IBOutlet weak var cbSabado: UIButton!
    @IBOutlet weak var cbDomingo: UIButton!
    @IBOutlet weak var tfNumeroDosis: UITextField!
    @IBOutlet weak var pvUnidadDosis: UIPickerView!
    @IBOutlet weak var btnAnadirHora: UIButton!
    @IBOutlet weak var tvHora: UITableView!
    
    let unidadDosis = ["Pastilla/s", "Gota/s", "Ampolla/s", "Aplicación/es", "Mililitro/s", "Gramo/s", "Supositorio/s", "Pieza/s", "Unidad/s", "Miligramo/s", "Cápsula/s", "Inhalación/es"]
    
    var horaSeleccionadaAnadida:Date?
    
    var horas:[String] = []
    
    var isHoras = false
    
    override func viewDidLoad() {
        pvUnidadDosis.dataSource = self
        pvUnidadDosis.delegate = self
        
        tvHora.delegate = self;
        tvHora.dataSource = self;
        super.viewDidLoad()
        
        if horas.count != 0{
            isHoras = true
        }
        
        if isHoras {
            tvHora.isHidden = false
            
        } else {
            tvHora.isHidden = true
            
        }
        
        cbLunes.setImage(UIImage(named: "ic_checkbox_default"), for: .normal)
        cbLunes.setImage(UIImage(named: "ic_checkbox_selected"), for: .selected)
        
        cbMartes.setImage(UIImage(named: "ic_checkbox_default"), for: .normal)
        cbMartes.setImage(UIImage(named: "ic_checkbox_selected"), for: .selected)
        
        cbMiercoles.setImage(UIImage(named: "ic_checkbox_default"), for: .normal)
        cbMiercoles.setImage(UIImage(named: "ic_checkbox_selected"), for: .selected)
        
        cbJueves.setImage(UIImage(named: "ic_checkbox_default"), for: .normal)
        cbJueves.setImage(UIImage(named: "ic_checkbox_selected"), for: .selected)
        
        cbViernes.setImage(UIImage(named: "ic_checkbox_default"), for: .normal)
        cbViernes.setImage(UIImage(named: "ic_checkbox_selected"), for: .selected)
        
        cbSabado.setImage(UIImage(named: "ic_checkbox_default"), for: .normal)
        cbSabado.setImage(UIImage(named: "ic_checkbox_selected"), for: .selected)
        
        cbDomingo.setImage(UIImage(named: "ic_checkbox_default"), for: .normal)
        cbDomingo.setImage(UIImage(named: "ic_checkbox_selected"), for: .selected)

    }
    
    @IBAction func actionCheckBoxTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unidadDosis.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return unidadDosis[row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.horas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda:ListItemDiasDeLaSemanaViewCell = self.tvHora.dequeueReusableCell(withIdentifier: "celda") as! ListItemDiasDeLaSemanaViewCell;
        
        horas.sort()
        
        celda.lbHora.text = horas[indexPath.row]
        
        return celda;
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Eliminar") { (action, indexPath) in
            
            
            let alertController = UIAlertController(title: "", message: "¿Desea eliminar la hora?", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Cancelar", style: .default) { (action:UIAlertAction) in
            }
            
            let action2 = UIAlertAction(title: "Eliminar", style: .destructive) { (action:UIAlertAction) in
                
                self.horas.remove(at: indexPath.row)
                
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
                
                if self.horas.count == 0 {
                    self.isHoras = false
                    self.tvHora.isHidden = true
                }
            }
            
            alertController.addAction(action1)
            alertController.addAction(action2)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        return [delete]
    }
    
    @IBAction func actionBtnAnadirHora(_ sender: Any) {
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
        datePicker.datePickerMode = UIDatePickerMode.time
        vc.view.addSubview(datePicker)
        let editRadiusAlert = UIAlertController(title: "Elija una hora", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let action1 = UIAlertAction(title: "Cancelar", style: .destructive) { (action:UIAlertAction) in
        }
        
        let action2 = UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction) in
            
            self.horaSeleccionadaAnadida = datePicker.date
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "es_ES")
            dateFormatter.dateFormat = "HH:mm"
            
            let horaSeleccionadaStringFormatter = dateFormatter.string(from: self.horaSeleccionadaAnadida!)
            
            self.horas.append(horaSeleccionadaStringFormatter)
            
            self.tvHora.reloadData()
            
            if !self.isHoras {
                self.tvHora.isHidden = false
            }
            
        }
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(action1)
        editRadiusAlert.addAction(action2)
        self.present(editRadiusAlert, animated: true)
    }

}
