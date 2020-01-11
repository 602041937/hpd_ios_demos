//
//  LazyLoadViewController.swift
//  hpd_ios_demos
//
//  Created by huangpeidong on 2020/1/10.
//  Copyright © 2020 hpd. All rights reserved.
//

import UIKit
import Then
import SnapKit

class LazyLoadViewController: UIViewController {
    
    private let scrollView = HCPLazyLoadScrollView()
    
    private let controller1 = HCPLazyLoadViewController()
    private let controller2 = HCPLazyLoadViewController()
    private let controller3 = HCPLazyLoadViewController()
    private let controller4 = HCPLazyLoadViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.setData(controllers: [controller1,controller2,controller3,controller4],currentIndex: 1)
                
    
    }
}

