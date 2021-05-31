//
//  YouzanViewController.swift
//  hpd_ios_demos
//
//  Created by hcp on 2021/5/25.
//  Copyright © 2021 hpd. All rights reserved.
//

import UIKit
import YZBaseSDK

class YouzanViewController: BaseViewController {
    
    private let url = URL(string: "https://shop41610176.youzan.com/v2/showcase/homepage?alias=d8PgEGLuap&dc_ps=2605582907183549446.300001")!
    private let urlSingle = URL(string: "https://shop41610176.m.youzan.com/wscgoods/detail/2flkz20he3om0")!
    
    private let button1 = UIButton().then {
        $0.setTitle("打开商城外部链接", for: .normal)
    }
    
    private let button2 = UIButton().then {
        $0.setTitle("打开单个商品外部链接", for: .normal)
    }
    
    private let button3 = UIButton().then {
        $0.setTitle("打开app集成SDK商城", for: .normal)
    }
    
    private let button4 = UIButton().then {
        $0.setTitle("打开app集成SDK单个商品", for: .normal)
    }
    
    private let button5 = UIButton().then {
        $0.setTitle("打开雅思哥商城小程序", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(button4)
        view.addSubview(button5)
        
        button1.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.centerX.equalToSuperview()
        }
        
        button2.snp.makeConstraints { make in
            make.top.equalTo(button1).offset(100)
            make.centerX.equalToSuperview()
        }
        
        button3.snp.makeConstraints { make in
            make.top.equalTo(button2).offset(100)
            make.centerX.equalToSuperview()
        }
        
        button4.snp.makeConstraints { make in
            make.top.equalTo(button3).offset(100)
            make.centerX.equalToSuperview()
        }
        
        button5.snp.makeConstraints { make in
            make.top.equalTo(button4).offset(100)
            make.centerX.equalToSuperview()
        }
        
        let config = YZConfig.init(clientId: "d259ac4afc33521d0e", andAppKey: "a270386882e34007b25869ed2f4e2f5f")
        config.scheme = "hpddemo"
        YZSDK.shared.delegate = self
        YZSDK.shared.initializeSDK(with: config)
        
        button1.rx.tap.subscribe(onNext:{ [weak self] (value) in
            guard let `self` = self else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(self.url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(self.url)
            }
        }).disposed(by: disposeBag)
        
        button2.rx.tap.subscribe(onNext:{ [weak self] (value) in
            guard let `self` = self else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(self.urlSingle, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(self.urlSingle)
            }
        }).disposed(by: disposeBag)
        
        button3.rx.tap.subscribe(onNext:{ [weak self] (value) in
            guard let `self` = self else { return }
            let c = YouZanWebViewController()
            c.url = self.url
            self.navigationController?.pushViewController(c, animated: true)
        }).disposed(by: disposeBag)
        
        button4.rx.tap.subscribe(onNext:{ [weak self] (value) in
            guard let `self` = self else { return }
            let c = YouZanWebViewController()
            c.url = self.urlSingle
            self.navigationController?.pushViewController(c, animated: true)
        }).disposed(by: disposeBag)
    }
}


extension YouzanViewController: YZSDKDelegate {
    
    func yzsdkSecurityCheckSucceed(_ sdk: YZSDK) {
        print("youzan yzsdkSecurityCheckSucceed")
    
        DispatchQueue.main.async {
           
        }
    }
    
    func yzsdkSecurityCheckFaild(_ sdk: YZSDK) {
        print("youzan yzsdkSecurityCheckFaild")
    }
}

