//
//  BaseViewWithNavBarController.swift
//  hpd_ios_demos
//
//  Created by hpd on 2020/3/10.
//  Copyright © 2020 hpd. All rights reserved.
//

import UIKit

class BaseViewWithNavBarController: BaseViewController {
    
    let hcpNavigationBar = UIView().then{
        $0.backgroundColor = .white
    }
    
    let hcpNavigationBarTitle = UILabel().then {
        $0.textColor = .black
    }
    
    let backButton = UIButton().then {
        $0.setImage(UIImage(named: "filter_college_sel"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(hcpNavigationBar)
        hcpNavigationBar.addSubview(hcpNavigationBarTitle)
        hcpNavigationBar.addSubview(backButton)
        
        hcpNavigationBar.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(kNaviHeight)
        }
        
        hcpNavigationBarTitle.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(kStatusBarHeight/2)
            make.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview().offset(kStatusBarHeight/2)
        }
        
        backButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
}
