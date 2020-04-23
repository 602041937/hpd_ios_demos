//
//  VideoViewController.swift
//  hpd_ios_demos
//
//  Created by huangpeidong on 2020/4/23.
//  Copyright © 2020 hpd. All rights reserved.
//

import UIKit
import BMPlayer

class VideoViewController: UIViewController {
    
    private lazy var player = BMPlayer().then {
        $0.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(player)
        
        player.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        player.backBlock = { [unowned self] (isFullScreen) in
            
        }
        
        let asset = BMPlayerResource(url: URL(string: "https://ieltsbro.oss-cn-beijing.aliyuncs.com/headlines/covers/23szznkJGx.mp4")!,
                                     name: "风格互换：原来你我相爱")
        player.setVideo(resource: asset)
    }
}

extension VideoViewController: BMPlayerDelegate {
    
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        print("VideoViewController playerStateDidChange state = \(state)")
    }
    
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        print("VideoViewController loadedTimeDidChange loadedDuration = \(loadedDuration),totalDuration = \(totalDuration)")
    }
    
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        print("VideoViewController playTimeDidChange currentTime = \(currentTime),totalTime = \(totalTime)")
    }
    
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        print("VideoViewController playerIsPlaying = \(playing)")
    }
    
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        print("VideoViewController playerOrientChanged isFullscreen = \(isFullscreen)")
    }
}
