//
//  ChatMessageTableViewCell.swift
//  hpd_ios_demos
//
//  Created by huangpeidong on 2020/5/11.
//  Copyright © 2020 hpd. All rights reserved.
//

import UIKit

class ChatMessageTableViewCell: UITableViewCell {
    
    private let nicknameLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.textColor = .red
        $0.font = .systemFont(ofSize: 16)
    }
    
    private let messageLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        contentView.addSubview(nicknameLabel)
        contentView.addSubview(messageLabel)
        
        nicknameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(0)
        }
        
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nicknameLabel.snp.bottom)
            make.left.right.bottom.equalTo(0)
        }
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(style: .default, reuseIdentifier: nil)
    }
    
    func setData(entity: ChatMessageEntity) {
        nicknameLabel.text = entity.nickname
        messageLabel.text = entity.msg
    }
}
