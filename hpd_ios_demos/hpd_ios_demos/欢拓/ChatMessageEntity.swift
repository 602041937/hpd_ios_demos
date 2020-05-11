//
//  ChatMessageEntity.swift
//  hpd_ios_demos
//
//  Created by huangpeidong on 2020/5/11.
//  Copyright © 2020 hpd. All rights reserved.
//

import UIKit

//a = 0;
//avatar = "https://static-1.talk-fun.com/open/cms_v2/css/common/portraits/spadmin_1.png";
//cmd = 1;
//gid = 0;
//msg = "\U5927\U5bb6\U665a\U5b89\U55bd";
//nickname = Elfy;
//role = spadmin;
//starttime = 7919;
//status = 0;
//time = 7919;
//timestamp = 1588856956;
//uid = "zb_68182ac399fa72c613e8f647c8c3c508";
//xid = 152370029;
//
//uid     NSString     客户用户ID
//starttime     NSString     聊天开始的时间戳
//gid     NSString     客户定义的用户组ID
//avatar     NSString     头像地址(不存在该字段，或者该字段为空，代表没有设置头像，请使用本地默认头像)
//role     NSString     用户角色(对应TalkfunSDK.h里面的角色定义)
//nickname     NSString     用户昵称
//msg     NSString     聊天内容
//xid     NSString     该用户在欢拓平台上的唯一ID


class ChatMessageEntity: Codable {
    
    var avatar: String?
    var msg: String?
    var nickname: String?
}
