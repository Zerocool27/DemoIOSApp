//
//  ApiManager.swift
//  WalmartLabs
//
//  Created by fatih on 8/20/19.
//  Copyright © 2019 fatih. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

typealias APICompletionBlock = (Error?) -> Void
typealias APICompletionDataBlock = (Error?, Data?) -> Void
typealias APICompletionModelBlock = (Error?, BaseModel?) -> Void
typealias APICompletionArrayBlock = (Error?, [BaseModel]?) -> Void

class ApiManager: NSObject {
    static let shared = ApiManager()
}

extension ApiManager {
    
    // MARK: - GET
    func getProductList(pageNumber: Int, pageSize: Int, completion: @escaping APICompletionModelBlock) {
        let fullUrlString = resolvedBackendOrigin() + GET_PRODUCT_LIST + "\(pageNumber)/" + "\(pageSize)"
        if let url = URL(string: fullUrlString) {
            RequestManager.shared.fetchDataWith(url: url, method: .get, params: nil, shouldAuth: false, completion: { (error, responseJSON, response) in
                if let error = error {
                    completion(error, nil)
                } else if let responseJSON = responseJSON as? [String: Any] {
                    let model = Mapper<FirstPageModel>().map(JSON: responseJSON)
                    completion(nil, model)
                } else {
                    completion(nil, nil)
                }
            })
        }
    }
}
