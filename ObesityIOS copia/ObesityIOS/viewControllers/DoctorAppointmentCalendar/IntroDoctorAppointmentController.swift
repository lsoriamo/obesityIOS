//
//  IntroDoctorAppointmentController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 8/5/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class IntroDoctorAppointmentController: UIViewController {

    @IBOutlet weak var checkBoxNoMostrarInfo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkBoxNoMostrarInfo.setImage(UIImage(named: "ic_checkbox_default"), for: .normal)

        checkBoxNoMostrarInfo.setImage(UIImage(named: "ic_checkbox_selected"), for: .selected)

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
}
