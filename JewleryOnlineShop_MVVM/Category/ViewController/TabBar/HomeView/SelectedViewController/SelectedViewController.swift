//
//  SelectedViewController.swift
//  JewleryOnlineShop_MVVM
//
//  Created by Xursandbek Qambaraliyev on 09/02/23.
//

import UIKit
import SnapKit

class SelectedViewController: UIViewController {
    
    let productImage = UIImageView()
    let productName = UILabel()
    let productPrice = UILabel()
    let productDes = UILabel()

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
    }
    
    func updateUI(with model: Items) {
        
        let url = URL(string: model.image)
        productImage.kf.setImage(with: url)
        productName.text = model.name
        productPrice.text = model.price
        productDes.text = model.description
    }
}
