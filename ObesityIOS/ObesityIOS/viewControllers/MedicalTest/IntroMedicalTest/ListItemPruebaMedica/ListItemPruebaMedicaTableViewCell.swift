//
//  ListItemPruebaMedicaTableViewCell.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 30/5/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class ListItemPruebaMedicaTableViewCell: UITableViewCell {

    @IBOutlet weak var lbFechaCita: UILabel!
    @IBOutlet weak var lbTipoPrueba: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
