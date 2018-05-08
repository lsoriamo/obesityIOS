//
//  ImagenPerfilAssistantController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 24/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit

class ImagenPerfilAssistantController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var pbImagenPerfil: UIProgressView!
    @IBOutlet weak var ivImagenPerfil: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pbImagenPerfil.setProgress(0.306, animated: false)
        
    }
    
    @IBAction func actionSacarFoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
        } else {
            print("Error inesperado, no se pudo acceder a la cámara")
        }
    }
    
    @IBAction func actionSeleccionarFoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
        } else {
            print("No se pudo obtener acceso a la librería de fotos")
        }
    }
    
    @IBAction func actionBtnSiguiente(_ sender: Any) {
        performSegue(withIdentifier: "toHipertensionAssistantSegue", sender: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.ivImagenPerfil.image = pickedImage
            self.ivImagenPerfil.contentMode = .scaleAspectFit
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
