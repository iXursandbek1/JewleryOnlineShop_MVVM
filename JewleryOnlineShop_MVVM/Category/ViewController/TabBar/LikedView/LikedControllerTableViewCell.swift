//
//  LikedControllerTableViewCell.swift
//  JewleryOnlineShop_MVVM
//
//  Created by Xursandbek Qambaraliyev on 18/02/23.
//

import UIKit
import SnapKit
class LikedControllerTableViewCell: UITableViewCell {

    let productImage = UIImageView()
    let productName = UILabel()
    let productPrice = UILabel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        initView()
     }
    func initView() {
        
        self.addSubview(productImage)
        productImage.contentMode = .scaleAspectFit
        productImage.layer.cornerRadius = 15
        productImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.snp.left).offset(30)
            make.height.equalTo(self.snp.height).multipliedBy(0.8)
            make.width.equalTo(self.snp.width).multipliedBy(0.4)
        }
        
        self.addSubview(productName)
        productName.textAlignment = .left
        productName.font = .boldSystemFont(ofSize: 17)
        productName.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.top)
            make.left.equalTo(productImage.snp.right).offset(30)
            make.right.equalTo(self.snp.right).offset(-20)
        }
        
        self.addSubview(productPrice)
        productPrice.textAlignment = .left
        productPrice.font = .boldSystemFont(ofSize: 17)
        productPrice.textColor = .systemGreen
        productPrice.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(productImage.snp.right).offset(30)
            make.right.equalTo(self.snp.right).offset(-20)
        }
        
    }
    func updateUI(with model: Items) {
        productName.text = "\(model.name)"
        productPrice.text = "\(model.price)"
    }
}
