//
//  YouzanViewController.swift
//  hpd_ios_demos
//
//  Created by hcp on 2021/5/25.
//  Copyright © 2021 hpd. All rights reserved.
//

import UIKit
import YZBaseSDK

class YouzanViewController: UIViewController {
    
    private let webView = YZWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = YZConfig.init(clientId: "d259ac4afc33521d0e", andAppKey: "a270386882e34007b25869ed2f4e2f5f")
        config.scheme = "hpddemo"
        YZSDK.shared.initializeSDK(with: config)
        
        view.backgroundColor = .yellow

        view.addSubview(webView)
        
        webView.frame = CGRect(x: 0, y: 0, width: 300, height: 600)
        
      
        let url = URL(string: "https://www.baidu.com")
        let request =  NSURLRequest.init(url: url!)
        webView.load(request as URLRequest)
    }
}
