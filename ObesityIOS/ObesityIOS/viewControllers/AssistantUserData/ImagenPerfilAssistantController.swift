//
//  ImagenPerfilAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 24/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class ImagenPerfilAssistantController: UIViewController {

    @IBOutlet weak var pbImagenPerfil: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pbImagenPerfil.setProgress(0.4, animated: false)
        
    }

    @IBAction func actionBtnSiguiente(_ sender: Any) {
        performSegue(withIdentifier: "toHipertensionAssistantSegue", sender: nil)
    }
}
