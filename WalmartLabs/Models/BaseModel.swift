//
//  BaseModel.swift
//  WalmartLabs
//
//  Created by fatih on 8/20/19.
//  Copyright © 2019 fatih. All rights reserved.
//

import ObjectMapper

class BaseModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        // no implementation. This function should be overriden by children
    }
}
