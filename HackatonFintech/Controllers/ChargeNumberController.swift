//
//  ChargeNumberController.swift
//  HackatonFintech
//
//  Created by Victor Manuel Castillo Torres on 1/27/18.
//  Copyright © 2018 HackatonFintech. All rights reserved.
//

import Foundation
import UIKit

class ChargeNumberController:UIViewController, UITextFieldDelegate{
    @IBOutlet weak var numberInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberInput.keyboardType = .decimalPad
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.view.endEditing(true)
        return false;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}
