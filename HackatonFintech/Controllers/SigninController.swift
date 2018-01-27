//
//  SigninController.swift
//  HackatonFintech
//
//  Created by Victor Manuel Castillo Torres on 1/26/18.
//  Copyright © 2018 HackatonFintech. All rights reserved.
//

import Foundation
import UIKit
import Siesta

class SigninController:UIViewController, UITextFieldDelegate{
    
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
        print(textField)
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
    
    func validatePasswordAndEmail() -> Bool{
        if(!(emailField.text?.isEmpty)! &&  !(passwordField.text?.isEmpty)!){
            return true
        }else{
            self.showError(msg: "Email y Contraseña son obligatorios")
            return false
        }
    }
    @IBAction func signInAction(_ sender: Any) {
        errorLabel.isHidden = true
        errorLabel.text = ""
        if(self.validatePasswordAndEmail()){
            self.performSegue(withIdentifier: "mainScreenSegue", sender: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
}
