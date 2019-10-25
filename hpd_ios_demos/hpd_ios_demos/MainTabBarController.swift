//
//  MainTabBarController.swift
//  hpd_ios_demos
//
//  Created by huangpeidong on 2019/9/12.
//  Copyright © 2019 hpd. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    static func newInstance() -> MainTabBarController {
        return MainTabBarController(nibName: "MainTabBarController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        tabBar.backgroundColor = .white

        let nav = UINavigationController(rootViewController: HCPHomeViewController.newInstance())
        viewControllers = [nav]
    }
}
