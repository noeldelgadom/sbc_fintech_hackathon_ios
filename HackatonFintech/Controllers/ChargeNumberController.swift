//
//  ChargeNumberController.swift
//  HackatonFintech
//
//  Created by Victor Manuel Castillo Torres on 1/27/18.
//  Copyright © 2018 HackatonFintech. All rights reserved.
//

import Foundation
import Siesta
import UIKit

class ChargeNumberController:UIViewController, UITextFieldDelegate{
    @IBOutlet weak var numberInput: UITextField!
    
    @IBOutlet weak var conceptInput: UITextField!

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
    @IBAction func generateCode(_ sender: Any) {
        let defaults = UserDefaults.standard
        _API.qrCode().request(.post, json: ["type": defaults.string(forKey: "type"),
                                            "concept": conceptInput.text!,
                                            "ammount": numberInput.text!,
                                            "currency": "MXN",
                                            "id": defaults.string(forKey: "id")]).onSuccess({ entity in
                                                print(entity.content)
                                                DispatchQueue.main.async {
                                                    let storyboardName = "Main"
                                                    let viewControllerID = "scanQRController"
                                                    let storyboard = UIStoryboard(name: storyboardName, bundle:nil)
                                                    let controller = storyboard.instantiateViewController(withIdentifier: viewControllerID) as! ScanQRController
                                                    let json_content = entity.content as! [String:String]
                                                    controller.url = json_content["qr_url"]!
                                                    self.present(controller, animated: true, completion: nil)
                                                    print(entity.content)
                                                }
                                            })
    }
}
