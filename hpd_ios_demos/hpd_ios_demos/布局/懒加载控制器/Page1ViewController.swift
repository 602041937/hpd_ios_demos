//
//  Page1ViewController.swift
//  hpd_ios_demos
//
//  Created by hpd on 2020/1/19.
//  Copyright © 2020 hpd. All rights reserved.
//

import UIKit
import Then

class Page1ViewController: HCPLazyLoadViewController {
    
    private lazy var titlePagerView = TitlePagerView().then {
        $0.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        
        view.addSubview(titlePagerView)
        titlePagerView.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.height.equalTo(70)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        titlePagerView.setData(texts: ["title1title1title1","title2","title3","title4","title5title5title5title5title5","title6","title7","title8"])
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titlePagerView.setIndex(index: 3)
//        navigationController?.pushViewController(HCPNavigation1ViewController(), animated: true)
    }
}

extension Page1ViewController: TitlePagerViewDelegate {
    func indexChange(index: Int) {
        print("hcp page1 index=\(index)")
    }
}
