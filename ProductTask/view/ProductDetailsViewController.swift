//
//  ProductDetailsViewController.swift
//  ProductTask
//
//  Created by Eman Khaled on 19/11/2023.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    var product: Product?

      override func viewDidLoad() {
          super.viewDidLoad()
          if let product = product {
              descriptionLabel.text = product.description
              priceLabel.text = "Price: $\(product.price)"
             
              // Load image asynchronously
              DispatchQueue.global().async {
                  if let imageURL = URL(string: product.image.url ), let imageData = try? Data(contentsOf: imageURL) {
                      DispatchQueue.main.async {
                          self.productImageView.image = UIImage(data: imageData)
                      }
                  }
              }
          }
      }
  }
