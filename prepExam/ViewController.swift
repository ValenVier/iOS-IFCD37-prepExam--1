//
//  ViewController.swift
//  prepExam
//
//  Created by Javier Rodríguez Valentín on 11/10/2021.
//

import UIKit
import FirebaseAuth
import FirebaseAnalytics

class ViewController: UIViewController {
    
    @IBOutlet weak var phoneView: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelPass: UILabel!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPass: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegis: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneView.backgroundColor = .orange
        
        navigationItem.hidesBackButton = true //oculta el botón back
        navigationController?.isNavigationBarHidden = true //oculta la barra entera
        //navigationItem.setHidesBackButton(true, animated: true) //oculta el botón back
        
        labelTitle.textAlignment = .center
        labelTitle.text = "Login Usuario"
        labelTitle.font = labelTitle.font.withSize(30)
        labelEmail.textAlignment = .center
        labelEmail.text = "Email"
        labelEmail.font = labelEmail.font.withSize(20)
        labelPass.textAlignment = .center
        labelPass.text = "Password"
        labelPass.font = labelPass.font.withSize(20)
        
        inputEmail.attributedPlaceholder = NSAttributedString(string: "Escrtiba su nombre", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        inputEmail.keyboardType = .emailAddress//teclado del tipo email
        inputEmail.spellCheckingType = UITextSpellCheckingType.no//para que no cambie palabras de forma automáticamente
        inputEmail.font = UIFont.systemFont(ofSize: 23)
        
        inputPass.attributedPlaceholder = NSAttributedString(string: "Introduzca su contraseña", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        inputPass.isSecureTextEntry = true
        inputPass.font = UIFont.systemFont(ofSize: 23)
        
        btnLogin.setTitle("Login", for: .normal)
        btnLogin.tintColor = .white
        btnLogin.layer.cornerRadius = 12
        btnLogin.backgroundColor = UIColor(red: 98/255, green: 128/255, blue: 18/255, alpha: 1)
        btnLogin.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
       
        btnRegis.setTitle("Registrarse", for: .normal)
        btnRegis.tintColor = .white
        btnRegis.layer.cornerRadius = 12
        btnRegis.backgroundColor = .red
        btnRegis.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        
    }
    
    
    @IBAction func btnLoginAc(_ sender: Any) {
        Auth.auth().signIn(withEmail: inputEmail.text!, password: inputPass.text!) { (result, error) in
            
            if error != nil{
                self.alert(tit: "Login", msg: "Usuario no registrado")
            }else{
                //Si no hay error nos lleva a la siguiente pantalla
                self.navigationController?.pushViewController(UserViewController(email: self.inputEmail.text!), animated: true)
            }
        }
    }
    
    @IBAction func btnRegisAc(_ sender: Any) {
        Auth.auth().createUser(withEmail: inputEmail.text!, password: inputPass.text!) { [self] (result, error) in
            
            guard inputEmail.text! != "", inputPass.text! != "" else{
                //para saber si hay campos vacíos
                if inputEmail.text! != "" && inputPass.text! != ""{
                    alert(tit: "Registro", msg: "No hay datos introducidos")
                }else{
                    if inputPass.text! != ""{
                        alert(tit: "Registro", msg: "Introduzca password")
                    }else{
                        alert(tit: "Registro", msg: "Introduzca email")
                    }
                }
                return
            }
            
            if error != nil{
                alert(tit: "Registro", msg: "Hubo un problema al registrar")
            }else{
                alert(tit: "Registro", msg: "Registro completado con exito")
                //Si no hay error nos lleva a la siguiente pantalla
                navigationController?.pushViewController(UserViewController(email: inputEmail.text!), animated: true)
            }
        }
    }
    
    
    //MARK: viewDidAppear()
    override func viewDidAppear(_ animated: Bool) {
        self.view.endEditing(true) //para hacer desaparecer el teclado
    }
    
    //MARK: touchesBegan()
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Hace desaparecer el teclado cuando se toca en otro lugar que no sea un label -> https://kaushalelsewhere.medium.com/how-to-dismiss-keyboard-in-a-view-controller-of-ios-3b1bfe973ad1
        view.endEditing(true)
    }
    
    //MARK: viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        //para inicializar los campos de textos sin nada escrito
        inputEmail.text = ""
        inputPass.text = ""
    }
    
    //MARK: alert()
    func alert(tit: String, msg:String){
        let alert = UIAlertController(title: tit, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        present(alert, animated: true, completion: {/*Para poner el temporizador, se puede poner nil si no se quiere*/ Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: {_ in
            self.dismiss(animated: true, completion: nil)
        })})
    }
    
}

