//
//  SigninResource.swift
//  HackatonFintech
//
//  Created by Victor Manuel Castillo Torres on 1/26/18.
//  Copyright © 2018 HackatonFintech. All rights reserved.
//

import Foundation
import Siesta
import SwiftyJSON

let _API = API()

class API {
    
    var users: Resource {return service.resource("/users")}
    var companies: Resource {return service.resource("/companies")}
    
    // MARK: - Configuration
    
    private let service = Service(
        baseURL: "https://dinub-api.herokuapp.com",
        standardTransformers: [.json]
    )
    
    fileprivate init() {
        // –––––– Global configuration ––––––
        
        #if DEBUG
            LogCategory.enabled = [.network]
        #endif
        
        service.configure {
//            $0.pipeline[.parsing].add(SwiftyJSONTransformer, contentTypes: ["*/json"])
            $0.expirationTime = 3600
        }
    }
    
    // MARK: - Resource Accessors
    func ping() -> Resource {
        return service.resource("/users")
    }
    
    func getUser(_ userID: Int) -> Resource{
        return service.resource("/users/\(userID)")
    }
    
    func getCompany(_ userCompany: Int) -> Resource{
        return service.resource("/companies/\(userCompany)")
    }
    
    func qrCode() -> Resource{
        return service.resource("/create_qr_code/")
    }
    
    func getCompartamosAccountForCompany(_ companyID: Int) -> Resource{
        return service.resource("/companies/\(companyID)/balance")
    }
    
    func getCompartamosAccountForUser(_ userID: Int) -> Resource{
        return service.resource("/users/\(userID)/balance")
    }
    
}
private let SwiftyJSONTransformer =
    ResponseContentTransformer
        {JSON($0.content as [String:Any])}

