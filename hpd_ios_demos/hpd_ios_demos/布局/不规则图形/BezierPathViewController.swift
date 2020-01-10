//
//  BezierPathViewController.swift
//  hpd_ios_demos
//
//  Created by hpd on 2019/10/27.
//  Copyright © 2019 hpd. All rights reserved.
//

import UIKit

class BezierPathViewController: UIViewController {
    
    static func newInstance() -> BezierPathViewController{
        return BezierPathViewController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let v1 = UIView()
        v1.backgroundColor = .yellow
        v1.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        view.addSubview(v1)
        
//        let bpath = UIBezierPath(ovalIn: v1.bounds)
//        let shareLayer = CAShapeLayer()
//        shareLayer.frame = v1.bounds
//        shareLayer.path = bpath.cgPath
//        v1.layer.mask = shareLayer
        
        v1.layer.shadowColor = UIColor.red.cgColor
        v1.layer.masksToBounds = false;
        v1.layer.shadowOffset = .zero; //设置偏移量为0,四周都有阴影
        v1.layer.shadowRadius = 5;//阴影半径，默认3
        v1.layer.shadowOpacity = 1;//阴影透明度，默认0
        
        let cornerLayer = CALayer()
        cornerLayer.frame = v1.bounds
        let path = UIBezierPath(ovalIn: v1.bounds)
        
//        v1.layer.addSublayer(<#T##layer: CALayer##CALayer#>)
    }
}
