//
//  YouZanWebViewController.swift
//  hpd_ios_demos
//
//  Created by hcp on 2021/5/31.
//  Copyright © 2021 hpd. All rights reserved.
//

import UIKit
import YZBaseSDK

class YouZanWebViewController: BaseViewController {
    
    let webView = YZWebView()
    
    var url = URL(string: "https://shop41610176.youzan.com/v2/showcase/homepage?alias=d8PgEGLuap&dc_ps=2605582907183549446.300001")!
    
    private let backButton = UIButton().then {
        $0.setTitle("返回", for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        webView.noticeDelegate = self
        webView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(kNaviHeight)
        }
     
        let request =  NSURLRequest.init(url: url)
        webView.load(request as URLRequest)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        backButton.rx.tap.subscribe(onNext:{ [weak self] (value) in
            guard let `self` = self else { return }
            if self.webView.canGoBack == true {
                self.webView.goBack()
            }else {
                self.navigationController?.popViewController(animated: true)
            }
        }).disposed(by: disposeBag)
    }
}

extension YouZanWebViewController: YZWebViewNoticeDelegate {
 
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
