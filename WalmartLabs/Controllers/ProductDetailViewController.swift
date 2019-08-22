//
//  ProductDetailViewController.swift
//  WalmartLabs
//
//  Created by fatih on 8/21/19.
//  Copyright © 2019 fatih. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    static let nibName = "ProductDetailViewController"
    var index : Int!
    var model : ProductModel!
    
    @IBOutlet var mainContainer: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productTotalReviews: UILabel!
    @IBOutlet weak var productRating: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productLongDescription: UILabel!
    @IBOutlet weak var productInStock: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

//MARK: Setup Methods
extension ProductDetailViewController{
    func setupView(){
        setupViewModel()
        setupScrollView()
    }
    
    func setupViewModel(){
        if let model = self.model{
            if let modelImagePath = model.productImage{
                let url = resolvedBackendOrigin() + modelImagePath
                productImage.loadImage(with: url)
            }
            productName.text = model.productName
            productPrice.text = model.price
            if let longDescription = model.longDescription{
                productLongDescription.attributedText = longDescription.htmlToAttributedString
            }else{
                productLongDescription.attributedText = model.shortDescription?.htmlToAttributedString
            }
            
            productTotalReviews.text = "\(model.reviewCount)"
            productRating.text = "\(model.reviewRating)"
            if model.inStock{
                productInStock.text = "In Stock"
                productInStock.textColor = .inStockColor
            }else{
                productInStock.text = "Out of Stock"
                productInStock.textColor = .outOfStockColor
            }
            self.view.layoutIfNeeded()
        }
    }
    
    func setupScrollView(){
        scrollView.isDirectionalLockEnabled = true
        scrollView.bounces = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
    }
}

//MARK: Init Methods
extension ProductDetailViewController{
    static func initViewController(with model: ProductModel, index: Int) -> ProductDetailViewController{
        let vc = ProductDetailViewController(nibName: ProductDetailViewController.nibName, bundle: nil)
        vc.model = model
        vc.index = index
        return vc
    }
}
