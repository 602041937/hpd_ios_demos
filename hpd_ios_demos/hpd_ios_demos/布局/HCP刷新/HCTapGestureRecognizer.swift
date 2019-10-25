//
//  HCTapGestureRecognizer.swift
//  hpd_ios_demos
//
//  Created by hpd on 2019/10/19.
//  Copyright © 2019 hpd. All rights reserved.
//

import UIKit

class HCTapGestureRecognizer: UIGestureRecognizer {
    
    private var firstTouchY:CGFloat = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        print("HCTapGestureRecognizer touchesBegan")
//        super.touchesBegan(touches, with: event)
//        (self.view as! UITableView).next?.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        print("HCTapGestureRecognizer touchesMoved")
//        (self.view as! UITableView).next?.touchesMoved(touches, with: event)
//        (self.view as! UITableView).isScrollEnabled = false
//        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        print("HCTapGestureRecognizer touchesEnded")
//        super.touchesEnded(touches, with: event)
//        (self.view as! UITableView).next?.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        print("HCTapGestureRecognizer touchesCancelled")
//        super.touchesCancelled(touches, with: event)
//        (self.view as! UITableView).next?.touchesCancelled(touches, with: event)
    }
    
    
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        super.touchesBegan(touches, with: event)
    //
    //        print("isScrollEnabled=\(isScrollEnabled)")
    //
    //        next?.touchesBegan(touches, with: event)
    //    }
    //
    //    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    //
    //        var firstTouch = touches.first!
    //
    //        let currentTouchPoint = firstTouch.location(in: self)
    //        let previousTouchPoint = firstTouch.previousLocation(in: self)
    //
    //        print("HCPTouchTableView  currentTouchPoint = \(currentTouchPoint)")
    //        print("HCPTouchTableView previousTouchPoint = \(previousTouchPoint)")
    //        print("HCPTouchTableView contentOffset.y = \(contentOffset.y)")
    //        if contentOffset.y <= 0 {
    //            if currentTouchPoint.y > previousTouchPoint.y {
    //                self.isScrollEnabled = false
    //            }else {
    //                self.isScrollEnabled = true
    //            }
    //        }else {
    //            self.isScrollEnabled = true
    //        }
    //
    //
    //        super.touchesMoved(touches, with: event)
    //        print("HCPTouchTableView touchesMoved")
    //        //
    //
    //        //        isScrollEnabled = false
    //        //        print(isScrollEnabled)
    //
    //        next?.touchesMoved(touches, with: event)
    //        //
    //        //      let currentY = currentTouchPoint.y - firstTouchY + self.frame.origin.y
    //        //
    //        //      print("currentY = \(currentY)")
    //
    //
    //    }
    //
    //    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        super.touchesEnded(touches, with: event)
    //        print("HCPTouchTableView touchesEnded")
    //        next?.touchesEnded(touches, with: event)
    //
    //
    //
    //    }
    //
    //    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    //
    //        super.touchesCancelled(touches, with: event)
    //        print("HCPTouchTableView touchesCancelled")
    //        next?.touchesCancelled(touches, with: event)
    //    }
}
