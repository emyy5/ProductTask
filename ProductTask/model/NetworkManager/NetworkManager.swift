//
//  NetworkManager.swift
//  ProductTask
//
//  Created by Eman Khaled  on 19/11/2023.
//

import Foundation
import Alamofire
protocol NetworkManagerprotocol {
    func getProductsFromNetwork(completion: @escaping (records?)->())
}

class NetworkManager : NetworkManagerprotocol{
    func getProductsFromNetwork(completion: @escaping (records?)->()) {
        guard let url = URL(string: "https://api.npoint.io/4179798d2892159fc81d") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        AF.request(request)
            .responseDecodable(of: records.self) { (response) in
                switch response.result {
                case .success(let jsonData):
                    completion(jsonData)
                    
                    
                    //                    self.products = jsonData.records
                    //                    print(jsonData.records[0].image.url)
                    //                    self.collectionView.reloadData()
                    
                    
                    //                    if(self.cashData.getFavs().count == 0){
                    //                        for product in jsonData.records {
                    //                            self.cashData.saveProductsToDB(product: DataBaseModel(price: product.price, desribtion: product.description))
                    //                        }
                    //                    }
                case .failure(let error):
                    completion(nil)
                    print("error here \n \n \(String(describing: error)) \n\n ")
                    
                    
                }
                
            }
        
        
    }
    
}
