//
//  HCPTouch2TableView.swift
//  hpd_ios_demos
//
//  Created by hpd on 2019/10/18.
//  Copyright © 2019 hpd. All rights reserved.
//

import UIKit

class HCPTouch2TableView: UITableView {
    
//    static var e: UIEvent? = nil
//    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        
//        print("HCPTouch2TableView hitTest")
////        if HCPTouch2TableView.e != nil && HCPTouch2TableView.e == event {
////            HCPTouch2TableView.e = nil
////            return super.hitTest(point, with: event)
////        }
////
////        HCPTouch2TableView.e = event
//        
//        if let type = event?.type {
//            if type == .touches {
//                let touches = event!.touches(for: self)
//                if touches != nil && touches!.count > 0 {
//                    let touche = touches?.first
//                    if touche!.phase == .began {
//                        print("HCPTouch2TableView began")
//                    }else if touche!.phase == .moved  {
//                        print("HCPTouch2TableView moved")
//                    }else if touche!.phase == .cancelled {
//                        print("HCPTouch2TableView cancelled")
//                    }else if touche!.phase == .ended {
//                        print("HCPTouch2TableView ended")
//                    }
//                }
//                
//            }
//        }
//        
//        return super.hitTest(point, with: event)
//    }
}
