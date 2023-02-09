//
//  ViewController.swift
//  JewleryOnlineShop_MVVM
//
//  Created by Xursandbek Qambaraliyev on 09/02/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc = MainTabBarController()
        navigationController?.pushViewController(vc, animated: true)
    }


}

