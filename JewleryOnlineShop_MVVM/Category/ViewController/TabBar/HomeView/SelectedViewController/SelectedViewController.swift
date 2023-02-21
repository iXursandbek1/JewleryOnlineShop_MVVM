//
//  SelectedViewController.swift
//  JewleryOnlineShop_MVVM
//
//  Created by Xursandbek Qambaraliyev on 09/02/23.
//

import UIKit
import SnapKit
import CoreData
import Kingfisher

class SelectedViewController: UIViewController {
    
    var product: [NSManagedObject] = []
    
    
    let productImage = UIImageView()
    let productName = UILabel()
    let productPrice = UILabel()
    let productDes = UILabel()
    let likeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        view.backgroundColor = .white
    }
    
    
    func initView() {
        
        view.addSubview(productName)
        productName.textAlignment = .center
        productName.font = .boldSystemFont(ofSize: 25)
        productName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
            make.top.equalTo(view.snp.top).offset(50)
        }
        
        view.addSubview(productImage)
        productImage.contentMode = .scaleAspectFit
        productImage.layer.cornerRadius = 15
        productImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(productName.snp.bottom).offset(30)
            make.height.equalTo(view.snp.height).multipliedBy(0.4)
            make.width.equalTo(productName.snp.width)
        }
        
        view.addSubview(productPrice)
        productPrice.textAlignment = .center
        productPrice.font = .boldSystemFont(ofSize: 20)
        productPrice.textColor = .systemGreen
        productPrice.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(productImage.snp.width)
            make.top.equalTo(productImage.snp.bottom).offset(20)
        }
        
        view.addSubview(productDes)
        productDes.textAlignment = .center
        productDes.font = .systemFont(ofSize: 20)
        productDes.textColor = .black
        productDes.numberOfLines = .max
        productDes.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(productImage.snp.width)
            make.top.equalTo(productPrice.snp.bottom).offset(20)
        }
        
        view.addSubview(likeButton)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(productDes.snp.bottom)
            make.right.equalTo(view.snp.right).offset(-30)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
    }
    
    func updateUI(with model: Items) {
        
        let url = URL(string: model.image)
        productImage.kf.setImage(with: url)
        productName.text = model.name
        productPrice.text = model.price
        productDes.text = model.description
    }
    
    func saveItem(item: String, key: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: managedContext)!
        
        // 3
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        person.setValue(item, forKeyPath: key)
        
        let price = NSManagedObject(entity: entity, insertInto: managedContext)
        
        price.setValue(item, forKeyPath: key)
        
        do{
            try managedContext.save()
            product.append(person)
            product.append(price)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    @objc func likeButtonTapped(){
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        
        guard let text = productName.text else { return }
        guard let price = productPrice.text else { return }
        saveItem(item: text, key: "product")
        saveItem(item: price, key: "price")
        
    }
}
