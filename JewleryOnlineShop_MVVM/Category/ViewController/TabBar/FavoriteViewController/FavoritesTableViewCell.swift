//
//  FavoritesTableViewCell.swift
//  JewleryOnlineShop_MVVM
//
//  Created by Xursandbek Qambaraliyev on 27/02/23.
//

import UIKit
import SnapKit

class FavoritesTableViewCell: BaseTableCell<Items> {

    let itemName  = UILabel()
    let itemImage = UIImageView()
    let itemPrice = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        initView()
        
     }
    override func initView() {
        
        self.addSubview(itemImage)
        itemImage.contentMode = .scaleAspectFit
        itemImage.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).inset(20)
            make.centerY.equalTo(self.snp.centerY)
            make.height.width.equalTo(100)
        }
        self.addSubview(itemName)
        itemName.textColor = .black
        itemName.font = .boldSystemFont(ofSize: 24)
        itemName.textAlignment = .left
        itemName.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).inset(20)
            make.left.equalTo(itemImage.snp.right).inset(-30)
            make.top.equalTo(self.snp.top).offset(10)

        }
        
        self.addSubview(itemPrice)
        itemPrice.textColor = .systemGreen
        itemPrice.textAlignment = .left
        itemPrice.snp.makeConstraints { make in
            make.top.equalTo(itemName.snp.bottom).offset(10)
            make.left.equalTo(itemName.snp.left)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
        }
        
        
        
    }
    override func updateUI(with model: Items) {
        itemName.text = "\(model.name)"
        itemImage.kf.setImage(with: URL(string: model.image))
        itemPrice.text = model.price

        
    }

}
