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

class API: Service{
    var signin: Resource { return resource("/signin") }
    
    private init(){
        super.init(baseURL: "https://facebook.com")
        
        self.configure {
            $0.pipeline[.parsing].add(SwiftyJSONTransformer, contentTypes: ["*/json"])
            $0.expirationTime = 3600
        }
    }
    
}

private let SwiftyJSONTransformer =
    ResponseContentTransformer
        {JSON($0.content as AnyObject)}
