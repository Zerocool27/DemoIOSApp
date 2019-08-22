//
//  FirstPageModel.swift
//  WalmartLabs
//
//  Created by fatih on 8/20/19.
//  Copyright © 2019 fatih. All rights reserved.
//

import Foundation
import ObjectMapper

class FirstPageModel: BaseModel {
    
    var products = [ProductModel]()
    var totalProducts : Int = 0
    var pageNumber : Int = 0
    var pageSize : Int = 0
    var statusCode : Int = 0
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        products <- map["products"]
        totalProducts <- map["totalProducts"]
        pageNumber <- map["pageNumber"]
        pageSize <- map["pageSize"]
        statusCode <- map["statusCode"]
    }
}
