//
//  HCPLazyLoadScrollView.swift
//  hpd_ios_demos
//
//  Created by huangpeidong on 2020/1/10.
//  Copyright © 2020 hpd. All rights reserved.
//

import UIKit

protocol HCPLazyLoadScrollViewDelegate{
    
    func indexChange(index: Int)
}

class HCPLazyLoadScrollView: UIScrollView {
    
    private var controllers: [HCPLazyLoadViewController] = []
    private var currentIndex = 0
    private var currentController: HCPLazyLoadViewController?
    private var hasSelectIndexs: [Int] = []
    
    private var isDealCurrentIndex = false
    
    var lazyLoadScrollViewDelegate: HCPLazyLoadScrollViewDelegate?
    
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
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
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
        
        if isDealCurrentIndex == false {
            isDealCurrentIndex = true
            setContentOffset(CGPoint(x: CGFloat(currentIndex) * bounds.width, y: 0), animated: true)
            currentController = controllers[currentIndex]
            hasSelectIndexs.append(currentIndex)
            currentController?.lazyLoad()
            currentController?.lazyDidAppear()
            lazyLoadScrollViewDelegate?.indexChange(index: currentIndex)
        }
        
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
    
    func setCurrentIndex(_ index: Int) {
        if index == currentIndex {
            return
        }
        setContentOffset(CGPoint(x: index * Int(bounds.width), y: 0), animated: false)
        currentController?.lazyDidDisAppear()
        currentIndex = index
        currentController = controllers[currentIndex]
        if hasSelectIndexs.contains(currentIndex) == false {
            hasSelectIndexs.append(currentIndex)
            currentController?.lazyLoad()
        }
        currentController?.lazyDidAppear()
        lazyLoadScrollViewDelegate?.indexChange(index: currentIndex)
    }
}

extension HCPLazyLoadScrollView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let tempCurrentIndex = Int(scrollView.contentOffset.x / bounds.width)
        if tempCurrentIndex == currentIndex {
            return
        }
        currentController?.lazyDidDisAppear()
        currentIndex = tempCurrentIndex
        currentController = controllers[currentIndex]
        if hasSelectIndexs.contains(currentIndex) == false {
            hasSelectIndexs.append(currentIndex)
            currentController?.lazyLoad()
        }
        currentController?.lazyDidAppear()
        lazyLoadScrollViewDelegate?.indexChange(index: currentIndex)
    }
}
