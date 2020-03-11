//
//  Page1ViewController.swift
//  hpd_ios_demos
//
//  Created by hpd on 2020/1/19.
//  Copyright © 2020 hpd. All rights reserved.
//

import UIKit

class Page1ViewController: HCPLazyLoadViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        navigationController?.pushViewController(HCPNavigation1ViewController(), animated: true)
    }
}
