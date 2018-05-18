//
//  ListItemAppointmentTableViewCell.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 18/5/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class ListItemAppointmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbEspecialista: UILabel!
    @IBOutlet weak var lbFechaCita: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
