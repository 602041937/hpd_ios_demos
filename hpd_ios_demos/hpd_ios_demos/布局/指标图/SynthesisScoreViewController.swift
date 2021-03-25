//
//  SynthesisScoreViewController.swift
//  hpd_ios_demos
//
//  Created by huangpeidong on 2021/3/25.
//  Copyright © 2021 hpd. All rights reserved.
//

import UIKit

class SynthesisScoreViewController: UIViewController {
    
    private let synthesisScoreView = SynthesisScoreView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        
        view.addSubview(synthesisScoreView)
        
        synthesisScoreView.snp.makeConstraints { (make) in
            make.top.equalTo(200)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(300)
        }
    }
}
