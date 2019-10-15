//
//  AutoWrapViewController.swift
//  hpd_ios_demos
//
//  Created by hpd on 2019/9/3.
//  Copyright © 2019 hpd. All rights reserved.
//

import UIKit

//从左到到右，从上到下排列的内容包裹布局
class AutoWrapViewController: UIViewController {
    
    @IBOutlet weak var wrapView: AutoWrapView!
    
    static func newInstance() -> AutoWrapViewController {
        return AutoWrapViewController(nibName: "AutoWrapViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v1 = UIView()
        v1.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        v1.backgroundColor = .green
        
        let v2 = UIView()
        v2.frame = CGRect(x: 20, y: 50, width: 200, height: 50)
        v2.backgroundColor = .blue
        
        let v3 = UIView()
        v3.frame = CGRect(x: 20, y: 50, width: 200, height: 50)
        v3.backgroundColor = .blue
        
        let v4 = UIView()
        v4.frame = CGRect(x: 20, y: 50, width: 200, height: 50)
        v4.backgroundColor = .blue
        
        wrapView.addSubview(v1)
        wrapView.addSubview(v2)
        wrapView.addSubview(v3)
        wrapView.addSubview(v4)
    }
}
