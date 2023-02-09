//
//  Header.swift
//  JewleryOnlineShop_MVVM
//
//  Created by Xursandbek Qambaraliyev on 09/02/23.
//

import UIKit
import SnapKit

class Header: UICollectionReusableView {
    
    static let identifier = "headerCat"
    let font: UIFont = .systemFont(ofSize: 25)
    let bText = UILabel()
    let searchTF = UISearchBar()
        
    var currentSelected: Int = 0
    weak var horizontalCollectionView: UICollectionView?
    let viewModel = CategoryViewModel()
    var delegate: getCategoryNameProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        
        self.addSubview(bText)
        bText.text = "Best jewellery \nfor you"
        bText.textAlignment = .left
        bText.numberOfLines = 0
        bText.textColor = UIColor(named: "darkBeige")
        bText.font = .systemFont(ofSize: 50, weight: .bold)
        bText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        self.addSubview(searchTF)
        searchTF.placeholder = "Search"
        searchTF.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.top.equalTo(bText.snp.bottom).offset(10)
            make.height.equalTo(self.snp.height).multipliedBy(0.1)
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 20
        layout.scrollDirection = .horizontal
        
        let horizontalCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.addSubview(horizontalCollectionView)
        horizontalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.register(HorizontalCollectionView.self, forCellWithReuseIdentifier: "cell")
        horizontalCollectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(searchTF.snp.bottom).offset(20)
            make.width.equalTo(self.snp.width)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        self.horizontalCollectionView = horizontalCollectionView
        viewModel.reloadCollectionView = { [unowned self] () in
            DispatchQueue.main.async {
                self.horizontalCollectionView?.reloadData()
            }
        }

    }
}

extension Header: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.getCategotyCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HorizontalCollectionView
        
        cell.updateUI(with: viewModel.getCategoryName(index: indexPath.item))
        cell.setBackground(isSelected: currentSelected == indexPath.item)
        
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 2
        cell.backgroundColor = .white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let text: String = viewModel.getCategoryName(index: indexPath.item).categoryName
        let width = text.widthOfString(usingFont: font) + 40
        
        return CGSize(width: width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        currentSelected = indexPath.item
        delegate?.getCategoryName(indexPath.item)
        self.horizontalCollectionView?.reloadData()
    }
}
