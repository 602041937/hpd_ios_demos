//
//  ViewController.swift
//  hpd_ios_demos
//
//  Created by hpd on 2019/9/3.
//  Copyright © 2019 hpd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    static func newInstance() -> ViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func richTextBtnClick(_ sender: Any) {
        show(LayoutViewController.newInstance(), sender: nil)
    }
}

