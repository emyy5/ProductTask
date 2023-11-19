//
//  DataBase.swift
//  ProductTask
//
//  Created by Eman Khaled on 19/11/2023.
//

import Foundation
import CoreData
import UIKit

protocol DataBaseProtocol{
    func saveProductsToDB(product : DataBaseModel)
    func getProductsCash() -> [DataBaseModel]
}
class DataBase  : DataBaseProtocol{
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var productObject:[NSManagedObject]!
    
    
    func saveProductsToDB(product: DataBaseModel){
        
        let context:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Model", in: context)!
        let proObj = NSManagedObject(entity: entity, insertInto: context)
        
       
      
            proObj.setValue(product.price, forKey: "price")
            proObj.setValue(product.desribtion, forKey: "descriptionn")
        let image = UIImage(named: "image")
        if let imageData = image?.pngData() {
            proObj.setValue(imageData, forKey: "image")
        } else {
            print("Failed to convert the image to data.")
        }
            do{
                try context.save()
                print("Successful insert")
            } catch let error as NSError{
                print(error.localizedDescription)
            }
        }
        
    
    func getProductsCash() -> [DataBaseModel] {

        let context:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        var favs : [DataBaseModel] = []
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Model")
        do{
            productObject = try context.fetch(fetchReq)
            for fav in productObject{
                let price = fav.value(forKey: "price") as? Double ?? 0.0
                let description = fav.value(forKey: "descriptionn") as? String ?? ""
                let image = fav.value(forKey: "image") as? String ?? ""
                
                favs.append(DataBaseModel(price: price, desribtion: description , image: image))
            }
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        return favs
    }
    
}



