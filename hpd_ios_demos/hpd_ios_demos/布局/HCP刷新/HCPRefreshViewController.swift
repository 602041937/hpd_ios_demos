//
//  HCPRefreshViewController.swift
//  hpd_ios_demos
//
//  Created by huangpeidong on 2019/9/12.
//  Copyright © 2019 hpd. All rights reserved.
//

import UIKit

class HCPRefreshViewController: UIViewController {
    
    static func newInstance() -> HCPRefreshViewController {
        return HCPRefreshViewController(nibName: "HCPRefreshViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
    }
}
