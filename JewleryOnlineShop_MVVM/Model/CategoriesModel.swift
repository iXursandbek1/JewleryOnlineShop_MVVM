//
//  CategoriesModel.swift
//  JewleryOnlineShop_MVVM
//
//  Created by Xursandbek Qambaraliyev on 09/02/23.
//

import Foundation

struct CategoriesModel: Codable {
    let categoryName: String
    let items: [Items]
}

struct Items: Codable {
    let description: String
    let id: Int
    let image: String
    let name: String
    let price: String
}
