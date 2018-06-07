//
//  ListItemMedicationTableViewCell.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 5/6/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class ListItemMedicationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbNombreMedicamento: UILabel!
    @IBOutlet weak var lbSiguienteToma: UILabel!
    @IBOutlet weak var lbDateSiguienteToma: UILabel!
    @IBOutlet weak var lbDosis: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
