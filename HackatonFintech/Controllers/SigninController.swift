//
//  SigninController.swift
//  HackatonFintech
//
//  Created by Victor Manuel Castillo Torres on 1/26/18.
//  Copyright © 2018 HackatonFintech. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Siesta

class SigninController:UIViewController, UITextFieldDelegate, ResourceObserver{
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var statusOverlay = ResourceStatusOverlay()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusOverlay.embed(in: self)
        self.emailField.delegate = self
        self.passwordField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
 
        self.view.endEditing(true)
        return false;
    }
    
    func showError(msg: String){
        errorLabel.text = msg
        errorLabel.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        statusOverlay.positionToCoverParent()

    }
    
    func getUserFakeInfo(){
        _API.users.addObserver(statusOverlay)
        _API.getUser(1).request(.get).onSuccess( { (entity) in
            let json_content = entity.content as! [String:Any]
            self.saveIntoUserDefaults(name: json_content["name"] as! String, id: json_content["id"] as! Int, type: "User")
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "mainScreenSegue", sender: nil)
            }
        }).onFailure { (error) in
            self.showError(msg: "Error al iniciar, intenta de nuevo por favor")
        }
    }
    
    func getCompanyFakeInfo(){
        _API.companies.addObserver(statusOverlay)
        _API.getCompany(1).request(.get).onSuccess({(entity) in
            let json_content = entity.content as! [String:Any]
            self.saveIntoUserDefaults(name: json_content["name"] as! String, id: json_content["id"] as! Int, type: "Company")
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "mainScreenSegue", sender: nil)
            }
        }).onFailure { (error) in
            self.showError(msg: "Error al iniciar, intenta de nuevo por favor")
        }
    }
    
    func saveIntoUserDefaults(name: String,id: Int, type: String){
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "name")
        defaults.set(id, forKey: "id")
        defaults.set(type,forKey: "type")
        defaults.set(self.emailField.text!,forKey: "email")
    }
    
    func validatePasswordAndEmail() -> Bool{
        if((emailField.text?.isEmpty)! ||  (passwordField.text?.isEmpty)!){
            self.showError(msg: "Email y Contraseña son obligatorios")
            return false                                   
        }
        return true
    }
    @IBAction func signInAction(_ sender: Any) {
        errorLabel.isHidden = true
        errorLabel.text = ""
        if(self.validatePasswordAndEmail()){
            if(emailField.text == "usuario@email.com"){
                getUserFakeInfo()
            }else if(emailField.text == "negocio@email.com"){ //Harcodeado por ahora, para no invertir tiempo en esto, lo que importa es la demás funcionalidad
                getCompanyFakeInfo()
            }
        }
    }
    
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
}
