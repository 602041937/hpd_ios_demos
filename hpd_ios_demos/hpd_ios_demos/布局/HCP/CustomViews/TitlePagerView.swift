//
//  TitlePagerView.swift
//  hpd_ios_demos
//
//  Created by huangpeidong on 2020/3/27.
//  Copyright © 2020 hpd. All rights reserved.
//

import UIKit
import RxGesture
import RxSwift

class TiltePagerItem: NSObject {
    
    var type: TiltePagerItemType?
    var value: String?
}

enum TiltePagerItemType {
    case text
    case image
}

protocol TitlePagerViewDelegate {
    
    func indexChange(index: Int)
}

class TitlePagerView: UIView {
    
    var delegate:TitlePagerViewDelegate?
    
    private let containerView = UIView()
    
    private let disposeBag = DisposeBag()
    
    private var isFirstLayoutSubviews = true
    
    private let scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    
    private let indicateView = UIImageView().then {
        $0.backgroundColor = .white
        $0.isHidden = true
    }
    
    private var dataItems: [TiltePagerItem] = []
    private var dataViews: [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var curretnX: CGFloat = 0
        for (i,itemView) in dataViews.enumerated() {
            var itemViewWidth: CGFloat = 0
            if dataItems[i].type! == .text {
                itemView.sizeToFit()
                itemViewWidth = itemView.bounds.width + 20 * 2
            }else {
                itemViewWidth = 100
            }
            itemView.sizeToFit()
            itemView.frame = CGRect(x: curretnX, y: 0, width: itemViewWidth, height: bounds.height)
            curretnX = itemView.frame.maxX
        }
        scrollView.contentSize = CGSize(width: curretnX, height: bounds.height)
        if isFirstLayoutSubviews == true {
            if dataItems.count > 0 {
                indexChange(index: 0,animate: false)
            }
        }
        isFirstLayoutSubviews = false
    }
    
    private func setUpView() {
     
        backgroundColor = .black
        
        addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(indicateView)
    }
    
    func setData(tiltePagerItem: [TiltePagerItem]) {
        
    }
    
    func setData(texts: [String]) {
        
        if texts.count > 0 {
            indicateView.isHidden = false
        }else {
            indicateView.isHidden = true
        }
        
        var tempTiltePagerItem = [TiltePagerItem]()
        var tempViews = [UIView]()
        for (i,item) in texts.enumerated() {
            let tiltePagerItem = TiltePagerItem()
            tiltePagerItem.type = .text
            tiltePagerItem.value = item
            tempTiltePagerItem.append(tiltePagerItem)
            
            let tempLabel = UILabel()
            tempLabel.textColor = .white
            tempLabel.textAlignment = .center
            tempLabel.text = item
            tempViews.append(tempLabel)
            scrollView.addSubview(tempLabel)
            tempLabel.rx.tapGesture().when(.ended).subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.indexChange(index: i)
            }).disposed(by: disposeBag)
        }
        dataItems = tempTiltePagerItem
        dataViews = tempViews
    }
    
    private func indexChange(index: Int,animate: Bool = true) {
        print("TiltePagerItem index=\(index)")
        let itemView = dataViews[index]
    
        //让选中的item可以自动居中
        var offsetX = itemView.frame.midX - bounds.width / 2
        if offsetX < 0 {
            offsetX = 0
        }
        if offsetX > scrollView.contentSize.width - bounds.width {
            offsetX = scrollView.contentSize.width - bounds.width
        }
        if animate == true {
            UIView.animate(withDuration: 0.25) {
                self.indicateView.frame = CGRect(x: itemView.frame.midX - 15, y: self.bounds.maxY - 20, width: 30, height: 10)
                self.scrollView.contentOffset = CGPoint(x: offsetX, y: 0)
            }
        }else {
            indicateView.frame = CGRect(x: itemView.frame.midX - 15, y: self.bounds.maxY - 20, width: 30, height: 10)
            scrollView.contentOffset = CGPoint(x: offsetX, y: 0)
        }
        
        delegate?.indexChange(index: index)
    }
    
    func setIndex(index: Int) {
        if dataItems.count > index {
            indexChange(index: index)
        }
    }
}
