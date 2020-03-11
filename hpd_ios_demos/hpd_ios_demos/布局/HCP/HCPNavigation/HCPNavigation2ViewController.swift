//
//  HCPNavigation2ViewController.swift
//  hpd_ios_demos
//
//  Created by hpd on 2020/3/10.
//  Copyright © 2020 hpd. All rights reserved.
//

import UIKit

class HCPNavigation2ViewController: BaseViewWithNavBarController {
    
    private let titleLabel = UILabel().then {
        $0.text = "navigation2"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hcpNavigationBarTitle.text = "navigation2"
        
        view.backgroundColor = .orange
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
