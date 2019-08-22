//
//  SecondViewController.swift
//  WalmartLabs
//
//  Created by fatih on 8/21/19.
//  Copyright © 2019 fatih. All rights reserved.
//

import UIKit

class SecondViewController: UIPageViewController {
    static let nibName = "SecondViewController"
    var viewModels = [ProductModel]()
    var currentIndex : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

//MARK: Setup Methods
extension SecondViewController{
    func setupView(){
        dataSource = self
        setupViewControllers()
        setupTitle()
    }
    
    func setupViewControllers(){
        if let viewController = configureProductDetailController(currentIndex ?? 0) {
            let viewControllers = [viewController]
            setViewControllers(viewControllers,
                               direction: .forward,
                               animated: false,
                               completion: nil)
        }
    }
    func setupTitle(){
        self.title = "Item Details"
    }
}

//MARK: Configuration Methods
extension SecondViewController{
    func configureProductDetailController(_ index: Int) -> ProductDetailViewController? {
        if let model = viewModels[safe:index]{
            let vc = ProductDetailViewController.initViewController(with:model , index: index)
            return vc
        }
        return nil
    }
}


//MARK: PageViewController Delegate Methods
extension SecondViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? ProductDetailViewController,
            let index = viewController.index,
            index > 0 {
            return configureProductDetailController(index - 1)
        }
        
        return nil
    }
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? ProductDetailViewController,
            let index = viewController.index,
            (index + 1) < viewModels.count {
            return configureProductDetailController(index + 1)
        }
        
        return nil
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewModels.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex ?? 0
    }
}

//MARK: Init Methods
extension SecondViewController{
    static func initViewController(models: [ProductModel], selectedIndex: Int) -> SecondViewController{
        let vc = SecondViewController(nibName: SecondViewController.nibName, bundle: nil)
        vc.viewModels = models
        vc.currentIndex = selectedIndex
        return vc
    }
}
