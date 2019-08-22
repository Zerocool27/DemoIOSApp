//
//  NetworkConstants.swift
//  WalmartLabs
//
//  Created by fatih on 8/20/19.
//  Copyright © 2019 fatih. All rights reserved.
//


import Foundation

// MARK: - Backend Endpoints
let BASE_URL_1 = "https://mobile-tha-server.firebaseapp.com" //WALMARTLAB ENVIRONMENT

func resolvedBackendOrigin() -> String! {
    return BASE_URL_1;
}

// MARK: - Timeout
let REQUEST_TIMEOUT: TimeInterval = 60

// MARK: - Network
// MARK: GET ENDPOINTS
let GET_PRODUCT_LIST = "/walmartproducts/"

