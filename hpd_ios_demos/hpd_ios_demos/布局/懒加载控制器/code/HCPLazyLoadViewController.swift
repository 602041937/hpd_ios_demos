//
//  HCPLazyLoadViewController.swift
//  hpd_ios_demos
//
//  Created by huangpeidong on 2020/1/10.
//  Copyright © 2020 hpd. All rights reserved.
//

import UIKit
import SnapKit
import Then

class HCPLazyLoadViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }
    
    func lazyLoad() {
        print("HCPLazyLoadViewController lazyLoad")
    }
    
    func lazyDidAppear() {
        print("HCPLazyLoadViewController lazyDidAppear")
    }
    
    func lazyDidDisAppear() {
        print("HCPLazyLoadViewController lazyDidDisAppear")
    }
}
