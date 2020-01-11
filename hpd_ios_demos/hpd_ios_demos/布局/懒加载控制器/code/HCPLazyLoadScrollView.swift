//
//  HCPLazyLoadScrollView.swift
//  hpd_ios_demos
//
//  Created by huangpeidong on 2020/1/10.
//  Copyright © 2020 hpd. All rights reserved.
//

import UIKit

class HCPLazyLoadScrollView: UIScrollView {
    
    private var controllers: [HCPLazyLoadViewController] = []
    private var currentIndex = 0
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        isPagingEnabled = true
        isScrollEnabled = true
        bounces = false
        delegate = self
    }
    
    func setData(controllers: [HCPLazyLoadViewController],currentIndex: Int = 0) {
        self.controllers = controllers
        self.currentIndex = currentIndex
        if let vc = viewController() {
            for vcItem in controllers {
                vc.addChild(vcItem)
                addSubview(vcItem.view)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for (i,vcItem) in controllers.enumerated() {
            vcItem.view.frame = CGRect(x: CGFloat(i) * bounds.width, y: 0, width: bounds.width, height: bounds.height)
        }
        
        contentSize = CGSize(width: CGFloat(controllers.count) * bounds.width, height: bounds.height)
    }
    
    //当前view所在的controller
    func viewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self){
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
}

extension HCPLazyLoadScrollView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("HCPLazyLoadScrollView scrollView.subviews.count=\(scrollView.subviews.count)")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("HCPLazyLoadScrollView scrollView.contentOffset.x=\(scrollView.contentOffset.x)")
        
    }
}
