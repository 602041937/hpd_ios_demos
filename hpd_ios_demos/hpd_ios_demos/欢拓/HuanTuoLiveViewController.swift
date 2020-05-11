//
//  HuanTuoLiveViewController.swift
//  hpd_ios_demos
//
//  Created by huangpeidong on 2020/5/11.
//  Copyright © 2020 hpd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HuanTuoLiveViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    var messages: [ChatMessageEntity] = []
    
    let accessToken = "4UzM3EDM0QWMhZmZhZmMzAjN0ETY3gjNjBTM5cjZyYGf8xXficDNzgzN58lM0YjN4kjI6ISZtFmbyJCLwojIhJCLdtlOiIHd0FmIsUzM5kDOxkDO1EjOiUWbpR3ZlJnIsISMyAzNxQzM1EjI6ICZphnIsUjN0MTM6ICZpBnIsAjOiQWanJCL3QzM4cTO6ICZp9VZzJXdvNmIsIiI6IichRXY2FmIsAjOiIXZk5WZnJCL1MTNzkTM5gTNxojIlJXawhXZiwiM0YjN4kjOiQWat92byJCLiQGcoJiOiUWbh52ajlmbiwiIyV2c1JiOiUGbvJnIsIyNyUTOiojIklWdiwSN2QzMxojIkl2XyVmb0JXYwJye"
    
    let accessKey = "afb1f789abff80fab284c31c575e59ef"
    
    private let desktopView = UIView().then {
        $0.backgroundColor = .orange
    }
    
    private let pptView = UIView().then {
        $0.backgroundColor = .green
    }
    
    private let cameraView = UIView().then {
        $0.backgroundColor = .yellow
    }
    
    private lazy var tableView = UITableView().then {
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorStyle = .none
        $0.estimatedRowHeight = 100
        $0.register(ChatMessageTableViewCell.self, forCellReuseIdentifier: "ChatMessageTableViewCell")
        $0.delegate = self
        $0.dataSource = self
        $0.showsVerticalScrollIndicator = false
    }
    
    private let playButton = UIButton().then{
        $0.setTitle("发送公共消息", for: .normal)
        $0.backgroundColor = .green
    }
    
    var talkfunSDKLive: TalkfunSDKLive!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let mWidth:CGFloat = kScreenWidth
        
        view.addSubview(desktopView)
        desktopView.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.equalTo(0)
            make.width.equalTo(mWidth)
            make.height.equalTo( 3.0 / 4 * mWidth)
        }
        
        view.addSubview(pptView)
        pptView.snp.makeConstraints { (make) in
            make.top.equalTo(desktopView.snp.bottom)
            make.left.equalTo(0)
            make.width.equalTo(mWidth)
            //            3.0 / 4 * mWidth)
            make.height.equalTo( 3.0 / 4 * mWidth)
        }
        
        view.addSubview(cameraView)
        cameraView.snp.makeConstraints { (make) in
            make.top.equalTo(pptView.snp.bottom)
            make.left.equalTo(0)
            make.width.equalTo(mWidth)
            make.height.equalTo( 3.0 / 4 * mWidth)
        }
        
        view.addSubview(playButton)
        playButton.snp.makeConstraints { (make) in
            make.top.equalTo(cameraView.snp.bottom)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(40)
        }
        playButton.rx.tap.subscribe(onNext:{ [weak self] (_) in
            guard let `self` = self else { return }
            self.sendMessage()
        }).disposed(by: disposeBag)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(playButton.snp.bottom)
            make.left.right.bottom.equalTo(0)
        }
        
        //        talkfunSDKLive = talkfunSDKLive(accessKey: accessKey, parameters: parameters)
        talkfunSDKLive = TalkfunSDKLive(accessToken: accessToken, parameters: [:])
        talkfunSDKLive.setPauseInBackground(false)
        self.talkfunSDKLive.configureDesktopContainerView(self.desktopView)
        self.talkfunSDKLive.configurePPTContainerView(self.pptView)
//        self.talkfunSDKLive.configureMediaContainerView(self.pptView)
        //        self.talkfunSDKLive.configureCameraContainerView(self.cameraView)
        
        talkfunSDKLive.on(TALKFUN_EVENT_ROOM_INIT) { (result) in
            print("huantuo 房间初始化 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_PLAY) { (result) in
            print("huantuo 视频播放 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_CAMERA_SHOW) { (result) in
            print("huantuo 摄像头显示 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_CAMERA_HIDE) { (result) in
            print("huantuo摄像头隐藏 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_DESKTOP_START) { (result) in
            print("huantuo 桌面分享开始 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_DESKTOP_STOP) { (result) in
            print("huantuo 桌面分享结束 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_DESKTOP_PAUSE) { (result) in
            print("huantuo 桌面分享暂停 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_MODE_CHANGE) { [weak self] (result) in
            print("huantuo 切换视频模式 \(result)")
            guard let `self` = self else { return }
            do {
                let result = result as! [String: Any]
                let beforeMode = result["beforeMode"] as! Int
                let currentMode = result["currentMode"] as! Int
                if currentMode == TalkfunLiveModeVideo.rawValue {
                    print("huantuo TalkfunLiveModeVideo")
                    self.talkfunSDKLive.configurePPTContainerView(self.pptView)
                    //                    self.talkfunSDKLive.configureMediaContainerView(self.desktopView)
                    self.pptView.subviews[0].frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 3.0 / 4 * kScreenWidth)
                }else if currentMode == TalkfunLiveModeDesktop.rawValue {
                    print("huantuo TalkfunLiveModeDesktop")
                    
//                    self.talkfunSDKLive.configureDesktopContainerView(self.desktopView)
                }else if currentMode == TalkfunLiveModeRTC.rawValue {
                    print("huantuo TalkfunLiveModeRTC")
                }
            }
            //            self.talkfunSDKLive.configureDesktopContainerView(self.desktopView)
            //            self.talkfunSDKLive.configurePPTContainerView(self.pptView)
            //            self.talkfunSDKLive.configureCameraContainerView(self.cameraView)
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_LIVE_START) { (result) in
            print("huantuo 直播开始 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_LIVE_STOP) { (result) in
            print("huantuo 直播开始 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_MEMBER_JOIN_OTHER) { (result) in
            print("huantuo 新用户进入直播间 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_MEMBER_TOTAL) { (result) in
            print("huantuo 在线用户总数 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_MEMBER_LEAVE) { (result) in
            print("huantuo 用户离开房间 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_MEMBER_KICK) { (result) in
            print("huantuo 踢人 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_MEMBER_FORCEOUT) { (result) in
            print("huantuo 被人强迫下线 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_CHAT_SEND) { (result) in
            print("huantuo 文字消息 \(result)")
            //            huantuo 文字消息 Optional({
            //                a = 0;
            //                attr =     (
            //                );
            //                avatar = "https://static-1.talk-fun.com/open/cms_v2/css/common/portraits/spadmin_1.png";
            //                chat =     {
            //                    enable = 1;
            //                    grant = 0;
            //                };
            //                gender = 0;
            //                gid = 0;
            //                isMe = 0;
            //                msg = hello;
            //                nickname = "\U96c5\U601d\U54e5\U8bfe\U5802";
            //                role = spadmin;
            //                term = 5;
            //                time = 1589187439;
            //                uid = "zb_9e7a2c04b001b64bba5acc5a150124ed";
            //                xid = 153416973;
            //            })
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_CHAT_PRIVATE) { (result) in
            print("huantuo 私聊 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_CHAT_DISABLE) { (result) in
            print("huantuo 禁言 \(result)")
        }
    }
    
    private func sendMessage() {
        // 成功
        //        huantuo 发送公共聊天 Optional({
        //            code = 0;
        //            data =     {
        //                a = 0;
        //                attr =         (
        //                );
        //                avatar = "https://static-1.talk-fun.com/open/cms_v2/css/common/portraits/user_1.png";
        //                chat =         {
        //                    enable = 1;
        //                    grant = 0;
        //                };
        //                gender = 0;
        //                gid = 0;
        //                isMe = 1;
        //                msg = hello;
        //                nickname = hpd;
        //                role = user;
        //                term = 4;
        //                time = 1589187367;
        //                uid = 9527;
        //                xid = 153417021;
        //            };
        //        })
        talkfunSDKLive.emit(TALKFUN_EVENT_CHAT_SEND, parameter: ["msg":"hello"]) { (result) in
            print("huantuo 发送公共聊天 \(result)")
        }
    }
    
    private func sendPrivateMessage() {
        //        talkfunSDKLive.emit(TALKFUN_EVENT_CHAT_PRIVATE, parameter: ["msg":"hello"]) { (result) in
        //
        //        }
    }
}

extension HuanTuoLiveViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageTableViewCell") as! ChatMessageTableViewCell
        cell.setData(entity: messages[indexPath.row])
        return cell
    }
}
