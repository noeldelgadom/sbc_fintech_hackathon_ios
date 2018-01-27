//
//  ChargePayController.swift
//  HackatonFintech
//
//  Created by Victor Manuel Castillo Torres on 1/27/18.
//  Copyright © 2018 HackatonFintech. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

class ChargePayController: UIViewController{
    @IBAction func chargePressed(_ sender: Any) {
//        authenticate(successAuth: {
//
//        }, failure: { error in
//
//        })
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
            localizedReason: "Unlock to send the money",
            reply: { [unowned self] (success, error) -> Void in
                
                if( success ) {
                    successAuth()
                    
                }else {
                    let message = self.errorMessageForLAErrorCode(errorCode: (error! as NSError).code)
                    print(message)
                    failure(error! as NSError)
                }
                
        })
        
    }
    
    func errorMessageForLAErrorCode( errorCode:Int ) -> String{
        
        var message = ""
        
        switch errorCode {
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.biometryLockout.rawValue:
            message = "Too many failed attempts."
            
        case LAError.biometryNotAvailable.rawValue:
            message = "TouchID is not available on the device"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = "Did not find error code on LAError object"
            
        }
        
        return message
    }
}
