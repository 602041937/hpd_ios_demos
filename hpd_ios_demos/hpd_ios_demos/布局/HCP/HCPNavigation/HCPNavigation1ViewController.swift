//
//  HCPNavigation1ViewController.swift
//  hpd_ios_demos
//
//  Created by hpd on 2020/3/10.
//  Copyright © 2020 hpd. All rights reserved.
//

import UIKit

class HCPNavigation1ViewController: BaseViewWithNavBarController {
    
    private let titleLabel = UILabel().then {
        $0.text = "navigation1"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hcpNavigationBarTitle.text = "navigation1"
        
        view.backgroundColor = .green
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    override func isCanInteractivePopGesture() -> Bool {
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        navigationController?.pushViewController(HCPNavigation2ViewController(), animated: true)
    }
}


