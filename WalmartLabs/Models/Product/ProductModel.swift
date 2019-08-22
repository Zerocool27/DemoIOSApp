//
//  ProductModel.swift
//  WalmartLabs
//
//  Created by fatih on 8/20/19.
//  Copyright © 2019 fatih. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductModel: BaseModel {
    
    var productId : String?
    var productName : String?
    var shortDescription : String?
    var longDescription : String?
    var price : String?
    var productImage : String?
    var reviewRating : Int = 0
    var reviewCount : Int = 0
    var inStock : Bool = false
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        productId <- map["productId"]
        productName <- map["productName"]
        shortDescription <- map["shortDescription"]
        longDescription <- map["longDescription"]
        price <- map["price"]
        productImage <- map["productImage"]
        reviewRating <- map["reviewRating"]
        reviewCount <- map["reviewCount"]
        inStock <- map["inStock"]
    }
}
