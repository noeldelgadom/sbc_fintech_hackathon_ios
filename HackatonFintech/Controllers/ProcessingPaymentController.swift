//
//  ProcessingPaymentController.swift
//  HackatonFintech
//
//  Created by Victor Manuel Castillo Torres on 1/27/18.
//  Copyright © 2018 HackatonFintech. All rights reserved.
//

import Foundation
import UIKit
import Siesta

class ProcessingPaymentController:UIViewController{
    var typeToPay: String?
    var recordID: String?
    var accountNumberCompartamos: String?
    var concept: String?
    var ammount: String?
    var currency: String?
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        var newType = "User"
        if let nt = defaults.string(forKey: "type"){
            if(nt == "User"){
                newType = "Company"
            }else{
                newType = "User"
            }
        }
        _API.transfers.request(.post, json: ["from_model": defaults.string(forKey: "type")!,
                                              "from_id": defaults.string(forKey: "id")!,
                                              "to_model": newType,
                                              "to_id": self.recordID!,  
                                              "ammount": self.ammount!,
                                              "reference": self.concept!]).onSuccess({ entity in
                                                self.performSegue(withIdentifier: "successPayment", sender: nil)
                                              }).onFailure({error in
                                                print(error)
                                                print("ERROR")
                                                self.performSegue(withIdentifier: "wrongPayment", sender: nil)
                                              })
    }
    
 
    
 
}
