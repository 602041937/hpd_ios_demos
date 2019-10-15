//
//  AutoWrapView.swift
//  hpd_ios_demos
//
//  Created by hpd on 2019/9/3.
//  Copyright © 2019 hpd. All rights reserved.
//

import UIKit
import SnapKit

class AutoWrapView: UIView {
    
    private var currentHeight: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        setData()
    }
    
    func setData() {
        currentHeight = 0
        snp.makeConstraints { (make) in
            make.height.equalTo(currentHeight)
        }
    }
    
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        
        subview.frame = CGRect(x: subview.frame.minX, y: subview.frame.minY + currentHeight, width: subview.frame.width, height: subview.frame.height)
        
        currentHeight = subview.frame.maxY
        
        snp.updateConstraints { (make) in
            make.height.equalTo(currentHeight)
        }
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        currentHeight = 0
    }
}
