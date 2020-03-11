//
//  BaseViewController.swift
//  hpd_ios_demos
//
//  Created by hpd on 2020/3/11.
//  Copyright © 2020 hpd. All rights reserved.
//

import UIKit
import RxSwift

/// 屏幕宽度
var kScreenWidth: CGFloat { return UIScreen.main.bounds.width }

/// 屏幕高度
var kScreenHeight: CGFloat { return UIScreen.main.bounds.height }

/// 状态栏高度（非iPhone X：StatusBar 高20pt； iPhone X：StatusBar 高44pt）
//var kStatusBarHeight: CGFloat { return UIApplication.shared.statusBarFrame.height }

let kStatusBarHeight: CGFloat = UIDevice.isIphoneX() ? 44.0 : 20.0

/// navigationBar高度 (44.0)
let kNaviBarHeight: CGFloat = 44.0

/// 导航栏高度 （非iPhone X：高64pt； iPhone X：高88pt）
let kNaviHeight: CGFloat = kStatusBarHeight + kNaviBarHeight

/// tabBarController高度 （非iPhone X：底部TabBar高49px； iPhone X：底部TabBar高83pt）
let kTabBarHeight: CGFloat = UIDevice.isIphoneX() ? (49.0 + 34.0) : 49.0

/// 顶部安全区域距离 （非iPhone X：20； iPhone X：44pt，同导航栏高度）
let kSafeAreaTop: CGFloat = UIDevice.isIphoneX() ? 44.0 : 20.0

/// 底部安全区域 距离 （非iPhone X：0pt； iPhone X：34pt）
let kSafeAreaBottom: CGFloat = UIDevice.isIphoneX() ? 34.0 : 0.0

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func isCanInteractivePopGesture() -> Bool {
        return true
    }
}
