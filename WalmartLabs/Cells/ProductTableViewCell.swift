//
//  ProductTableViewCell.swift
//  WalmartLabs
//
//  Created by fatih on 8/20/19.
//  Copyright © 2019 fatih. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ProductTableViewCell"
    
    @IBOutlet weak var productImageContainer: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productRating: UILabel!
    @IBOutlet weak var productTotalReviews: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productShortDescription: UILabel!
    @IBOutlet weak var productInStock: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView(){
        self.selectionStyle = .none
    }

}

//MARK: Configuration Methods
extension ProductTableViewCell{
    func configureCell(model: ProductModel){
        if let modelImagePath = model.productImage{
            let url = resolvedBackendOrigin() + modelImagePath
            productImage.loadImage(with: url)
        }
        productName.text = model.productName
        productPrice.text = model.price
        productShortDescription.attributedText = model.shortDescription?.htmlToAttributedString
        productTotalReviews.text = "\(model.reviewCount)"
        productRating.text = "\(model.reviewRating)"
        if model.inStock{
            productInStock.text = "In Stock"
            productInStock.textColor = .inStockColor
        }else{
            productInStock.text = "Out of Stock"
            productInStock.textColor = .outOfStockColor
        }
    }
}
