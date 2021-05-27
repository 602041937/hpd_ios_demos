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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let config = YZConfig.init(clientId: "d259ac4afc33521d0e", andAppKey: "a270386882e34007b25869ed2f4e2f5f")
        config.scheme = "hpddemo"
        YZSDK.shared.delegate = self
        YZSDK.shared.initializeSDK(with: config)
        
        view.backgroundColor = .yellow
    }
}


extension YouzanViewController: YZSDKDelegate {
    
    func yzsdkSecurityCheckSucceed(_ sdk: YZSDK) {
        print("youzan yzsdkSecurityCheckSucceed")
    
        DispatchQueue.main.async {
            let webView = YZWebView()
            self.view.addSubview(webView)
            webView.noticeDelegate = self
            webView.snp.makeConstraints { make in
                make.left.right.bottom.equalToSuperview()
                make.top.equalTo(70)
            }
            let url = URL(string: "https://shop41610176.m.youzan.com/wscgoods/detail/277r8pfd8gmeg")
            let request =  NSURLRequest.init(url: url!)
            webView.load(request as URLRequest)
        }
    }
    
    func yzsdkSecurityCheckFaild(_ sdk: YZSDK) {
        print("youzan yzsdkSecurityCheckFaild")
    }
    
}

extension YouzanViewController: YZWebViewNoticeDelegate {
 
    func webView(_ webView: YZWebViewProtocol, didReceive notice: YZNotice) {
        print("youzan didReceive = \(notice)")
        switch (notice.type) {
        case .login: // 收到登陆请求
            // 此时应调用SDK的登录API
            YZSDK.shared.login(withOpenUserId: "10086", avatar: nil, extra: nil, nickName: nil, gender: 0) { isSuccess, openId in
                print("youzan isSuccess=\(isSuccess),openId=\(openId)")
                
                DispatchQueue.main.async {
                    webView.reload()
                }
            }
            break;
            
        case .share: // 收到分享的回调数据
            
            // 在这里自定义分享操作
            break;
            
        case .ready: // Web页面已准备好，可以调用分享接口
            
            // 这里可以启用分享按钮（如果有的话）
            break;
            
        case .paymentFinished: // 付款完成时，回调
            print("youzan 付款完成，可以做一些操作")
            break;
        default:
            break;
        }
    }
}

