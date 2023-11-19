//
//  ProductCollectionViewCell.swift
//  ProductTask
//
//  Created by Eman Khaled on 19/11/2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configureCell(product : Product){
        
        priceLabel.text =  "\(product.price)"
        descriptionLabel.text = product.description
        if let imageURL = URL(string: product.image.url) {
            let session = URLSession.shared
            let task = session.dataTask(with: imageURL) { [weak self] (data, response, error) in
                if let error = error {
                    // Handle the error
                    print("Error loading image: \(error)")
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.productImageView.image = image
                    }
                }
            }
            task.resume()
        }
    }
    
}
