//
//  baseNavigationViewController.swift
//  hpd_ios_demos
//
//  Created by hpd on 2020/3/11.
//  Copyright © 2020 hpd. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarHidden(true, animated: false)
        delegate = self
        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = self
    }
}

extension BaseNavigationViewController: UINavigationControllerDelegate {
    
}

extension BaseNavigationViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let topViewController = topViewController as? BaseViewController {
            return topViewController.isCanInteractivePopGesture()
        }
        return true
    }
}
