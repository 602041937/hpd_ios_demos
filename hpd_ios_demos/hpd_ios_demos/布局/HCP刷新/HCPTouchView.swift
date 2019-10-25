//
//  HCPTouchView.swift
//  hpd_ios_demos
//
//  Created by huangpeidong on 2019/9/12.
//  Copyright © 2019 hpd. All rights reserved.
//

import UIKit
import SnapKit

enum HCPTouchViewState {
    case normal
    case refresh
    case relax
}

class HCPTouchView: UIView {
    
    private var firstTouchY:CGFloat = 0
    
    private var originalFrame: CGRect!
    
    var callBack: ((String) -> Void)?
    
    var state: HCPTouchViewState = .normal
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        myInit()
    }
    
    private func myInit() {
        //        layer.cornerRadius = 30
        //        layer.masksToBounds = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        myInit()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        if state != .normal {
            return
        }
        
        originalFrame = frame
        print("HCPTouchView touchesBegan")
        var firstTouch = touches.first!
        let currentTouchPoint = firstTouch.location(in: self)
        firstTouchY = currentTouchPoint.y
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesMoved(touches, with: event)
        
        var firstTouch = touches.first!
        
        let currentTouchPoint = firstTouch.location(in: self)
        let previousTouchPoint = firstTouch.previousLocation(in: self)
        
        print("HCPTouchView  currentTouchPoint = \(currentTouchPoint)")
        print("HCPTouchView previousTouchPoint = \(previousTouchPoint)")
        
        let currentY = currentTouchPoint.y - firstTouchY + self.frame.origin.y
        
        print("currentY = \(currentY)")
        
        if currentY < 0 {
            return
        }
        
        if currentY > 0 && currentY < 100 {
            print("正在滑动，但是还没有到刷新")
            callBack?("正在滑动，但是还没有到刷新")
        }
        
        if currentY >= 100 && currentY < 150 {
            print("可以刷新了~")
            callBack?("可以刷新了~")
            state = .refresh
        }
        
        if currentY >= 150 {
            print("到达展示休息区")
            callBack?("到达展示休息区~")
            state = .relax
        }
        
        if currentY > 200 {
            return
        }
        
        snp.updateConstraints { (make) in
            make.top.equalTo(currentY)
        }
        
        
        //        self.frame = CGRect(x: self.frame.origin.x, y: currentY, width: self.frame.size.width, height: self.frame.size.height)
        //
        print("HCPTouchView touchesMoved")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        print("HCPTouchView touchesEnded")
        if state == .refresh {
            refresh()
            callBack?("正在刷新~")
        }else if state == .normal {
            back()
        }else if state == .relax {
            relax()
            callBack?("正在休息~")
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        print("HCPTouchView touchesCancelled")
        //        back()
    }
    
    func back() {
        state = .normal
        UIView.animate(withDuration: 0.25) {
            self.snp.updateConstraints { (make) in
                make.top.equalTo(self.originalFrame.origin.y)
            }
            self.superview?.layoutIfNeeded()
        }
        
        //        UIView.animate(withDuration: 1) {
        //            self.layoutIfNeeded()
        ////            self.frame = CGRect(x:0, y: self.originalFrame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
        //        }
    }
    
    private func refresh() {
        print("refresh")
        
        UIView.animate(withDuration: 0.25) {
            self.snp.updateConstraints { (make) in
                make.top.equalTo(self.originalFrame.origin.y + 100)
            }
            self.superview?.layoutIfNeeded()
        }
        
        //            self.frame = CGRect(x:0, y: self.originalFrame.origin.y + 100, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    private func relax() {
        print("relax")
        
        UIView.animate(withDuration: 0.25) {
            self.snp.updateConstraints { (make) in
                make.top.equalTo(self.originalFrame.origin.y + 200)
            }
            self.superview?.layoutIfNeeded()
            //            self.frame = CGRect(x:0, y: self.originalFrame.origin.y + 200, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        return self
//    }
}
