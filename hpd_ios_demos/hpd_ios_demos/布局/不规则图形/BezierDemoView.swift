//
//  BezierDemoView.swift
//  hpd_ios_demos
//
//  Created by hpd on 2019/10/27.
//  Copyright © 2019 hpd. All rights reserved.
//

import UIKit

class BezierDemoView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path = UIBezierPath(rect: rect)
        path.lineWidth = 3
        UIColor.blue.set()
        path.fill()
    }
}
