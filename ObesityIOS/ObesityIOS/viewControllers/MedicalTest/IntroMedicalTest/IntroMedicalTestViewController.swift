//
//  IntroMedicalTestViewController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 24/5/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class IntroMedicalTestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lbInfo: UILabel!
    @IBOutlet weak var btnMoreInfo: UIButton!
    @IBOutlet weak var tvPruebaMedica: UITableView!
    
    let formatter = DateFormatter()

    var pruebasMedicas:[MedicalTest] = []
    
    var userId:String?
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        print("ID USER: \(userId!)")
        
        initAppointment();
        
        self.tvPruebaMedica.delegate = self;
        self.tvPruebaMedica.dataSource = self;


    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pruebasMedicas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda:ListItemPruebaMedicaTableViewCell = self.tvPruebaMedica.dequeueReusableCell(withIdentifier: "celda") as! ListItemPruebaMedicaTableViewCell;
        
        let fechaCitaDate:Date = Date.init(timeIntervalSince1970: Double((self.pruebasMedicas[indexPath.row].citeTimestamp)/1000))
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_ES")
        dateFormatter.dateFormat = "EEEE, dd 'de' MMMM 'de' yyyy 'a las' HH:mm"
        
        let fechaCitaStringFormatter = dateFormatter.string(from: fechaCitaDate)
        
        //fechaCitaDate = dateFormatter.dateFormat("dddd, dd de MMMM de yyyy")
        
        
        celda.lbTipoPrueba.text = "\(self.pruebasMedicas[indexPath.row].name)"
        //celda.lbFechaCita.text = String(self.citas[indexPath.row].citeTimestamp)
        celda.lbFechaCita.text = fechaCitaStringFormatter
        
        return celda;
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Eliminar") { (action, indexPath) in
            
            let alertController = UIAlertController(title: "", message: "¿Desea eliminar la prueba médica?", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction) in
                
                self.ref.child("users/\(self.userId!)/medical_tests/cites/\(self.pruebasMedicas[indexPath.row].timestamp)").removeValue()
                
                self.pruebasMedicas.remove(at: indexPath.row)
                
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
                
            }
            
            let action2 = UIAlertAction(title: "Cancelar", style: .destructive) { (action:UIAlertAction) in
            }
            
            alertController.addAction(action1)
            alertController.addAction(action2)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        let edit = UITableViewRowAction(style: .normal, title: "Editar") { (action, indexPath) in
            // share item at indexPath
        }
        
        edit.backgroundColor = UIColor.blue
        
        return [delete, edit]
    }
    
    func initAppointment() {
        
        let urlMedicalTest = "users/\(userId!)/medical_tests/cites"
        
        ref.child("users/\(userId!)/medical_tests/cites").observeSingleEvent(of: .value) { (snapshot) in
            
            let dicMedicalTest = snapshot.value as? NSDictionary
            
            if dicMedicalTest != nil {
                
                self.lbInfo.removeFromSuperview()
                self.btnMoreInfo.removeFromSuperview()
                
                self.tvPruebaMedica.translatesAutoresizingMaskIntoConstraints = false
                
                self.tvPruebaMedica.topAnchor.constraintEqualToSystemSpacingBelow(self.view.topAnchor, multiplier: 16).isActive = true
                
                for idCita in dicMedicalTest!.allKeys {
                    
                    let timestampString:String = idCita as! String
                    
                    let timestamp:Int64 = Int64(timestampString)!
                    
                    self.ref.child("\(urlMedicalTest)/\(idCita)").observeSingleEvent(of: .value) { (snapshot) in
                        let value = snapshot.value as? NSDictionary
                        
                        let name:String = value?["name"] as? String ?? ""
                        let citesTimestamp:Int64 = value?["timestampCite"] as? Int64 ?? 0
                        
                        let currentDate = Date()
                        let appointmentDate = Date(timeIntervalSince1970: Double(citesTimestamp / 1000))
                        
                        if currentDate < appointmentDate {
                            let medicalTest:MedicalTest = MedicalTest()
                            
                            medicalTest.name = name
                            medicalTest.citeTimestamp = citesTimestamp
                            medicalTest.timestamp = timestamp
                            
                            self.pruebasMedicas.append(medicalTest)
                            let indexPath1 = IndexPath(row: self.pruebasMedicas.count-1, section: 0)
                            self.tvPruebaMedica.beginUpdates()
                            self.tvPruebaMedica.insertRows(at: [indexPath1], with: UITableViewRowAnimation.automatic)
                            self.tvPruebaMedica.endUpdates()
                        }
                    }
                }
            } else {
                
                self.tvPruebaMedica.removeFromSuperview()
                
            }
        }
    }

    @IBAction func actionBtnMoreInfo(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toMoreInfoPruebasMedicasSegue", sender: nil)
        
    }
}
