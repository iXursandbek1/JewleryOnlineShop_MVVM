//
//  InfoModel.swift
//  JewleryOnlineShop_MVVM
//
//  Created by Xursandbek Qambaraliyev on 27/02/23.
//

import UIKit

class InfoModule {
    static func create(jewelery: Items) -> UIViewController {
        
        let dataManager = FavoriteDataManager()
        
        let vm = InfoViewModel(manager: dataManager, info: jewelery)
        
        let vc = InfoViewController(vm: vm)
        
        return vc
    }
}
