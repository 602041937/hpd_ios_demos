//
//  HCPTabBarController.swift
//  hpd_ios_demos
//
//  Created by hpd on 2020/3/7.
//  Copyright © 2020 hpd. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxGesture

class HCPTabBarController: BaseViewController {
    
    private lazy var scrollView = HCPLazyLoadScrollView().then {
        $0.lazyLoadScrollViewDelegate = self
        $0.isScrollEnabled = false
    }
    
    private let controller1 = Page1ViewController()
    private let controller2 = Page2ViewController()
    private let controller3 = Page1ViewController()
    private let controller4 = Page2ViewController()
    
    private let tabbarContentView = UIView().then {
        $0.backgroundColor = .green
    }
    
    private let tab1View = HCPTabBarItemView().then{
        $0.title.text = "tab1"
        $0.backgroundColor = .gray
        $0.selectedImageView.image = UIImage(named: "filter_college_sel")
    }
    
    private let tab2View = HCPTabBarItemView().then{
        $0.title.text = "tab2"
        $0.backgroundColor = .gray
        $0.selectedImageView.image = UIImage(named: "filter_college_sel")
    }
    
    private let tab3View = HCPTabBarItemView().then{
        $0.title.text = "tab3"
        $0.backgroundColor = .gray
        $0.selectedImageView.image = UIImage(named: "filter_college_sel")
    }
    
    private let tab4View = HCPTabBarItemView().then{
        $0.title.text = "tab4"
        $0.backgroundColor = .gray
        $0.selectedImageView.image = UIImage(named: "filter_college_sel")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        view.addSubview(tabbarContentView)
        
        tabbarContentView.addSubview(tab1View)
        tabbarContentView.addSubview(tab2View)
        tabbarContentView.addSubview(tab3View)
        tabbarContentView.addSubview(tab4View)
        
        tabbarContentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(-kSafeAreaBottom)
            make.height.equalTo(49)
        }
        
        tab1View.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        tab2View.snp.makeConstraints { (make) in
            make.left.equalTo(tab1View.snp.right)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(tab1View)
        }
        
        tab3View.snp.makeConstraints { (make) in
            make.left.equalTo(tab2View.snp.right)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(tab2View)
        }
        
        tab4View.snp.makeConstraints { (make) in
            make.left.equalTo(tab3View.snp.right)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(tab3View)
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.bottom.equalTo(tabbarContentView.snp.top)
        }
        
        tab1View.rx.tapGesture().when(.ended).subscribe(onNext:{ [weak self] (value) in
            self?.scrollView.setCurrentIndex(0)
        }).disposed(by: disposeBag)
        
        tab2View.rx.tapGesture().when(.ended).subscribe(onNext:{ [weak self] (value) in
            self?.scrollView.setCurrentIndex(1)
        }).disposed(by: disposeBag)
        
        tab3View.rx.tapGesture().when(.ended).subscribe(onNext:{ [weak self] (value) in
            self?.scrollView.setCurrentIndex(2)
        }).disposed(by: disposeBag)
        
        tab4View.rx.tapGesture().when(.ended).subscribe(onNext:{ [weak self] (value) in
            self?.scrollView.setCurrentIndex(3)
        }).disposed(by: disposeBag)
        
        scrollView.setData(controllers: [controller1,controller2,controller3,controller4])
    }
    
    override func isCanInteractivePopGesture() -> Bool {
        return false
    }
}

extension HCPTabBarController: HCPLazyLoadScrollViewDelegate {
    
    func indexChange(index: Int) {
        print("indexChange index=\(index)")
        tab1View.isSelected(index % 4 == 0 ? true : false)
        tab2View.isSelected(index % 4 == 1 ? true : false)
        tab3View.isSelected(index % 4 == 2 ? true : false)
        tab4View.isSelected(index % 4 == 3 ? true : false)
    }
}


