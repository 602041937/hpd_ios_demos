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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .red
        setData()
    }
    
    func setData() {
        snp.makeConstraints { (make) in
            make.height.equalTo(400)
        }
    }
    
    func dealAddSubView(view: UIView) {
    
    }
}
