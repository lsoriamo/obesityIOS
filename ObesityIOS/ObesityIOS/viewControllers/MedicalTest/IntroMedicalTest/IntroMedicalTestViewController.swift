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
    
    func initAppointment() {
        
        let urlMedicalTest = "users/\(userId!)/medical_tests/cites"
        
        ref.child("users/\(userId!)/medical_tests/cites").observeSingleEvent(of: .value) { (snapshot) in
            
            let medicalTest:MedicalTest = MedicalTest()
            
            let dicMedicalTest = snapshot.value as? NSDictionary
            
            if dicMedicalTest != nil {
                for idCita in dicMedicalTest!.allKeys {
                    
                    self.ref.child("\(urlMedicalTest)/\(idCita)").observeSingleEvent(of: .value) { (snapshot) in
                        let value = snapshot.value as? NSDictionary
                        
                        let name:String = value?["name"] as? String ?? ""
                        let citesTimestamp:Int64 = value?["timestampCite"] as? Int64 ?? 0
                        
                        let currentDate = Date()
                        let appointmentDate = Date(timeIntervalSince1970: Double(citesTimestamp / 1000))
                        
                        if currentDate < appointmentDate {
                            medicalTest.name = name
                            medicalTest.citeTimestamp = citesTimestamp
                            self.pruebasMedicas.append(medicalTest)
                            let indexPath1 = IndexPath(row: self.pruebasMedicas.count-1, section: 0)
                            self.tvPruebaMedica.beginUpdates()
                            self.tvPruebaMedica.insertRows(at: [indexPath1], with: UITableViewRowAnimation.automatic)
                            self.tvPruebaMedica.endUpdates()
                        }
                    }
                }
            }
        }
    }

    @IBAction func actionBtnMoreInfo(_ sender: Any) {
        
        if lbInfo != nil {
            lbInfo.removeFromSuperview()
            btnMoreInfo.translatesAutoresizingMaskIntoConstraints = false
            
            btnMoreInfo.topAnchor.constraintEqualToSystemSpacingBelow(view.topAnchor, multiplier: 8).isActive = true
        }
        
    }
}
