//
//  MainTabBarController.swift
//  JewleryOnlineShop_MVVM
//
//  Created by Xursandbek Qambaraliyev on 09/02/23.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initTabBar()
    }
    //MARK: - Tab Bar Controller
        func initTabBar(){
            
            let home = HomeViewController()
            home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
            
            let liked = LikedViewController()
            liked.tabBarItem = UITabBarItem(title: "Liked", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
            
            let settings = SettingsViewController()
            settings.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"))
            
            
            tabBar.tintColor = .black
            tabBar.backgroundColor = .white
            tabBar.isTranslucent = false
            viewControllers = [home, liked, settings]
            
        }
}
