//
//  Product.swift
//  ProductTask
//
//  Created by Eman Khaled on 19/11/2023.
//

import Foundation

struct records : Codable{
    var records : [Product]
}
struct Product: Codable {
    var id: Int
    var description: String
    var price: Double
    var image: image
}
    enum CodingKeys: String, CodingKey {
    case  image = "image"
    case  description = "description"
    case price = "price"
    case id = "id"
   }

struct image : Codable {
    var url : String
   
}
