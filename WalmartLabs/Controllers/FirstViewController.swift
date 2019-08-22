//
//  ViewController.swift
//  WalmartLabs
//
//  Created by fatih on 8/20/19.
//  Copyright © 2019 fatih. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var tableFooterView : UIActivityIndicatorView!
    
    let estimatedCellHeight : CGFloat = 150
    var firstPageModel : FirstPageModel?
    let initialPage = 1
    let initialPageSize = 30
    var isLoadingMoreProducts : Bool = false
    var isAllProductsRetrieved : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

//Mark: Setup Methods
extension FirstViewController{
    func setupView(){
        setupTableView()
        setupActivityIndicator()
        setupTableFooterView()
        setupTitle()
    }
    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: ProductTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier)
        getProductList()
    }
    func setupActivityIndicator(){
        activityIndicator.hidesWhenStopped = true
    }
    func setupTableFooterView(){
        tableFooterView = UIActivityIndicatorView(style: .gray)
        tableFooterView.hidesWhenStopped = true
        tableFooterView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50)
        tableView.tableFooterView = tableFooterView
        tableView.tableFooterView?.isHidden = true
    }
    
    func setupTitle(){
        self.title = "Products"
    }
}

//MARK: Helper Methods
extension FirstViewController{
    
    func handleLoadMore(model: FirstPageModel){
        if let currentModel = firstPageModel{
            if model.products.count > 0 {
                var indexPaths = [IndexPath]()
                for product in model.products {
                    indexPaths.append(IndexPath(item: currentModel.products.count, section: 0))
                    currentModel.products.append(product)
                }
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: indexPaths, with: .none)
                self.tableView.endUpdates()
                self.isLoadingMoreProducts = false
                self.firstPageModel?.pageNumber = model.pageNumber
                self.firstPageModel?.pageSize = model.pageSize
                self.isAllProductsRetrieved = false
                view.layoutIfNeeded()
            }else{
                self.isAllProductsRetrieved = true
                shouldShowLoadMoreIndicator(false)
            }
        }
    }
    
    func openProductDetails(index: Int){
        guard let model = firstPageModel else{
            return
        }
        let vc = SecondViewController.initViewController(models: model.products,selectedIndex: index)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func shouldShowLoadMoreIndicator(_ show: Bool){
        if show{
            tableFooterView.startAnimating()
            tableView.tableFooterView?.isHidden = false
        }else{
            tableFooterView.stopAnimating()
            tableView.tableFooterView?.isHidden = true
        }
    }
}

//MARK: TableView Delegate Methods
extension FirstViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return estimatedCellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = firstPageModel{
            return model.products.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseIdentifier) as? ProductTableViewCell{
            if let model = firstPageModel?.products[safe: indexPath.row]{
                cell.configureCell(model: model)
                cell.layoutIfNeeded()
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = firstPageModel?.products[safe: indexPath.row]{
            openProductDetails(index: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            if !isLoadingMoreProducts,
                !isAllProductsRetrieved {
                isLoadingMoreProducts = true
                getMoreProducts()
            }
        }
    }
}

//MARK: API Methods
extension FirstViewController{
    func getProductList(){
        ApiManager.shared.getProductList(pageNumber: initialPage, pageSize: initialPageSize, completion:{ (error, model) in
            DispatchQueue.main.async { [weak self] in
                if let error = error as? ServerError {
                    self?.present(AlertHelper.shared.alertErrorWith(title: nil,
                                                                    message: error.message,
                                                                    okAction: nil),
                                  animated: true,
                                  completion: nil)
                } else if let firstPageModel = model as? FirstPageModel {
                    self?.firstPageModel = firstPageModel
                    //print("MODEL",firstPageModel)
                    self?.tableView.reloadData()
                }
                self?.activityIndicator.stopAnimating()
            }
        })
    }
    func getMoreProducts(){
        shouldShowLoadMoreIndicator(true)
        if let page = firstPageModel?.pageNumber,
            let pageSize = firstPageModel?.pageSize{
            ApiManager.shared.getProductList(pageNumber: page + 1, pageSize: pageSize, completion:{ (error, model) in
                DispatchQueue.main.async { [weak self] in
                    if let error = error as? ServerError {
                        self?.isLoadingMoreProducts = false
                        self?.present(AlertHelper.shared.alertErrorWith(title: nil,
                                                                        message: error.message,
                                                                        okAction: nil),
                                      animated: true,
                                      completion: nil)
                    } else if let moreModel = model as? FirstPageModel {
                        //print("LOAD MORE PRODUCT",moreModel)
                        self?.handleLoadMore(model: moreModel)
                    }
                    self?.activityIndicator.stopAnimating()
                }
            })
        }else{
            self.isLoadingMoreProducts = false
            shouldShowLoadMoreIndicator(false)
        }
    }
}

