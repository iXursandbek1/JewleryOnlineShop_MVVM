//
//  CategoriesRepository.swift
//  JewleryOnlineShop_MVVM
//
//  Created by Xursandbek Qambaraliyev on 09/02/23.
//

import Foundation
import Alamofire

class CategoriesRepository {
    static let shared = CategoriesRepository()
   
    func getCategories(compilationHandler: @escaping(([CategoriesModel]) -> Void)) {
       
        
        let url = AppUrl()
        AF.request(url.baseUrl).responseDecodable(of: [CategoriesModel].self) { res in
            guard let data = res.value else { return }
            compilationHandler(data)
        }
    }
}
