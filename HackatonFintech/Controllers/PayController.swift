//
//  PayController.swift
//  HackatonFintech
//
//  Created by Victor Manuel Castillo Torres on 1/27/18.
//  Copyright © 2018 HackatonFintech. All rights reserved.
//

import Foundation
import UIKit
import Siesta
import LocalAuthentication


class PayController:UIViewController{
    var typeToPay: String?
    var recordID: String?
    var accountNumberCompartamos: String?
    var concept: String?
    var ammount: String?
    var currency: String?
    
    
    @IBOutlet weak var conceptLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var ammountLabel: UILabel!
    
    @IBOutlet weak var ammountLabelTop: UILabel!
    @IBOutlet weak var currencyLabelTop: UILabel!
    @IBAction func payTransaction(_ sender: Any) {
        authenticate(successAuth: {
            DispatchQueue.main.async{
                self.performSegue(withIdentifier: "progressPayment", sender: nil)
            }
        }) { (error) in
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "progressPayment"{
            if let destinationVC = segue.destination as? ProcessingPaymentController{
                destinationVC.typeToPay = self.typeToPay
                destinationVC.recordID = self.recordID
                destinationVC.accountNumberCompartamos = self.accountNumberCompartamos
                destinationVC.concept = self.concept
                destinationVC.ammount = self.ammount
                destinationVC.currency = self.currency
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.conceptLabel.text = self.concept!
        self.currencyLabel.text = self.currency!
        self.ammountLabel.text = self.ammount!
        self.ammountLabelTop.text = self.ammount!
        self.currencyLabelTop.text = self.currency!
    }
    
    func authenticate(successAuth: @escaping () -> Void, failure: @escaping (NSError?) -> Void) {
        // 1. Create a authentication context
        let authenticationContext = LAContext()
        var error:NSError?
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            failure(error)
            return
        }
        // 3. Check the fingerprint
        authenticationContext.evaluatePolicy(
            .deviceOwnerAuthentication,
            localizedReason: "Desbloquea para hacer el pago",
            reply: { [unowned self] (success, error) -> Void in
                
                if( success ) {
                    successAuth()
                    
                }else {
                    let message = self.errorMessageForLAErrorCode(errorCode: (error! as NSError).code)
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error", message: "Mensaje", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Intentar de nuevo", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    failure(error! as NSError)
                }
                
        })
        
    }
    
    func errorMessageForLAErrorCode( errorCode:Int ) -> String{
        
        var message = ""
        
        switch errorCode {
            
        case LAError.appCancel.rawValue:
            message = "Autenticación fue cancelada por la aplicación"
            
        case LAError.authenticationFailed.rawValue:
            message = "Autenticación inválida"
            
        case LAError.invalidContext.rawValue:
            message = "El contexto es inválido"
            
        case LAError.passcodeNotSet.rawValue:
            message = "El device no tiene passcode"
            
        case LAError.systemCancel.rawValue:
            message = "La autenticación fue cancelada por el sistema"
            
        case LAError.userCancel.rawValue:
            message = "El usuario canceló"
            
        case LAError.userFallback.rawValue:
            message = "El usuario decidión retroceder"
            
        default:
            message = "Error en la app"
            
        }
        
        return message
    }
}
