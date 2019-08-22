//
//  ErrorModels.swift
//  WalmartLabs
//
//  Created by fatih on 8/20/19.
//  Copyright © 2019 fatih. All rights reserved.
//

import Foundation

class GenericError: Error {
    var message: String
    
    init(message: String) {
        self.message = message
    }
}

class ServerError: GenericError {
    var code: Int
    
    init(code: Int, message: String) {
        self.code = code
        super.init(message: message)
    }
}

