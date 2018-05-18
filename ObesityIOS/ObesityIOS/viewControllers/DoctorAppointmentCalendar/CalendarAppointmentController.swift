//
//  CalendarAppointmentController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 18/5/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CalendarAppointmentController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var citas:[Appointment] = []
    
    var userId:String?
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var tvAppointment: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")


        initAppointment();
        
        self.tvAppointment.delegate = self;
        self.tvAppointment.dataSource = self;
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.citas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda:ListItemAppointmentTableViewCell = self.tvAppointment.dequeueReusableCell(withIdentifier: "celda") as! ListItemAppointmentTableViewCell;
        
        let fechaCitaDate:Date = Date.init(timeIntervalSince1970: Double((self.citas[indexPath.row].citeTimestamp)/1000))
        
        print("EN UNIX: ", self.citas[indexPath.row].citeTimestamp)
        
        print("EN FECHA CORRIENTE", fechaCitaDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_ES")
        dateFormatter.dateFormat = "EEEE, dd 'de' MMMM 'de' yyyy 'a las' HH:mm"
        
        let fechaCitaStringFormatter = dateFormatter.string(from: fechaCitaDate)
        
        //fechaCitaDate = dateFormatter.dateFormat("dddd, dd de MMMM de yyyy")
        
        
        celda.lbEspecialista.text = "Cita con: \(self.citas[indexPath.row].typeEnum)"
        //celda.lbFechaCita.text = String(self.citas[indexPath.row].citeTimestamp)
        celda.lbFechaCita.text = fechaCitaStringFormatter
        
        return celda;
        
    }
    
    func initAppointment() {
        
        let urlAppointment = "users/\(userId!)/appointment/cites"
        
        ref.child(urlAppointment).observeSingleEvent(of: .value) { (snapshot) in
            let appointment:Appointment = Appointment()
            
            let dicAppointment = snapshot.value as? NSDictionary

            for idCita in dicAppointment!.allKeys {
                
                self.ref.child("\(urlAppointment)/\(idCita)").observeSingleEvent(of: .value) { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    
                    let typeEnum:String = value?["typeEnum"] as? String ?? ""
                    let citesTimestamp:Int64 = value?["citeTimestamp"] as? Int64 ?? 0
                    
                    appointment.typeEnum = typeEnum
                    appointment.citeTimestamp = citesTimestamp
                    self.citas.append(appointment)
                    let indexPath1 = IndexPath(row: self.citas.count-1, section: 0)
                    self.tvAppointment.beginUpdates()
                    self.tvAppointment.insertRows(at: [indexPath1], with: UITableViewRowAnimation.automatic)
                    self.tvAppointment.endUpdates()
                    
                }
            }
        
        }
    }

}
