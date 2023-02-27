//
//  FavoriteViewController.swift
//  JewleryOnlineShop_MVVM
//
//  Created by Xursandbek Qambaraliyev on 27/02/23.
//

import UIKit
import SnapKit
import CoreData

class FavoriteViewController: UIViewController {
    
    var favoriteViewModel = FavoriteViewModel()
    

    let tableView: UITableView = {
       let tableview = UITableView()
        tableview.rowHeight = 80
        tableview.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.reuseIdentifier)
        return tableview
    }()
    
    var viewModel = CategoryViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
       
        
        favoriteViewModel.reloadTableView = { [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationController?.navigationBar.topItem!.title = "Favorites"
        favoriteViewModel.fetchProducts()
        
    }
        
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteViewModel.getProductsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.reuseIdentifier, for: indexPath) as! FavoritesTableViewCell
        
        cell.updateUI(with: favoriteViewModel.getProduct(index: indexPath.item))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = InfoModule.create(jewelery:  favoriteViewModel.getProduct(index: indexPath.item))
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
