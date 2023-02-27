//
//  HomeViewController.swift
//  JewleryOnlineShop_MVVM
//
//  Created by Xursandbek Qambaraliyev on 09/02/23.
//

import UIKit
import SnapKit
import Kingfisher
import Alamofire

class HomeViewController: BaseViewController, getCategoryNameProtocol {
    
    let viewModel = CategoryViewModel()
    
    weak var verticalCollectiomView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        view.backgroundColor = .white
    }
    
    private func initView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        
        let verticalCollectiomView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(verticalCollectiomView)
        
        verticalCollectiomView.translatesAutoresizingMaskIntoConstraints = false
        verticalCollectiomView.dataSource = self
        verticalCollectiomView.delegate = self
        verticalCollectiomView.register(VerticalCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        verticalCollectiomView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        verticalCollectiomView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.top.equalTo(view.snp.top).offset(50)
            make.bottom.equalTo(view.snp.bottom)
            make.width.equalTo(view.snp.width)
        }
        
        self.verticalCollectiomView = verticalCollectiomView
        viewModel.reloadCollectionView = { [unowned self] in
            self.isLoading = false
            self.verticalCollectiomView?.reloadData()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.getItemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VerticalCollectionViewCell
        
        cell.updateUI(with: viewModel.getItems(item: indexPath.item))
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 2
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width / 2.5, height: view.frame.height / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 20, left: 30, bottom: 0, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! Header
        
        header.delegate = self
        header.backgroundColor = .white
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height / 2.3)
    }
    
    func getCategoryName(_ categoryName: Int) {
        viewModel.index = categoryName
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = InfoModule.create(jewelery: viewModel.getItems(item: indexPath.item))
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
