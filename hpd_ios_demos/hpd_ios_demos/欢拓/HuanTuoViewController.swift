//
//  HuanTuoViewController.swift
//  hpd_ios_demos
//
//  Created by huangpeidong on 2020/5/8.
//  Copyright © 2020 hpd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HuanTuoViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    var messages: [ChatMessageEntity] = []
    
    let accessToken = "iVWM5YDZzUmYwgjY4YGZzI2NxMWN2MmYwU2NlR2Y1cDf8xXfikzXzEjN2YTOflDMwcDO5IiOiUWbh5mciwCM6ISYiwCM6ICZpdmIs01W6Iic0RXYiwSO3YTNxATO4UTM6ISZtlGdnVmciwiI2MDO2QzNyUTMiojIklGeiwSN2QzMxojIklGciwiINNFTvBXailWRT9ENzRlTiojIzVGZvNmIsMTM2YjN5ojIkl2XlNnc192YiwiIiojIyFGdhZXYiwCM6IiclRmbldmIskzN2UjMwkDO1EjOiUmcpBHelJCL5ADM3gTO6ICZp12bvJnIsICdzVGdiojIl1WYut2Yp5mIsIiclNXdiojIlx2byJCLiADMwATMiojIklWdiwSN2QzMxojIkl2XyVmb0JXYwJye"
    
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
    
    private let pauseButton = UIButton().then{
        $0.setTitle("暂停", for: .normal)
        $0.backgroundColor = .green
    }
    
    private let playButton = UIButton().then{
        $0.setTitle("播放", for: .normal)
        $0.backgroundColor = .green
    }
    
    private let slider = UISlider().then {
        $0.minimumValue = 0
        $0.maximumValue = 1
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
    
    var talkfunSDKPlayback: TalkfunSDKPlayback!
    
    var videoDuration: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let mWidth:CGFloat = kScreenWidth
        
        view.addSubview(desktopView)
        desktopView.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.equalTo(0)
            make.width.equalTo(mWidth)
            make.height.equalTo(40)
        }
        
        view.addSubview(pptView)
        pptView.snp.makeConstraints { (make) in
            make.top.equalTo(desktopView.snp.bottom)
            make.left.equalTo(0)
            make.width.equalTo(mWidth)
            make.height.equalTo(3.0 / 4 * mWidth)
        }
        
        view.addSubview(cameraView)
        cameraView.snp.makeConstraints { (make) in
            make.top.equalTo(pptView.snp.bottom)
            make.left.equalTo(0)
            make.width.equalTo(mWidth)
            make.height.equalTo(40)
        }
        
        view.addSubview(slider)
        slider.snp.makeConstraints { (make) in
            make.top.equalTo(cameraView.snp.bottom)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(40)
        }
        //        slider.rx.controlEvent(.touchUpOutside).subscribe(onNext:{ [weak self] (value) in
        //            print("tapGesture")
        //        }).disposed(by: disposeBag)
        
        slider.rx.value.asObservable().throttle(1,latest: true, scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] value in
            guard let `self` = self else { return }
            if self.videoDuration != 0 {
                print("slider = \(self.videoDuration * CGFloat(value))")
                self.talkfunSDKPlayback.seek(self.videoDuration * CGFloat(value))
            }
        }).disposed(by: disposeBag)
        
        view.addSubview(pauseButton)
        pauseButton.snp.makeConstraints { (make) in
            make.top.equalTo(slider.snp.bottom)
            make.left.equalTo(0)
            make.height.equalTo(40)
        }
        pauseButton.rx.tap.subscribe(onNext:{ [weak self] (_) in
            guard let `self` = self else { return }
            self.talkfunSDKPlayback.pause()
        }).disposed(by: disposeBag)
        
        view.addSubview(playButton)
        playButton.snp.makeConstraints { (make) in
            make.top.equalTo(pauseButton)
            make.left.equalTo(pauseButton.snp.right)
            make.width.equalTo(pauseButton)
            make.right.equalTo(0)
            make.height.equalTo(40)
        }
        playButton.rx.tap.subscribe(onNext:{ [weak self] (_) in
            guard let `self` = self else { return }
            self.talkfunSDKPlayback.play()
        }).disposed(by: disposeBag)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(playButton.snp.bottom)
            make.left.right.bottom.equalTo(0)
        }

        let parameters = [TalkfunPlaybackID: "966613"]
        //        talkfunSDKPlayback = TalkfunSDKPlayback(accessKey: accessKey, parameters: parameters)
        talkfunSDKPlayback = TalkfunSDKPlayback(accessToken: accessToken, parameters: parameters)
        talkfunSDKPlayback.setPauseInBackground(false)
 
        talkfunSDKPlayback.on(TALKFUN_EVENT_VOD_INFO) { [weak self] (result) in
            print("huantuo 点播的信息 \(result)")
            guard let `self` = self else { return }
            do {
                let result = result as! [String: Any]
                let value = result["duration"] as! CGFloat
                self.videoDuration = value
            }
//            huantuo 点播的信息 Optional({
//                album = "<null>";
//                authorAvatar = "https://static-1.talk-fun.com/open/cms_v2/css/common/portraits/spadmin_1.png";
//                duration = 7925;
//                liveid = 966613;
//                title = "\U591a\U90bb\U56fd\U8003\U8bd5\U6df1\U5ea6\U89e3\U6790";
//                user =     {
//                    a = 0;
//                    "asset_id" = 966613;
//                    "asset_type" = 9;
//                    attr =         (
//                    );
//                    avatar = "";
//                    codes = NTs4OSEibipoLSM;
//                    "course_id" = 966613;
//                    expire = 1589025679;
//                    gender = 0;
//                    gid = 0;
//                    nickname = test;
//                    "partner_id" = 13465;
//                    pid = 13465;
//                    regtime = 1589015679;
//                    rname = "987009_966613_9";
//                    role = user;
//                    roomid = 987009;
//                    uid = 10000;
//                    xid = 152746836;
//                };
//                views = 43;
//            })
        }
        
        talkfunSDKPlayback.on(TALKFUN_EVENT_VOD_START) { (result) in
            print("huantuo 点播开始 \(result)")
        }
        
        talkfunSDKPlayback.on(TALKFUN_EVENT_VOD_STOP) { (result) in
            print("huantuo 点播结束 \(result)")
        }
        
        
        talkfunSDKPlayback.on(TALKFUN_EVENT_VOD_MESSAGE_APPEND) { (result) in
            print("huantuo 聊天列表 \(result)")
            do {
                let array = result as! [NSDictionary]
                var temp = [ChatMessageEntity]()
                for item in array {
                    let entity = ChatMessageEntity()
                    entity.avatar = item["avatar"] as! String
                    entity.msg = item["msg"] as! String
                    entity.nickname = item["nickname"] as! String
                    temp.append(entity)
                }
                self.messages = self.messages + temp
                self.tableView.reloadData()
            }
        }
        
        talkfunSDKPlayback.on(TALKFUN_EVENT_VOD_QUESTION_APPEND) { (result) in
            print("huantuo 问题列表 \(result)")
        }
        
        talkfunSDKPlayback.on(TALKFUN_EVENT_VOD_CHAPTER_LIST) { (result) in
            print("huantuo 章节列表 \(result)")
        }
        
        talkfunSDKPlayback.on(TALKFUN_EVENT_NETWORK_SPEED) { (result) in
            //            print("huantuo 网络速度 \(result)")
        }
        
        talkfunSDKPlayback.on(TALKFUN_EVENT_VOD_DURATION) { (result) in
//            print("huantuo 视频播放时间 \(result)")
            do {
                if self.videoDuration == 0 {
                    return
                }
                let progress = result as! CGFloat
                self.slider.setValue(Float(progress/self.videoDuration), animated: false)
            }
        }
        
        talkfunSDKPlayback.on(TALKFUN_EVENT_PLAY) { (result) in
            print("huantuo 视频播放 \(result)")
        }
        
        talkfunSDKPlayback.on(TALKFUN_EVENT_CAMERA_SHOW) { (result) in
            print("huantuo 摄像头显示 \(result)")
        }
        
        talkfunSDKPlayback.on(TALKFUN_EVENT_CAMERA_HIDE) { (result) in
            print("huantuo摄像头隐藏 \(result)")
        }
        
        talkfunSDKPlayback.on(TALKFUN_EVENT_DESKTOP_START) { (result) in
            print("huantuo 桌面分享开始 \(result)")
        }
        
        talkfunSDKPlayback.on(TALKFUN_EVENT_DESKTOP_STOP) { (result) in
            print("huantuo 桌面分享结束 \(result)")
        }
        
        talkfunSDKPlayback.on(TALKFUN_EVENT_MODE_CHANGE) { [weak self] (result) in
            print("huantuo 切换视频模式 \(result)")
            guard let `self` = self else { return }
            self.talkfunSDKPlayback.configureDesktopContainerView(self.desktopView)
            self.talkfunSDKPlayback.configurePPTContainerView(self.pptView)
            self.talkfunSDKPlayback.configureCameraContainerView(self.cameraView)
        }
        
        talkfunSDKPlayback.on(TALKFUN_EVENT_BROADCAST) { (result) in
            print("huantuo 播放时间同步的广播 \(result)")
        }
        
        //        Observable<Int>.interval(1.0, scheduler: MainScheduler.instance).subscribe(onNext:{ [weak self] (value) in
        //            self?.getChatMessage(duration:value)
        //        }).disposed(by: disposeBag)
    }
    
    private func getChatMessage(duration: Int) {
        
        talkfunSDKPlayback.getChatWithDuration(20) { (result) in
//            print("huantuo 获取聊天记录 \(result)  self.messages.count = \(self.messages.count)")
//            do {
//                let array = result as! [NSDictionary]
//                var temp = [ChatMessageEntity]()
//                for item in array {
//                    let entity = ChatMessageEntity()
//                    entity.avatar = item["avatar"] as! String
//                    entity.msg = item["msg"] as! String
//                    entity.nickname = item["nickname"] as! String
//                    temp.append(entity)
//                }
//                self.messages = temp
//                self.tableView.reloadData()
//            }
        }
    }
}

extension HuanTuoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageTableViewCell") as! ChatMessageTableViewCell
        cell.setData(entity: messages[indexPath.row])
        return cell
    }
}
