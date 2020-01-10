//
//  AutoWrapView.swift
//  hpd_ios_demos
//
//  Created by hpd on 2019/9/3.
//  Copyright © 2019 hpd. All rights reserved.
//

import UIKit
import SnapKit

class AutoWrapView: UIView {
    
    var verticalSpace: CGFloat = 0
     var horizontalSpace: CGFloat = 0
     
     var setupLayoutFinishCallBack: (()->())?
     
     override init(frame: CGRect) {
         super.init(frame: frame)
     }
     
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }
     
     override func didAddSubview(_ subview: UIView) {
         super.didAddSubview(subview)
         invalidateIntrinsicContentSize()
         layoutIfNeeded()
     }
     
     override func layoutSubviews() {
         super.layoutSubviews()
         invalidateIntrinsicContentSize()
     }
     
     override var intrinsicContentSize: CGSize {
         
         var currentHeight: CGFloat = 0
         var currentX: CGFloat = 0
         var currentY: CGFloat = 0
         
         for (i,subview) in subviews.enumerated() {
             
             if i != 0 {
                 if currentX + subview.frame.width > bounds.width {
                     currentX = 0
                     currentY = currentY + subview.frame.height + verticalSpace
                 }
             }
             
             subview.frame = CGRect(x: currentX, y: currentY, width: subview.frame.width, height: subview.frame.height)
             currentX = currentX + subview.frame.width + horizontalSpace
             
             currentHeight = subview.frame.maxY
         }
         
         return CGSize(width: bounds.width, height: currentHeight)
         
     }
}
