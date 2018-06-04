//
//  CalendarAppointmentController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 18/5/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import FirebaseDatabase
import JTAppleCalendar

class CalendarAppointmentController: UIViewController, UITableViewDelegate, UITableViewDataSource, JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    let formatter = DateFormatter()
    
    var textMonthYear:String?
    
    var citas:[Appointment] = []
    
    var userId:String?
    
    var ref: DatabaseReference!
    
    var timestamp:Int64?
    
    @IBOutlet weak var tvAppointment: UITableView!
    @IBOutlet weak var jtAppleCalendar: JTAppleCalendarView!
    @IBOutlet weak var month: UILabel!
    
    let outsideMonthColor = UIColor.lightGray
    let monthColor = UIColor.black
    let selectedMonthColor = UIColor.init(red: 62, green: 93, blue: 152, alpha: 1)
    let currentDateSelectedViewColor = UIColor.init(red: 54, green: 93, blue: 157, alpha: 1) //Ni idea de cual es
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCalendarView()
        
        ref = Database.database().reference()
        
        userId = UserDefaults.standard.string(forKey: "userId")
        

        initAppointment();
        
        self.tvAppointment.delegate = self;
        self.tvAppointment.dataSource = self;
        
        self.jtAppleCalendar.calendarDataSource = self
        self.jtAppleCalendar.calendarDelegate = self
        
    }
    
    func setupCalendarView() {
        jtAppleCalendar.minimumLineSpacing = 0
        jtAppleCalendar.minimumInteritemSpacing = 0
        
        // setup labels
        jtAppleCalendar.visibleDates { (visibleDates) in
            self.setupViewOfCalendar(from: visibleDates)
        }
    }
    
    func setupViewOfCalendar(from visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        
        self.formatter.locale = Locale(identifier: "es_ES")
        
        self.formatter.dateFormat = "MMMM 'de' yyyy"
        
        self.month.text = self.formatter.string(from: date)
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else {return}
        
        if cellState.isSelected {
            validCell.dataLabel.textColor = selectedMonthColor
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dataLabel.textColor = monthColor
            } else {
                validCell.dataLabel.textColor = outsideMonthColor
            }
        }
    }
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else {return}
        if cellState.isSelected {
            validCell.selectedView.isHidden = false
        } else {
            validCell.selectedView.isHidden = true
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let currentDate = Date()
        
        let yearToLess = -2
        let yearToAdd = 3
        
        var dateComponent = DateComponents()
        
        dateComponent.year = yearToLess
        let pastDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        dateComponent.year = yearToAdd
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        let parameters = ConfigurationParameters(startDate: currentDate, endDate: futureDate!)
        
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.dataLabel.text = cellState.text
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
    
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)

    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)

    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewOfCalendar(from: visibleDates)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.citas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda:ListItemAppointmentTableViewCell = self.tvAppointment.dequeueReusableCell(withIdentifier: "celda") as! ListItemAppointmentTableViewCell;
        
        let fechaCitaDate:Date = Date.init(timeIntervalSince1970: Double((self.citas[indexPath.row].citeTimestamp)/1000))
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_ES")
        dateFormatter.dateFormat = "EEEE, dd 'de' MMMM 'de' yyyy 'a las' HH:mm"
        
        let fechaCitaStringFormatter = dateFormatter.string(from: fechaCitaDate)
        
        celda.lbEspecialista.text = "Cita con: \(self.citas[indexPath.row].typeEnum)"
        celda.lbFechaCita.text = fechaCitaStringFormatter
        
        return celda;
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Eliminar") { (action, indexPath) in
            
            print("Quiere borrar cita con id: \(self.citas[indexPath.row].timestamp)")
            
            let alertController = UIAlertController(title: "", message: "¿Desea eliminar la cita?", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Cancelar", style: .default) { (action:UIAlertAction) in
            }
            
            let action2 = UIAlertAction(title: "Eliminar", style: .destructive) { (action:UIAlertAction) in
                self.ref.child("users/\(self.userId!)/appointment/cites/\(self.citas[indexPath.row].timestamp)").removeValue()
                
                self.citas.remove(at: indexPath.row)
                
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
            
            alertController.addAction(action1)
            alertController.addAction(action2)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        timestamp = self.citas[indexPath.row].timestamp
        
        let edit = UITableViewRowAction(style: .normal, title: "Editar") { (action, indexPath) in
            self.performSegue(withIdentifier: "toEditAppointmentSegue", sender: self.timestamp)
        }
        
        edit.backgroundColor = UIColor.blue
        
        return [delete, edit]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEditAppointmentSegue" {
            let destino = segue.destination as! EditAppointmentFormViewController
            
            destino.timestamp = timestamp
        }
        
    }
    
    func initAppointment() {
        
        let urlAppointment = "users/\(userId!)/appointment/cites"
        
        ref.child(urlAppointment).observeSingleEvent(of: .value) { (snapshot) in
            
            let dicAppointment = snapshot.value as? NSDictionary
            
            if dicAppointment != nil {
                for idCita in dicAppointment!.allKeys {
                    
                    let timestampString:String = idCita as! String
                    
                    let timestamp:Int64 = Int64(timestampString)!
                    
                    self.ref.child("\(urlAppointment)/\(idCita)").observeSingleEvent(of: .value) { (snapshot) in
                        let value = snapshot.value as? NSDictionary
                        
                        var typeEnum:String = value?["typeEnum"] as? String ?? ""
                        let citesTimestamp:Int64 = value?["citeTimestamp"] as? Int64 ?? 0
                        
                        let currentDate = Date()
                        let appointmentDate = Date(timeIntervalSince1970: Double(citesTimestamp / 1000))
                        
                        if currentDate < appointmentDate {
                            
                            if typeEnum == "endocrino" {
                                typeEnum = "Endocrino"
                            } else if typeEnum == "cirujano" {
                                typeEnum = "Cirujano"
                            } else if typeEnum == "anestesista" {
                                typeEnum = "Anestesista"
                            } else if typeEnum == "psicologo" {
                                typeEnum = "Psicólogo"
                            } else if typeEnum == "atencion_primaria" {
                                typeEnum = "Atención primaria"
                            } else if typeEnum == "medico_familia" {
                                typeEnum = "Médico de familia"
                            } else if typeEnum == "preparador_fisico" {
                                typeEnum = "Preparador físico"
                            } else if typeEnum == "nutricionista" {
                                typeEnum = "Nutricionista"
                            } else if typeEnum == "fisioterapeuta" {
                                typeEnum = "Fisioterapeuta"
                            } else {
                                typeEnum = "Otro especialista"
                            }
                            let appointment:Appointment = Appointment()
                            
                            appointment.typeEnum = typeEnum
                            appointment.citeTimestamp = citesTimestamp
                            appointment.timestamp = timestamp
                            
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
    }
    
    @IBAction func actionBtnNewAppointment(_ sender: Any) {
        self.performSegue(withIdentifier: "toAddAppointmentSegue", sender: nil)
    }
    

}
