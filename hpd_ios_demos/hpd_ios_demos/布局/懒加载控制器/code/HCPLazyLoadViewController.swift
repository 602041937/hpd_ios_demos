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
    
    private let backView = UIView().then {
        $0.backgroundColor = .red
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        
        view.addSubview(backView)
        
        backView.snp.makeConstraints { (make) in
            make.top.left.equalTo(30)
            make.bottom.right.equalTo(-30)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("HCPLazyLoadViewController viewWillDisappear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("HCPLazyLoadViewController viewWillAppear")
    }
}
