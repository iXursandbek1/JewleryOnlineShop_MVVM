//
//  ViewModel.swift
//  JewleryOnlineShop_MVVM
//
//  Created by Xursandbek Qambaraliyev on 09/02/23.
//

import Foundation
import UIKit

class CategoryViewModel {
    
    var reloadCollectionView: (()->())?
    
    var index: Int = 0 {
        didSet {
            self.reloadCollectionView?()
        }
    }
    
    private var categories: [CategoriesModel] = [] {
        didSet {
            self.reloadCollectionView?()
        }
    }
    
    private var items: [Items] = [] {
        didSet {
            self.reloadCollectionView?()
        }
    }
    
    init() {
        getCategories()
        getItems()
    }
    
    func getCategoryName(index: Int) -> CategoriesModel {
        let categoryName = categories[index]
        return categoryName
    }
    
    func getItems(item: Int) -> Items {
        
        if categories.count < index {
            return Items(description: "" , id: 0, image: "", name: "", price: "")
        }
        
        let description = categories[index].items[item].description
        let id = categories[index].items[item].id
        let image = categories[index].items[item].image
        let name = categories[index].items[item].name
        let price = categories[index].items[item].price
        
        
        let  product = Items(description: description, id: id, image: image, name: name, price: price)
        
        return product
    }
    
    
    func getCategotyCount() -> Int {
        return categories.count
    }
    func getCategoryItems() -> Items {
        return items[index]
    }
    
    func getItemsCount() -> Int {
        return items.count
    }
    
    func getCategories() {
        CategoriesRepository.shared.getCategories { res in
            self.categories = res
        }
    }
    func getItems() {
        CategoriesRepository.shared.getCategories { res in
            self.items = res[self.index].items
        }
    }
}
