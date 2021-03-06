//
//  ViewController.swift
//  ObesityIOS
//
//  Created by Jorge Amores Ortiz on 9/4/18.
//  Copyright © 2018 Preobar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleSignIn
import SearchTextField

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate{
    
    // Éste es el botón de acceso con cuenta de Google
    @IBOutlet weak var btnPrueba: UIButton!
    
    
    @IBOutlet weak var tfEmail: SearchTextField!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var btnGoSignUp: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    var email: String = ""
    var nombre: String = ""
    var apellidos: String = ""
    var pass: String = ""
    var image: String = ""
    var credentials:AuthCredential?
    
    var callback:AuthResultCallback?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setToolbarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        btnSignIn.layer.cornerRadius = 4
        btnPrueba.layer.cornerRadius = 4
        
        btnGoSignUp.titleLabel?.textAlignment = NSTextAlignment.center
        
        // Autocomplete SearchTextField email
        tfEmail.inlineMode = true
        tfEmail.startFilteringAfter = "@"
        tfEmail.startSuggestingInmediately = true
        tfEmail.filterStrings(["gmail.com", "gmail.es", "yahoo.com", "hotmail.com", "hotmail.es", "us.es"])
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            print(error.localizedDescription)
        } else {
            
            email = user.profile.email
            nombre = user.profile.givenName
            apellidos = user.profile.familyName
            
            if user.profile.hasImage {
                image = user.profile.imageURL(withDimension: 100).absoluteString
                
            }
            
            credentials = GoogleAuthProvider.credential(withIDToken: user.authentication.idToken, accessToken: user.authentication.accessToken)
            
            Auth.auth().signInAndRetrieveData(with: credentials!, completion: { (user, error) in
                if let err = error {
                    print("Failed to create a Firebase User with Google account: ", err)
                    return
                }
                
                let userId = user?.user.uid
                                
                UserDefaults.standard.set(userId, forKey: "userId")
                
            })
            
            UserDefaults.standard.set(nombre, forKey: "givenName")
            UserDefaults.standard.set(apellidos, forKey: "familyName")
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(image, forKey: "imageURL")
            
            self.performSegue(withIdentifier: "toIntroMedicationSegue", sender: nil)
        }
    }
    
    @IBAction func btnAccessToGoogleAccount(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func btnAccessUserAccount(_ sender: Any) {
        email = tfEmail.text!
        pass = tfPass.text!
        
        // Comprobación de que el email o contraseña no estén vacíos y que el email cumpla con el patrón estándar
        
        let bolTestEmail:Bool = isValidEmail(emailToCheck: email)
        
        if email == "" || !bolTestEmail{
            // <-- Creando un elemento de Alert (Dialog en Android)
            let alert = UIAlertController(title: "", message: "Email no válido", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // Fin de Alert -->
        }else if pass == "" {
            // <-- Creando un elemento de Alert (Dialog en Android)
            let alert = UIAlertController(title: "", message: "Contraseña no válida", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // Fin de Alert -->
        } else {
            
            let user:User = User()
            
            user.email = email
            user.passhash = pass
            
            Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                if let error = error {
                    print("ERROR: \(error)")
                    
                    // Creando un elemento de Alert (Dialog en Android)
                    let alert = UIAlertController(title: "", message: "Email o contraseña incorrecta", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    // <-- Fin de Alert -->
                    
                    return
                }
                
                UserDefaults.standard.set(user!.user.uid, forKey: "userId")
                
                self.performSegue(withIdentifier: "toIntroMedicationSegue", sender: nil)
                
            }
        }
        
    }
    
    @IBAction func actionBtnRegistro(_ sender: Any) {
        performSegue(withIdentifier: "toRegistroUsuarioSegue", sender: nil)
    }
    
    
    
    // Función que comprueba si el email introducido por el usuario cumple con el patrón estándar
    func isValidEmail(emailToCheck:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailToCheck)
    }
    
    
    /*En cada una de las vistas de tu app que necesitan información sobre el usuario que accedió,
     adjunta un agente de escucha al objeto FIRAuth.
     Se llamará a este agente de escucha cada vez que cambie el estado de acceso del usuario.*/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // [START_EXCLUDE]
            // AQUÍ VA EL CÓDIGO
            // [END_EXCLUDE]
        }
    }
    
    //Además, desvincula el agente de escucha del método viewWillDisappear del controlador de vista:
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // [START remove_auth_listener]
        Auth.auth().removeStateDidChangeListener(handle!)
        // [END remove_auth_listener]
    }

}

