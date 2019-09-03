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
    
    static func newInstance() -> AutoWrapViewController {
        return AutoWrapViewController(nibName: "AutoWrapViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
