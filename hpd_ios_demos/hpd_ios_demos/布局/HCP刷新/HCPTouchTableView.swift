//
//  HCPTouchTableView.swift
//  hpd_ios_demos
//
//  Created by hpd on 2019/10/18.
//  Copyright © 2019 hpd. All rights reserved.
//

import UIKit

class HCPTouchTableView: UITableView {
    
    private var firstTouchY:CGFloat = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
//        canCancelContentTouches = false
       
        print("isScrollEnabled=\(isScrollEnabled)")
        
        next?.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var firstTouch = touches.first!
               
               let currentTouchPoint = firstTouch.location(in: self)
               let previousTouchPoint = firstTouch.previousLocation(in: self)
               
               print("HCPTouchTableView  currentTouchPoint = \(currentTouchPoint)")
               print("HCPTouchTableView previousTouchPoint = \(previousTouchPoint)")
               print("HCPTouchTableView contentOffset.y = \(contentOffset.y)")
               if contentOffset.y <= 0 {
                   if currentTouchPoint.y > previousTouchPoint.y {
                       self.isScrollEnabled = false
                   }else {
                       self.isScrollEnabled = true
                   }
               }else {
                   self.isScrollEnabled = true
               }
        
        
        super.touchesMoved(touches, with: event)
        print("HCPTouchTableView touchesMoved")
        //
        
        //        isScrollEnabled = false
        //        print(isScrollEnabled)
        
        next?.touchesMoved(touches, with: event)
        //
        //      let currentY = currentTouchPoint.y - firstTouchY + self.frame.origin.y
        //
        //      print("currentY = \(currentY)")
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        print("HCPTouchTableView touchesEnded")
        next?.touchesEnded(touches, with: event)
        
        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesCancelled(touches, with: event)
        print("HCPTouchTableView touchesCancelled")
        next?.touchesCancelled(touches, with: event)
    }
}

//extension UIScrollView {
//    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("extension touchesBegan")
//        next?.touchesBegan(touches, with: event)
//        superview?.touchesBegan(touches, with: event)
//    }
//    
//    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("extension touchesMoved")
//        next?.touchesMoved(touches, with: event)
//        superview?.touchesMoved(touches, with: event)
//    }
//    
//    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("extension touchesEnded")
//        next?.touchesEnded(touches, with: event)
//        superview?.touchesEnded(touches, with: event)
//    }
//}
