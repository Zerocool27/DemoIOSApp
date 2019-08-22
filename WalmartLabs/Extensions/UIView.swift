//
//  UIView.swift
//  WalmartLabs
//
//  Created by fatih on 8/20/19.
//  Copyright © 2019 fatih. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addShadowWith(radius: CGFloat, opacity: Float, offSet: CGSize = .zero) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = false
    }
}
