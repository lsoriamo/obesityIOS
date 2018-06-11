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
    
    var isSomeDate = false
    var timestamp:Double?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        
        initMedication();
        
        self.tvMedication.delegate = self;
        self.tvMedication.dataSource = self;

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.medicaciones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda:ListItemMedicationTableViewCell = self.tvMedication.dequeueReusableCell(withIdentifier: "celda") as! ListItemMedicationTableViewCell;
        
        var parts:[String] = self.medicaciones[indexPath.row].dosage.components(separatedBy: ":::")
        
        let cantidadDosis:String = parts[0]
        let tipoDosis:String = parts[1]
        
        if self.medicaciones[indexPath.row].days == "" {
            
        } else {
            
            if self.medicaciones[indexPath.row].days.contains(":::") {
                
                tiempoQueQueda = self.medicaciones[indexPath.row].days.components(separatedBy: ":::")
                
                var currentDate = Date()
                
                var hourDiferencia = 0
                var minuteDirefencia = 0
                
                repeat {
                    
                    for fecha in tiempoQueQueda {
                        
                        let fechaTimestamp = Double(fecha)
                        
                        let currentDateTimestamp:Double = Double(currentDate.timeIntervalSince1970)
                        
                        if fechaTimestamp! > currentDateTimestamp {
                            
                            let fechaDate = Date(timeIntervalSince1970: fechaTimestamp!)
                            let calendar = Calendar(identifier: .gregorian)
                            
                            let hourFecha = calendar.component(.hour, from: fechaDate)
                            let minuteFecha = calendar.component(.minute, from: fechaDate)
                            let secondFecha = calendar.component(.second, from: fechaDate)
                            
                            let secondTotalesFecha = (hourFecha * 3600) + (minuteFecha * 60) + secondFecha
                            
                            let hourCurrent = calendar.component(.hour, from: currentDate)
                            let minuteCurrent = calendar.component(.minute, from: currentDate)
                            let secondCurrent = calendar.component(.second, from: currentDate)
                            
                            let secondTotalesCurrent = (hourCurrent*3600) + (minuteCurrent*60) + secondCurrent
                            
                            let diferenciaSegundos:Double = Double(secondTotalesFecha - secondTotalesCurrent)
                            
                            let diferenciaDate = Date(timeIntervalSince1970: diferenciaSegundos)
                            
                            hourDiferencia = calendar.component(.hour, from: diferenciaDate)
                            minuteDirefencia = calendar.component(.minute, from: diferenciaDate)
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.locale = Locale(identifier: "es_ES")
                            dateFormatter.dateFormat = "EEEE, dd 'de' MMMM 'de' yyyy 'a las' HH:mm"
                            let fechaMedicacionStringFormatter = dateFormatter.string(from: fechaDate)
                            
                            celda.lbDateSiguienteToma.text = fechaMedicacionStringFormatter
                            
                            isSomeDate = true
                            break
                        }
                    }
                    
                    if !isSomeDate {
                        
                        let dayToAdd = 1
                        var dateComponent = DateComponents()
                        
                        dateComponent.day = dayToAdd
                        
                        currentDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)!
                    }
                    
                } while !isSomeDate
                
                if hourDiferencia == 0 && minuteDirefencia == 0{
                    
                    celda.lbSiguienteToma.text = "Siguiente toma en menos de un minuto"

                } else if minuteDirefencia == 0 {
                    
                    celda.lbSiguienteToma.text = "Siguiente toma en \(hourDiferencia) hora/s"

                    
                } else if hourDiferencia == 0 {
                    
                    celda.lbSiguienteToma.text = "Siguiente toma en \(minuteDirefencia) minuto/s"

                } else {
                    
                    celda.lbSiguienteToma.text = "Siguiente toma en \(hourDiferencia) hora/s y \(minuteDirefencia) minuto/s"
                    
                }
                
                
            } else {
                
                tiempoQueQueda.append(self.medicaciones[indexPath.row].days)
                
                var currentDate = Date()
                
                var hourDiferencia = 0
                var minuteDirefencia = 0
                
                repeat{
                    
                    let fechaTimestamp = Double(tiempoQueQueda[0])
                    let currentTimestamp = Double(currentDate.timeIntervalSince1970)
                    
                    if fechaTimestamp! > currentTimestamp {
                        let fechaDate = Date(timeIntervalSince1970: fechaTimestamp!)
                        let calendar = Calendar(identifier: .gregorian)
                        
                        let hourFecha = calendar.component(.hour, from: fechaDate)
                        let minuteFecha = calendar.component(.minute, from: fechaDate)
                        let secondFecha = calendar.component(.second, from: fechaDate)
                        
                        let secondTotalesFecha = (hourFecha * 3600) + (minuteFecha * 60) + secondFecha
                        
                        let hourCurrent = calendar.component(.hour, from: currentDate)
                        let minuteCurrent = calendar.component(.minute, from: currentDate)
                        let secondCurrent = calendar.component(.second, from: currentDate)
                        
                        let secondTotalesCurrent = (hourCurrent*3600) + (minuteCurrent*60) + secondCurrent
                        
                        let diferenciaSegundos:Double = Double(secondTotalesFecha - secondTotalesCurrent)
                        
                        let diferenciaDate = Date(timeIntervalSince1970: diferenciaSegundos)
                        
                        hourDiferencia = calendar.component(.hour, from: diferenciaDate)
                        minuteDirefencia = calendar.component(.minute, from: diferenciaDate)
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.locale = Locale(identifier: "es_ES")
                        dateFormatter.dateFormat = "EEEE, dd 'de' MMMM 'de' yyyy 'a las' HH:mm"
                        let fechaMedicacionStringFormatter = dateFormatter.string(from: fechaDate)
                        
                        celda.lbDateSiguienteToma.text = fechaMedicacionStringFormatter
                        
                        isSomeDate = true
                    }
                    
                } while !isSomeDate
                
                if hourDiferencia == 0 && minuteDirefencia == 0{
                    
                    celda.lbSiguienteToma.text = "Siguiente toma en menos de un minuto"
                    
                } else if minuteDirefencia == 0 {
                    
                    celda.lbSiguienteToma.text = "Siguiente toma en \(hourDiferencia) hora/s"
                    
                    
                } else if hourDiferencia == 0 {
                    
                    celda.lbSiguienteToma.text = "Siguiente toma en \(minuteDirefencia) minuto/s"
                    
                } else {
                    
                    celda.lbSiguienteToma.text = "Siguiente toma en \(hourDiferencia) hora/s y \(minuteDirefencia) minuto/s"
                    
                }
            }
        }
        
        
        celda.lbNombreMedicamento.text = "\(self.medicaciones[indexPath.row].medicine)"
        celda.lbDosis.text = "Dosis: \(cantidadDosis) \(tipoDosis)"
        
        return celda;
    }
    
//    func comprobarFechaDeTomaPastilla(currentDate:Date, nextDate:Date) -> Date {
//
//        let calendar = Calendar.current
//        var dateComponent = DateComponents()
//
//        dateComponent.day = calendar.component(.day, from: currentDate)
//        dateComponent.month = calendar.component(.month, from: currentDate)
//        dateComponent.year = calendar.component(.year, from: currentDate)
//
//        dateComponent.hour = calendar.component(.hour, from: nextDate)
//        dateComponent.minute = calendar.component(.minute, from: nextDate)
//        dateComponent.second = calendar.component(.second, from: nextDate)
//
//        let dateFrankestein:Date = dateComponent.date!
//
//        return dateFrankestein
//
//    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Eliminar") { (action, indexPath) in
            
            let alertController = UIAlertController(title: "", message: "¿Desea eliminar la medicación?", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Cancelar", style: .default) { (action:UIAlertAction) in
            }
            
            let action2 = UIAlertAction(title: "Eliminar", style: .destructive) { (action:UIAlertAction) in
                self.ref.child("users/\(self.userId!)/medicine/drugs/\(self.medicaciones[indexPath.row].timestamp)").removeValue()
                
                self.medicaciones.remove(at: indexPath.row)
                
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
            
            alertController.addAction(action1)
            alertController.addAction(action2)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        timestamp = self.medicaciones[indexPath.row].timestamp
        
        let edit = UITableViewRowAction(style: .normal, title: "Editar") { (action, indexPath) in
            self.performSegue(withIdentifier: "toEditMedicationTestSegue", sender: self.timestamp)
            
        }
        
        edit.backgroundColor = UIColor.blue
        
        return [delete, edit]
    }
    
    
//    TODO POR COMPLETAR
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "toEditMedicationTestSegue" {
//            let destino = segue.destination as! EditMedicalTestViewController
//
//            destino.timestamp = timestamp
//        }
//
//    }
    
    func initMedication() {
        
        let urlMedication = "users/\(userId!)/medicine/drugs"
        
        ref.child(urlMedication).observeSingleEvent(of: .value) { (snapshot) in
            
            let dicMedication = snapshot.value as? NSDictionary
            
            if dicMedication != nil {
                
                self.lbInfoMedication.removeFromSuperview()
                self.btnMoreInfo.removeFromSuperview()
                
                self.tvMedication.translatesAutoresizingMaskIntoConstraints = false
                
                self.tvMedication.topAnchor.constraintEqualToSystemSpacingBelow(self.view.topAnchor, multiplier: 16).isActive = true
                
                for idMedication in dicMedication!.allKeys {
                    
                    let timestampString:String = idMedication as! String
                    let timestamp:Double = Double(timestampString)!
                    
                    self.ref.child("\(urlMedication)/\(idMedication)").observeSingleEvent(of: .value) { (snapshot) in
                        let value = snapshot.value as? NSDictionary
                        
                        let medicine:String = value?["medicine"] as? String ?? ""
                        let days:String = value?["days"] as? String ?? ""
                        let beginTimestamp:Double = value?["beginTimestamp"] as? Double ?? 0
                        let dosage:String = value?["dosage"] as? String ?? ""
                        let endTimestamp:Double = value?["endTimestamp"] as? Double ?? 0
                        let method:String = value?["method"] as? String ?? ""

                        let medication:Medication = Medication()
                            
                        medication.medicine = medicine
                        medication.days = days
                        medication.begin_timestamp = beginTimestamp
                        medication.end_timestamp = endTimestamp
                        medication.timestamp = timestamp
                        medication.method = method
                        medication.dosage = dosage
                        
                        self.medicaciones.append(medication)
                        let indexPath1 = IndexPath(row: self.medicaciones.count-1, section: 0)
                        self.tvMedication.beginUpdates()
                        self.tvMedication.insertRows(at: [indexPath1], with: UITableViewRowAnimation.automatic)
                        self.tvMedication.endUpdates()
                        
                    }
                }
            } else {
                
                self.tvMedication.removeFromSuperview()
                
            }
        }
    }

}