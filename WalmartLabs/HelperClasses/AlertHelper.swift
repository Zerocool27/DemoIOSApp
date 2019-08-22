//
//  AlertHelper.swift
//  WalmartLabs
//
//  Created by fatih on 8/20/19.
//  Copyright © 2019 fatih. All rights reserved.
//

import Foundation
import UIKit

typealias AlertCompletionBlock = () -> ()

class AlertHelper {
    static let shared = AlertHelper()
    
    func alertErrorWith(title: String?, message: String?, okAction: AlertCompletionBlock? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            if let completion = okAction {
                completion()
            }
        }))
        return alertController
    }
}
