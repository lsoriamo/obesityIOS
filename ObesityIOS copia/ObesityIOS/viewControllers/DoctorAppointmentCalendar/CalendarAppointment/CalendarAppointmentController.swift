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
    
    @IBOutlet weak var tvAppointment: UITableView!
    @IBOutlet weak var jtAppleCalendar: JTAppleCalendarView!
    @IBOutlet weak var month: UILabel!
    
    let outsideMonthColor = UIColor.lightGray
    let monthColor = UIColor.black
    let selectedMonthColor = UIColor.init(red: 62, green: 93, blue: 152, alpha: 1)
    let currentDateSelectedViewColor = UIColor.init(red: 255, green: 0, blue: 0, alpha: 1) //Ni idea de cual es
    
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
    
    @IBAction func actionBtnNewAppointment(_ sender: Any) {
        self.performSegue(withIdentifier: "toAddAppointmentSegue", sender: nil)
    }
    

}
