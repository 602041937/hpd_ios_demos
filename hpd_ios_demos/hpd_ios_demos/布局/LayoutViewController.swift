//
//  LayoutViewController.swift
//  hpd_ios_demos
//
//  Created by hpd on 2019/9/3.
//  Copyright © 2019 hpd. All rights reserved.
//

import UIKit

class LayoutViewController: UIViewController {
    
    static func newInstance() -> LayoutViewController {
        return LayoutViewController(nibName: "LayoutViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func richTextBtnClick(_ sender: Any) {
        show(RichTextViewController.newInstance(), sender: nil)
    }
    
    @IBAction func autoWrapBtnClick(_ sender: Any) { show(AutoWrapViewController.newInstance(), sender: nil)
    }
    
}
