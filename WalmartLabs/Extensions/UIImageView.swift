//
//  UIImageView.swift
//  WalmartLabs
//
//  Created by fatih on 8/20/19.
//  Copyright © 2019 fatih. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadImage(with urlString: String?) {
        if let urlString = urlString,
            let url = URL(string: urlString) {
            sd_setImage(with: url)
        }
    }
}
