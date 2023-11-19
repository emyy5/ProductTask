//
//  ViewController.swift
//  ProductTask
//
//  Created by Eman Khaled on 19/11/2023.
//

import UIKit
import Alamofire
import Reachability
import CoreData
class ProductsView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var viewModel = ProductsScreenViewModel(repo: Repo(networkManager: NetworkManager(), databaseManager: DataBase()))
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    var reachbility : Reachability?
    var isConnectedToInternet : Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Product List"
        setUpView()
       
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
       
        viewModel.getProductsFromNetwork(collectionView: collectionView)
        collectionView.reloadData()
        do {
            reachbility = try Reachability()
            try reachbility?.startNotifier()
        } catch let error{
            print(error)
        }
        
        self.checkConnection()
        
    }
    
    func setUpView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ProductCell")
      
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(isConnectedToInternet == true){
       
            return viewModel.products.count
        }
        else if(isConnectedToInternet == false){
            return viewModel.cashProducts.count
        }
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        if(isConnectedToInternet == true){
            let product = viewModel.products[indexPath.row]
            cell.configureCell(product: product)
        }
        else if (isConnectedToInternet == false){

            let product = self.viewModel.cashProducts[indexPath.row]
            cell.descriptionLabel.text = product.desribtion
            cell.priceLabel.text = "\(product.price)"
        }
       
        
       
        return cell
    }
     

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        print("selected")
        let selectedProduct = viewModel.products[indexPath.row]
        showProductDetails(product: selectedProduct)
    }

    func showProductDetails(product: Product) {
        if let productDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController {
            productDetailsVC.product = product
            navigationController?.pushViewController(productDetailsVC, animated: true)
        }
    }
}

extension ProductsView: UICollectionViewDelegateFlowLayout  {
    
    // MARK: -  COLLECTIONVIEW FUNCTIONS
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.07 , height: collectionView.frame.height / 4)
        
    }
    
    
}

extension ProductsView {
    
    fileprivate func checkConnection()  {
         NotificationCenter.default.addObserver(forName: .reachabilityChanged, object: reachbility, queue: .main) { (notification) in
             if let myReachbility = notification.object as? Reachability {
                 switch myReachbility.connection {
                     
                 case .cellular:
                     print("connected to cellular data")
  
                     
                 case .wifi:
                     print("connected to wifi")
                     self.isConnectedToInternet = true
                     self.viewModel.getProductsFromNetwork(collectionView: self.collectionView)
       
                     self.collectionView.reloadData()
                 case .unavailable:
                     print("no connnection")
                 
                     print("no connection")
                         self.isConnectedToInternet = false
                     self.viewModel.getCashed(collectionView: self.collectionView, viewController: self)
                 }
                 }
                }
            }
        }
