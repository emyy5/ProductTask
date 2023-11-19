//
//  ProductsScreenViewModel.swift
//  ProductTask
//
//  Created by Eman Khaled  on 19/11/2023.
//

import Foundation
import UIKit
class ProductsScreenViewModel{
    
    
    var products : [Product] = []
    var cashProducts : [DataBaseModel] = []
    var repo : RepoProtocol
    
    init(repo: RepoProtocol) {
        self.repo = repo
    }
    func getProductsFromNetwork(collectionView : UICollectionView){
        repo.getProductsFromNetwork { res in
            
            guard let products = res?.records else{return}
            self.products = products
            print(self.products.count)
            collectionView.reloadData()
            if(self.repo.getCash().count == 0){
                for product in products {
                    self.repo.saveCash(product: DataBaseModel(price: product.price, desribtion: product.description))
                    
                }
            }
        }
        
    }
    func getCashed(collectionView : UICollectionView , viewController : UIViewController){
        if(repo.getCash().count == 0){
            let alert = UIAlertController(title: "No Internet Connection ", message: "Please Connect to Internet to get data.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           viewController.present(alert, animated: true)
            collectionView.isHidden = true
        }else{
            
            
            self.cashProducts = repo.getCash()
            collectionView.reloadData()
        }
    }
    
}

