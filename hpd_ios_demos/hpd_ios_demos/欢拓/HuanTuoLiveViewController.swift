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
    
    let accessToken = "QGM3MGZ0UTM1UDNihjZ3UDZjVGZ2gTN5MWMmhTZ4MjM8xHf9JyMwATN4kzX2ETNwkTOiojIl1WYuJnIsAjOiEmIs01W6Iic0RXYiwSO4UDOxQTO4UTM6ISZtlGdnVmciwiI1kDN5UTOzUTMiojIklGeiwSN2QzMxojIklGciwCM6ICZpdmIsMDMwUDO5ojIkl2XlNnc192YiwiIiojIyFGdhZXYiwCM6IiclRmbldmIskDOxIjM0kDO1EjOiUmcpBHelJCL2ETNwkTO6ICZp12bvJnIsICNkBHaiojIl1WYut2Yp5mIsIiclNXdiojIlx2byJCLiQzNyUTOiojIklWdiwSN2QzMxojIkl2XyVmb0JXYwJye"
    
    private let containerView = UIView().then {
        $0.backgroundColor = .black
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
    
    private let sendMessageButton = UIButton().then{
        $0.setTitle("发送公共消息", for: .normal)
        $0.backgroundColor = .green
    }
    
    private let acceptButton = UIButton().then{
        $0.setTitle("同意被邀请上讲台", for: .normal)
        $0.backgroundColor = .red
    }
    
    private let rejectButton = UIButton().then{
        $0.setTitle("拒绝被邀请上讲台", for: .normal)
        $0.backgroundColor = .blue
    }
    
    var talkfunSDKLive: TalkfunSDKLive!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.rx.notification(NSNotification.Name.TalkfunError).subscribe(onNext:{ [weak self] (value) in
            guard let `self` = self else { return }
            //            huantuo TalkfunError name = TalkfunErrorNotification, object = nil, userInfo = Optional([AnyHashable("msg"): 直播初始化失败, AnyHashable("code"): 10034])
            print("huantuo TalkfunError \(value)")
            if let userInfo = value.userInfo {
                if let msg = userInfo["msg"] as? String {
                    
                }
            }
        }).disposed(by: disposeBag)
        
        view.backgroundColor = .white
        
        let mWidth:CGFloat = kScreenWidth
    
        view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.equalTo(0)
            make.width.equalTo(mWidth)
            //            3.0 / 4 * mWidth)
            make.height.equalTo( 3.0 / 4 * mWidth)
        }
        
        view.addSubview(sendMessageButton)
        sendMessageButton.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.bottom)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(40)
        }
        sendMessageButton.rx.tap.subscribe(onNext:{ [weak self] (_) in
            guard let `self` = self else { return }
            self.sendMessage()
        }).disposed(by: disposeBag)
        
        view.addSubview(acceptButton)
        acceptButton.snp.makeConstraints { (make) in
            make.top.equalTo(sendMessageButton.snp.bottom)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(40)
        }
        acceptButton.rx.tap.subscribe(onNext:{ [weak self] (_) in
            guard let `self` = self else { return }
            self.acceptInvite()
        }).disposed(by: disposeBag)
        
        view.addSubview(rejectButton)
        rejectButton.snp.makeConstraints { (make) in
            make.top.equalTo(acceptButton.snp.bottom)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(40)
        }
        rejectButton.rx.tap.subscribe(onNext:{ [weak self] (_) in
            guard let `self` = self else { return }
            self.rejuctInvite()
        }).disposed(by: disposeBag)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(rejectButton.snp.bottom)
            make.left.right.bottom.equalTo(0)
        }
        
        talkfunSDKLive = TalkfunSDKLive(accessToken: accessToken, parameters: [:])
        talkfunSDKLive.delegate = self
        talkfunSDKLive.setPauseInBackground(false)
        talkfunSDKLive.configurePPTContainerView(containerView)
        do {
            containerView.subviews[0].frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 3.0 / 4 * kScreenWidth)
        }

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
                    for sub in self.containerView.subviews {
                        sub.removeFromSuperview()
                    }
                    self.talkfunSDKLive.configurePPTContainerView(self.containerView)
                    self.containerView.subviews[0].frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 3.0 / 4 * kScreenWidth)
                }else if currentMode == TalkfunLiveModeDesktop.rawValue {
                    print("huantuo TalkfunLiveModeDesktop")
                    for sub in self.containerView.subviews {
                        sub.removeFromSuperview()
                    }
                    self.talkfunSDKLive.configureDesktopContainerView(self.containerView)
                }else if currentMode == TalkfunLiveModeRTC.rawValue {
                    print("huantuo TalkfunLiveModeRTC")
                }
            }
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
//            huantuo 踢人 Optional({
//                nickname = hpd1;
//                xid = 153666331;
//            })
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
            do {
                let item = result as! NSDictionary
                let entity = ChatMessageEntity()
                entity.avatar = item["avatar"] as! String
                entity.msg = item["msg"] as! String
                entity.nickname = item["nickname"] as! String
                self.messages = self.messages + [entity]
                self.tableView.reloadData()
            }
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_CHAT_PRIVATE) { (result) in
            print("huantuo 私聊 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_CHAT_DISABLE) { (result) in
            print("huantuo 禁言 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_CHAT_ENABLE) { (result) in
            print("huantuo 解除禁言 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_CHAT_DISABLE_ALL) { (result) in
            do {
                let item = try result as! NSDictionary
                let status = item["status"] as? String
                if let status = status {
                    if status == "0" {
                        print("huantuo 全体解除禁言")
                    }else {
                        print("huantuo 全体禁言")
                    }
                    return
                }
                let iStatus = item["status"] as? Int
                if let iStatus = iStatus {
                    if iStatus == 0 {
                        print("huantuo 全体解除禁言")
                    }else {
                        print("huantuo 全体禁言")
                    }
                    return
                }
            }catch {
                print("huantuo 全体禁言出错")
            }
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_BROADCAST) { (result) in
            /**
             huantuo 公告 Optional({
                 "__auto" = 1;
                 gid = 0;
                 message = "\U6211\U662f\U5e7f\U64ad";
                 t = 1589263754;
                 uniqid = 5eba3d8ace2dd;
             })
             */
            print("huantuo 广播 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_ANNOUNCE_NOTICE) { (result) in
            /**
             huantuo 公告 Optional({
             content = "\U6211\U662f\U516c\U544a\U554a\Uff0c\U54c8\U54c8\U54c8";
             nickname = "\U96c5\U601d\U54e5\U8bfe\U5802";
             time = "2020-05-12 14:11";
             })
              */
             print("huantuo 公告 \(result)")
        }
        
        talkfunSDKLive.on(TALKFUN_EVENT_RTC_INVITE) { [weak self] (result) in
            /**
             huantuo 公告 Optional({
             content = "\U6211\U662f\U516c\U544a\U554a\Uff0c\U54c8\U54c8\U54c8";
             nickname = "\U96c5\U601d\U54e5\U8bfe\U5802";
             time = "2020-05-12 14:11";
             })
             */
            print("huantuo 被邀请上讲台 \(result)")
            guard let `self` = self else { return }
        }
        
    }
    
    private func acceptInvite() {
        
        talkfunSDKLive.respondinvite(TalkfunRespondinviteStatusAccept) { (result) in
            print("huantuo 同意被邀请上讲台 \(result)")
//            huantuo 同意被邀请上讲台 Optional({
//                code = 0;
//            })
        }
    }
    
    private func rejuctInvite() {
        
        talkfunSDKLive.respondinvite(TalkfunRespondinviteStatusReject) { (result) in
            print("huantuo 拒绝被邀请上讲台 \(result)")
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
            //注意，禁言也会发送成功
            print("self.talkfunSDKLive.me=\(self.talkfunSDKLive.me)")
            
            do {
                let item = result as! NSDictionary
                let code = item["code"] as! Int
                if code == 0 {
                    print("huantuo 发送成功")
                    let data = item["data"] as! NSDictionary
                    let entity = ChatMessageEntity()
                    entity.avatar = data["avatar"] as! String
                    entity.msg = data["msg"] as! String
                    entity.nickname = data["nickname"] as! String
                    self.messages = self.messages + [entity]
                    self.tableView.reloadData()
                }else if code == -1 {
                    let msg = item["msg"] as! String
                    print("huantuo \(msg)")
                }
            }
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


extension HuanTuoLiveViewController: TalkfunSDKLiveDelegate {
    
    func playStatusChange(_ status: TalkfunPlayStatus) {
        print("huantuo delegate playStatusChange \(status)")
    }
    
    func playerLoadStateDidChange(_ loadState: TalkfunPlayerLoadState) {
        print("huantuo delegate playerLoadStateDidChange \(loadState)")
    }
    
    func playerPlaybackDidFinish(_ reason: TalkfunPlayerMovieFinishReason) {
        print("huantuo delegate playerPlaybackDidFinish \(reason)")
    }
    
    func multiMediaApplicate(_ status: TalkfunMultiMediaStatusChangeListener, time: Int32) {
        print("huantuo delegate multiMediaApplicate \(status) \(time)")
    }
    
    func isRealDesktop(_ isDesktop: Bool) {
        print("huantuo delegate isRealDesktop \(isDesktop)")
    }
    
    func loadCourseware() {
        print("huantuo delegate loadCourseware")
    }
    
    func videoProfileWidth(_ width: CGFloat, hight: CGFloat) {
        print("huantuo delegate videoProfileWidth \(width) \(hight)")
    }
    
    func whiteboardPageFrame(_ frame: CGRect) {
        print("huantuo delegate whiteboardPageFrame \(frame)")
    }
}
