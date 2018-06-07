//
//  IntroMedicationViewController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 5/6/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class IntroMedicationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var btnMoreInfo: UIButton!
    @IBOutlet weak var lbInfoMedication: UILabel!
    @IBOutlet weak var tvMedication: UITableView!
    
    let formatter = DateFormatter()
    
    var medicaciones:[Medication] = []
    
    var userId:String?
    var ref: DatabaseReference!
    
    var tiempoQueQueda:[String] = []
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        initMedication();
        
        self.tvMedication.delegate = self;
        self.tvMedication.dataSource = self;

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.medicaciones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda:ListItemMedicationTableViewCell = self.tvMedication.dequeueReusableCell(withIdentifier: "celda") as! ListItemMedicationTableViewCell;
        
//        let fechaMedicacionDate:Date = Date.init(timeIntervalSince1970: Double(Double(self.medicaciones[indexPath.row].days)/1000))
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_ES")
        dateFormatter.dateFormat = "EEEE, dd 'de' MMMM 'de' yyyy 'a las' HH:mm"
        
        let fechaMedicacionStringFormatter = dateFormatter.string(from: fechaMedicacionDate)
        
        var parts:[String] = self.medicaciones[indexPath.row].dosage.components(separatedBy: ":::")
        
        let cantidadDosis:String = parts[0]
        let tipoDosis:String = parts[1]
        
        if self.medicaciones[indexPath.row].days.contains(":::") {
            
            tiempoQueQueda = self.medicaciones[indexPath.row].days.components(separatedBy: ":::")
            
        } else {
            
            tiempoQueQueda.append(self.medicaciones[indexPath.row].days)
            
            
        }
        
        
        
        celda.lbDateSiguienteToma.text = fechaMedicacionStringFormatter
        celda.lbNombreMedicamento.text = "\(self.medicaciones[indexPath.row].medicine)"
        celda.lbDosis.text = "Dosis: \(cantidadDosis) \(tipoDosis)"
        
        return celda;
    }
    
    func comprobarFechaDeTomaPastilla(currentDate:Date, nextDate:Date) -> Int64 {
        
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let year = calendar.component(.year, from: currentDate)
        
        let hour = calendar.component(.hour, from: currentDate)
        let minute = calendar.component(.minute, from: currentDate)
        let second = calendar.component(.second, from: currentDate)
        
        
        
        

    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Eliminar") { (action, indexPath) in
            
            let alertController = UIAlertController(title: "", message: "¿Desea eliminar la prueba médica?", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Cancelar", style: .default) { (action:UIAlertAction) in
            }
            
            let action2 = UIAlertAction(title: "Eliminar", style: .destructive) { (action:UIAlertAction) in
                self.ref.child("users/\(self.userId!)/medical_tests/cites/\(self.pruebasMedicas[indexPath.row].timestamp)").removeValue()
                
                self.pruebasMedicas.remove(at: indexPath.row)
                
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
            
            alertController.addAction(action1)
            alertController.addAction(action2)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        timestamp = self.pruebasMedicas[indexPath.row].timestamp
        
        let edit = UITableViewRowAction(style: .normal, title: "Editar") { (action, indexPath) in
            self.performSegue(withIdentifier: "toEditMedicalTestSegue", sender: self.timestamp)
            
        }
        
        edit.backgroundColor = UIColor.blue
        
        return [delete, edit]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEditMedicalTestSegue" {
            let destino = segue.destination as! EditMedicalTestViewController
            
            destino.timestamp = timestamp
        }
        
    }

}
