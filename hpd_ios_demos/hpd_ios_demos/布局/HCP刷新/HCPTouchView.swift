//
//  HCPTouchView.swift
//  hpd_ios_demos
//
//  Created by huangpeidong on 2019/9/12.
//  Copyright © 2019 hpd. All rights reserved.
//

import UIKit

class HCPTouchView: UIView {
    
    private var firstTouchY:CGFloat = 0
    
    private var originalFrame: CGRect!
    
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
        originalFrame = frame
        print("touchesBegan")
        var firstTouch = touches.first!
        let currentTouchPoint = firstTouch.location(in: self)
        firstTouchY = currentTouchPoint.y
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        var firstTouch = touches.first!
        
        let currentTouchPoint = firstTouch.location(in: self)
        let previousTouchPoint = firstTouch.previousLocation(in: self)
        
        print("aaa  currentTouchPoint = \(currentTouchPoint)")
        print("aaa previousTouchPoint = \(previousTouchPoint)")
        
        let currentY = currentTouchPoint.y - firstTouchY + self.frame.origin.y
        if currentY > 200 {
            return
        }
        
        if currentY < 0 {
            return
        }
        
        self.frame = CGRect(x: self.frame.origin.x, y: currentY, width: self.frame.size.width, height: self.frame.size.height)
        
        print("touchesMoved")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        print("touchesEnded")
        back()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        print("touchesCancelled")
        back()
    }
    
    private func back() {
        UIView.animate(withDuration: 0.25) {
            self.frame = CGRect(x:0, y: self.originalFrame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
}
