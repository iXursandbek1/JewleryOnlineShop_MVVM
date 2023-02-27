//
//  InfoViewModel.swift
//  JewleryOnlineShop_MVVM
//
//  Created by Xursandbek Qambaraliyev on 27/02/23.
//

import UIKit

class InfoViewModel {
    
    var isFav = true
    
    private var item: Items{
        didSet {
            self.updateUI!()
        }
    }
   
    var updateUI: (() -> ())?
    
    var dataManager: FavoriteDataManager

    init(manager: FavoriteDataManager, info: Items){
        self.dataManager = manager
        self.item = info
     }
    
    func getItems() -> Items? {
        
        return item
    }
    
    func isFavorite() -> Bool {
        
        isFav = dataManager.checkItemExist(id: item.id)
        return isFav
    }
    
    func manageFavorites() {
        if isFav{
            deleteFavorites()
        } else {
            saveToFavorites()
        }
    }
    
    //MARK: - Save

    func saveToFavorites() {
        dataManager.saveToItems(productes: item) { res in
            //Eror
            switch res{
            case .success(_): break
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    //MARK: - Delete
    
    func deleteFavorites() {
        
        dataManager.deleteRecords(product: item.id) { del in
            switch del{
                
            case .success(_): break
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
}
