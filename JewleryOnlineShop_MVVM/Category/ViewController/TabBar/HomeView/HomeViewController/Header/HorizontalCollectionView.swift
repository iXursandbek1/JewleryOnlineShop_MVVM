//
//  HorizontalCollectionView.swift
//  JewleryOnlineShop_MVVM
//
//  Created by Xursandbek Qambaraliyev on 09/02/23.
//

import UIKit
import SnapKit

protocol getCategoryNameProtocol {
    func getCategoryName(_ categoryName: Int)
}

class HorizontalCollectionView: BaseCollectionViewCell <CategoriesModel> {
    
    let typeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initView() {
        
        self.addSubview(typeLabel)
        self.clipsToBounds = true
        typeLabel.font = .boldSystemFont(ofSize: 24)
        typeLabel.text = "type"
        typeLabel.textAlignment = .center
        typeLabel.textColor = .black
        typeLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func updateUI(with model: CategoriesModel) {
        typeLabel.text = model.categoryName
    }
    
    func setBackground(isSelected: Bool){
        if isSelected {
            typeLabel.textColor = .red
            
        } else {
            typeLabel.textColor = .black
         }
    }
}
