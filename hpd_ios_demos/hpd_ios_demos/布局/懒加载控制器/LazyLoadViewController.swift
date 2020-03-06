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
    
    private lazy var scrollView = HCPLazyLoadScrollView().then {
        $0.lazyLoadScrollViewDelegate = self
    }
    
    private let controller1 = Page1ViewController()
    private let controller2 = Page2ViewController()
    private let controller3 = Page1ViewController()
    private let controller4 = Page2ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.setData(controllers: [controller1,controller2,controller3,controller4])
    }
}

extension LazyLoadViewController: HCPLazyLoadScrollViewDelegate {
    
    func indexChange(index: Int) {
        print("indexChange index=\(index)")
    }
}
