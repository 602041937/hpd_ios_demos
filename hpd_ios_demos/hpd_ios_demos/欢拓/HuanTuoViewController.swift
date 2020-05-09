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
    
    var talkfunSDKPlayback: TalkfunSDKPlayback!
    
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
        
        view.addSubview(pauseButton)
        pauseButton.snp.makeConstraints { (make) in
            make.top.equalTo(cameraView.snp.bottom)
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

        let parameters = [TalkfunPlaybackID: "966613"]
        //        talkfunSDKPlayback = TalkfunSDKPlayback(accessKey: accessKey, parameters: parameters)
        talkfunSDKPlayback = TalkfunSDKPlayback(accessToken: accessToken, parameters: parameters)
        talkfunSDKPlayback.setPauseInBackground(false)
 
        talkfunSDKPlayback.on(TALKFUN_EVENT_VOD_INFO) { (result) in
            print("huantuo 点播的信息 \(result)")
        }
        
        talkfunSDKPlayback.on(TALKFUN_EVENT_VOD_START) { (result) in
            print("huantuo 点播开始 \(result)")
        }
        
        talkfunSDKPlayback.on(TALKFUN_EVENT_VOD_STOP) { (result) in
            print("huantuo 点播结束 \(result)")
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
        
        talkfunSDKPlayback.on(TALKFUN_EVENT_PLAY) { (result) in
            print("huantuo 视频播放时间 \(result)")
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
        
    
    }
}
