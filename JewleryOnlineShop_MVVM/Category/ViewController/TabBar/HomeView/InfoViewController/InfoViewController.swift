//
//  InfoViewController.swift
//  JewleryOnlineShop_MVVM
//
//  Created by Xursandbek Qambaraliyev on 27/02/23.
//

import UIKit
import SnapKit
import CoreData
import Kingfisher


class InfoViewController: BaseViewController {
    
    var product: [NSManagedObject] = []
    
    let infoViewModel: InfoViewModel
    
    // init, deinit , ARC

    init(vm: InfoViewModel) {
        infoViewModel = vm
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let productImage: UIImageView = {
       let image = UIImageView()
        return image
    }()
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let descriptionLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let likedButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    let buyButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitle("Buy", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        view.backgroundColor = .systemBackground
        
    }
    
    func initView(){
        view.addSubview(productImage)
        productImage.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY).multipliedBy(0.25)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.6)
            make.height.equalTo(view.snp.height).multipliedBy(0.28)
        }
            
        view.addSubview(productNameLabel)
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(likedButton)
        likedButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        likedButton.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(20)
            make.left.equalTo(productNameLabel.snp.right).offset(35)

        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalTo(view.snp.right).offset(10)
            make.top.equalTo(productNameLabel.snp.bottom).offset(20)
        }
        
        view.addSubview(buyButton)
        buyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).offset(45)
            make.width.equalTo(view.snp.width).multipliedBy(0.6)
            make.height.equalTo(view.snp.height).multipliedBy(0.08)
        }
        updateUI()
     }
    
    func updateUI() {
        guard let data = infoViewModel.getItems() else {return}
        let url = URL(string: data.image)
        productImage.kf.setImage(with: url)
        productNameLabel.text = data.name
        descriptionLabel.text = data.description
    
        if infoViewModel.isFavorite() {
            likedButton.setImage(UIImage(named: "likeFill"), for: .normal)
        }else{
            likedButton.setImage(UIImage(named: "like"), for: .normal)
        }
     }

    
    @objc func likeButtonTapped(){
        infoViewModel.manageFavorites()

        if infoViewModel.isFavorite() {
            likedButton.setImage(UIImage(named: "likeFill"), for: .normal)
        } else {
            likedButton.setImage(UIImage(named: "like"), for: .normal)
        }
    
    }
    
   
}
