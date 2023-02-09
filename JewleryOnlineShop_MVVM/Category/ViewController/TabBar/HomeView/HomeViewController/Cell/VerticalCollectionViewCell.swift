//
//  VerticalCollectionViewCell.swift
//  JewleryOnlineShop_MVVM
//
//  Created by Xursandbek Qambaraliyev on 09/02/23.
//

import UIKit
import SnapKit

class VerticalCollectionViewCell: BaseCollectionViewCell<Items> {
    
    
    let productImage = UIImageView()
    let productName = UILabel()
    let productPrice = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initView() {
        
        self.addSubview(productImage)
        productImage.contentMode = .scaleAspectFit
        productImage.layer.cornerRadius = 15
        productImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.top).offset(10)
            make.height.equalTo(self.snp.height).multipliedBy(0.67)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
        }
        
        self.addSubview(productName)
        productName.textAlignment = .center
        productName.font = .boldSystemFont(ofSize: 17)
        productName.text = "ProductName"
        productName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(productImage.snp.width)
            make.top.equalTo(productImage.snp.bottom).offset(5)
        }
        
        self.addSubview(productPrice)
        productPrice.textAlignment = .left
        productPrice.font = .boldSystemFont(ofSize: 17)
        productPrice.textColor = .systemGreen
        productPrice.text = "Price"
        productPrice.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(productImage.snp.width)
            make.top.equalTo(productName.snp.bottom).offset(5)
        }
        
    }
    
    override func updateUI(with model: Items) {
        
        let url = URL(string: model.image)
        productImage.kf.setImage(with: url)
        productName.text = model.name
        productPrice.text = model.price
    }
}
