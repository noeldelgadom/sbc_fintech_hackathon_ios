//
//  Util.swift
//  HackatonFintech
//
//  Created by Victor Manuel Castillo Torres on 1/27/18.
//  Copyright © 2018 HackatonFintech. All rights reserved.
//

import Foundation
import Siesta

class Util{
    
    
    func saveBalances(_ balances: [String:String]){
        let defaults = UserDefaults.standard
        defaults.set(balances["actual"]!, forKey: "compartamos_current_balance")
        defaults.set(balances["available"]!, forKey: "compartamos_available_balance")
        defaults.set(balances["pendng"]!, forKey: "compartamos_pending_balance")
    }
    
    func getCompartamosAccount() -> Void{
        let defaults = UserDefaults.standard
        let type = defaults.string(forKey: "type")!
        if(type == "Company"){
            _API.getCompartamosAccountForCompany(Int(defaults.string(forKey: "id")!)!)
                .request(.get).onSuccess({ (entity) in
                    let json_content = entity.content as! [String:Any]
                    let balances = json_content["balances"] as! [String:String]
                    self.saveBalances(balances)
                })
        }else if (type == "User"){
            _API.getCompartamosAccountForUser(Int(defaults.string(forKey: "id")!)!)
                .request(.get).onSuccess({ (entity) in
                    let json_content = entity.content as! [String:Any]
                    let balances = json_content["balances"] as! [String:String]
                    self.saveBalances(balances)
                })
        }
    }
}
