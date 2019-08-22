//
//  UIColor.swift
//  WalmartLabs
//
//  Created by fatih on 8/21/19.
//  Copyright © 2019 fatih. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    public class var outOfStockColor: UIColor
    {
        return UIColor(red: 244/255, green: 48/255, blue: 109/255, alpha: 1.0)
    }
    
    public class var inStockColor: UIColor
    {
        return UIColor(red: 0/255, green: 184/255, blue: 196/255, alpha: 1.0)
    }
}
