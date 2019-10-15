//
//  HCPRefreshViewController.swift
//  hpd_ios_demos
//
//  Created by huangpeidong on 2019/9/12.
//  Copyright © 2019 hpd. All rights reserved.
//

import UIKit

class HCPRefreshViewController: UIViewController {
    
    @IBOutlet weak var touchView: HCPTouchView!
    @IBOutlet weak var lbFresh: UILabel!
    
    static func newInstance() -> HCPRefreshViewController {
        return HCPRefreshViewController(nibName: "HCPRefreshViewController", bundle: nil)
    }
    
    @IBAction func endRefleshClick(_ sender: Any) {
        touchView.back()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        touchView.callBack = { value in
            self.lbFresh.text = value
        }
    }
}
