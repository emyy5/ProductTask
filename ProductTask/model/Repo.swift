//
//  Repo.swift
//  ProductTask
//
//  Created by Eman Khaled  on 19/11/2023.
//

import Foundation

protocol RepoProtocol{
    func getProductsFromNetwork(completion: @escaping (records?)->())
    func saveCash(product : DataBaseModel)
    func getCash()-> [DataBaseModel]
}

class Repo : RepoProtocol{
    var networkManager : NetworkManagerprotocol
    var databaseManager : DataBaseProtocol
    
    init(networkManager: NetworkManagerprotocol ,databaseManager : DataBaseProtocol ) {
        self.networkManager = networkManager
        self.databaseManager = databaseManager
    }
    func getProductsFromNetwork(completion: @escaping (records?) -> ()) {
        networkManager.getProductsFromNetwork { res in
            guard let result = res else{return}
            completion(result)
        }
    }
   
    func saveCash(product: DataBaseModel) {
        databaseManager.saveProductsToDB(product: product)
    }
    
    func getCash() -> [DataBaseModel] {
       
        return databaseManager.getProductsCash()
    }
    
    
    
}
