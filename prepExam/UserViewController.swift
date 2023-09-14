//
//  UserViewController.swift
//  prepExam
//
//  Created by Javier Rodríguez Valentín on 11/10/2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var email = ""
    var db = Firestore.firestore()
    var a:[Int] = []
    
    var array = ["item1","item2","item3"]
    
    init(email:String){
        self.email = email
        super.init(nibName: "UserViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        //esta función te la pone Xcode al meter la función anterior del init
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet var userView: UIView!
    @IBOutlet weak var labelUserTitle: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var inputModEmail: UITextField!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var inputModName: UITextField!
    @IBOutlet weak var labelErase: UILabel!
    
    @IBOutlet weak var btnSaveData: UIButton!
    @IBOutlet weak var btnModifyData: UIButton!
    @IBOutlet weak var btnClearData: UIButton!
    
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnErase: UIButton!
    
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var switchOutlet: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true //oculta el botón back
        navigationController?.isNavigationBarHidden = true //oculta la barra entera
        //navigationItem.setHidesBackButton(true, animated: true) //oculta el botón back
        
        userView.backgroundColor = .cyan
        
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "CellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        table.tableFooterView = UIView() // quitar líneas vacías de la tabla
        
        switchOutlet.isOn = false
        
        labelUserTitle.textAlignment = .center
        labelUserTitle.text = "Datos Usuario"
        labelUserTitle.font = labelUserTitle.font.withSize(30)
        
        labelEmail.textAlignment = .center
        labelEmail.text = "Email"
        labelEmail.font = labelUserTitle.font.withSize(20)
        
        userEmail.textAlignment = .center
        userEmail.text = email
        userEmail.font = labelUserTitle.font.withSize(20)
        
        labelName.textAlignment = .center
        labelName.text = "Nombre"
        labelName.font = labelUserTitle.font.withSize(20)
        
        labelErase.textAlignment = .center
        labelErase.text = "Marque para eliminar la cuenta"
        labelErase.font = labelUserTitle.font.withSize(20)
    
        inputModName.isHidden = true
        inputModEmail.isHidden = true
        
        btnSaveData.setTitle("Guardar datos", for: .normal)
        btnSaveData.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        btnSaveData.tintColor = .white
        btnSaveData.layer.cornerRadius = 12
        btnSaveData.backgroundColor = UIColor(red: 98/255, green: 128/255, blue: 18/255, alpha: 1)
        btnSaveData.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        btnSaveData.titleLabel?.textAlignment = .center
        btnSaveData.titleLabel?.lineBreakMode = .byWordWrapping
        
        btnModifyData.setTitle("Obtener datos", for: .normal)
        btnModifyData.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        btnModifyData.tintColor = .white
        btnModifyData.layer.cornerRadius = 12
        btnModifyData.backgroundColor = UIColor(red: 98/255, green: 128/255, blue: 18/255, alpha: 1)
        btnModifyData.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        btnModifyData.titleLabel?.textAlignment = .center
        btnModifyData.titleLabel?.lineBreakMode = .byWordWrapping
        
        btnClearData.setTitle("Borrar datos", for: .normal)
        btnClearData.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        btnClearData.tintColor = .white
        btnClearData.layer.cornerRadius = 12
        btnClearData.backgroundColor = UIColor(red: 213/255, green: 143/255, blue: 0/255, alpha: 1)
        btnClearData.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        btnClearData.titleLabel?.lineBreakMode = .byWordWrapping
        
        btnLogout.setTitle("LOGOUT", for: .normal)
        btnLogout.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        btnLogout.tintColor = .white
        btnLogout.layer.cornerRadius = 12
        btnLogout.backgroundColor = UIColor(red: 213/255, green: 143/255, blue: 0/255, alpha: 1)
        btnLogout.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        btnLogout.titleLabel?.lineBreakMode = .byWordWrapping
        
        btnErase.setTitle("BORRAR CUENTA", for: .normal)
        btnErase.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        btnErase.tintColor = .white
        btnErase.layer.cornerRadius = 12
        btnErase.backgroundColor = UIColor(red: 255/255, green: 34/255, blue: 0/255, alpha: 1)
        btnErase.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        btnErase.titleLabel?.lineBreakMode = .byWordWrapping
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = table.dequeueReusableCell(withIdentifier: "cell") as? CellTableViewCell
        
        tableCell?.labelCell.text = array[indexPath.row]
        
        return tableCell!
    }
    
    
    

    @IBAction func btnSaveAc(_ sender: Any) {
        if inputModEmail.text! == ""{
            a [0] = 1
        }
        
        if inputModName.text! == ""{
            a [1] = 1
        }
        
        //print(a)
        save(a: a)
    }
    
    @IBAction func btnModAc(_ sender: Any) {
        self.view.endEditing(true) //para hacer desaparecer el teclado
        db.collection("usuarios").document(email).getDocument { (capture, error) in
            
           /* if let document = capture , error == nil{
                
                if let carLicense = document.get("matricula") as? String{
                    self.inputCarLicence.text = carLicense
                }else{
                    self.inputCarLicence.text = ""
                }
                
                if let mark = document.get("marca") as? String{
                    self.inputMark.text = mark
                }else{
                    self.inputMark.text = ""
                }
                
                if let model = document.get("modelo") as? String{
                    self.inputModel.text = model
                }else{
                    self.inputModel.text = ""
                }
                
                if let colour = document.get("color") as? String{
                    self.inputColour.text = colour
                }else{
                    self.inputColour.text = ""
                }
                
                if ((document.get("matricula") as? String) == nil) && ((document.get("marca") as? String) == nil) && ((document.get("modelo") as? String) == nil)
                && ((document.get("color") as? String) == nil){
                    self.alert(titulo: "Modificar datos", msg: "Sin datos para mostrar")
                }
                
            }*/
        }
    }
    
    @IBAction func btnClearAc(_ sender: Any) {
        self.view.endEditing(true) //para hacer desaparecer el teclado
        db.collection("usuarios").document(email).delete()
        alert(titulo: "Borrar datos", msg: "Datos borrados")
        self.userEmail.text = ""
        self.name.text = ""
       
        //borra solo un campo
        //db.collection("usuarios").document(email).updateData(["dieccion" : FieldValue.delete()])
    }
    
    @IBAction func btnLogoutAc(_ sender: Any) {
        logout()
    }
    
    @IBAction func btnEraseAc(_ sender: Any) {
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                // An error happened.
                self.alert(titulo: "Borrar Cuenta", msg: "Error al eliminar la cuenta. Error: \(error)")
            } else {
                // Account deleted.
                self.alert(titulo: "Eliminar cuenta", msg: "Cuenta eliminada")
                self.logout()
            }
        }
    }
    
    //MARK: touchesBegan()
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: logout()
    func logout(){
        do {
            try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        } catch {
            alert(titulo: "Logout", msg: "Error. No se ha podido desloguear")
        }
    }
    
    //MARK: save(a)
    func save(a: [Int]){
        
        var text = ""
        
        if a[0] == 1 && a[1] == 1 {
            
            alert(titulo: "Guardar datos", msg: "Escriba algún campo a guardar")
        
        }else{
            
            var b:[String:String] = [:]
            text = "Se han guardado correctamente los campos: \n"
            
            if a[0] == 0 {
                text += "Email\n"
                //db.collection("usuarios").document(email).setData([ "matricula": inputCarLicence.text!], merge: true)
                b["email"] = inputModEmail.text
                inputModEmail.text = ""
            }
            
            if a[1] == 0{
                text += "Nombre\n"
               //db.collection("usuarios").document(email).setData([ "marca": inputMark.text!], merge: true)
                b["nombre"] = inputModName.text
                inputModName.text = ""
            }
          
            
            for (key, value) in b {
            db.collection("usuarios").document(email).setData([key:value], merge: true)
                //print(key + "-" + value)
            }
            
        }
    }
    
    //MARK: alert()
    func alert(titulo: String, msg:String){
        
        //print("exito")
        let alert = UIAlertController(title: titulo, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        present(alert, animated: true, completion: {/*Para poner el temporizador, se puede poner nil*/ Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: {_ in
            self.dismiss(animated: true, completion: nil)
        })})
    }
    
    @IBAction func `switch`(_ sender: Any) {
    
        if switchOutlet.isOn == true{
            switchOutlet.isOn = false
        }else{
            switchOutlet.isOn = true
        }
        
        
    }
    
}
