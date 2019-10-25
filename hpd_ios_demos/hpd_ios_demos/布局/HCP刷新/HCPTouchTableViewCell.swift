//
//  HCPTouchTableViewCell.swift
//  hpd_ios_demos
//
//  Created by hpd on 2019/10/19.
//  Copyright © 2019 hpd. All rights reserved.
//

import UIKit

class HCPTouchTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("HCPTouchTableViewCell touchesBegan")
//        super.touchesBegan(touches, with: event)
//        //        (self.view as! UITableView).next?.touchesBegan(touches, with: event)
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("HCPTouchTableViewCell touchesMoved")
//        //        (self.view as! UITableView).next?.touchesMoved(touches, with: event)
//        //        (self.view as! UITableView).isScrollEnabled = false
//        super.touchesMoved(touches, with: event)
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("HCPTouchTableViewCell touchesEnded")
//        super.touchesEnded(touches, with: event)
//        //        (self.view as! UITableView).next?.touchesEnded(touches, with: event)
//    }
//    
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("HCPTouchTableViewCell touchesCancelled")
//        super.touchesCancelled(touches, with: event)
//        //        (self.view as! UITableView).next?.touchesCancelled(touches, with: event)
//    }
    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        return nil
//    }
}
