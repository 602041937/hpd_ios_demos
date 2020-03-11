//
//  HCPTabBarItemView.swift
//  hpd_ios_demos
//
//  Created by hpd on 2020/3/7.
//  Copyright © 2020 hpd. All rights reserved.
//

import UIKit
import Then
import RxGesture
import RxSwift
import RxCocoa

class HCPTabBarItemView: UIView {
     
    let selectedImageView = UIImageView()
    
    let unSelectedImageView = UIImageView()
    
    let title = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 10)
    }
    
    private var selectedTitleColor: UIColor = UIColor.black
    private var unSelectedTitleColor: UIColor = UIColor.yellow
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelectedTitleColor(color: UIColor){
        selectedTitleColor = color
    }
    
    func setUnSelectedTitleColor(color: UIColor){
        unSelectedTitleColor = color
    }
    
    func isSelected(_ selected: Bool) {
        if selected {
            title.textColor = selectedTitleColor
        }else {
            title.textColor = unSelectedTitleColor
        }
    }
    
    private func setup() {
        
        title.textColor = .black
        
        addSubview(selectedImageView)
        addSubview(unSelectedImageView)
        addSubview(title)
        
        selectedImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
        }
        
        unSelectedImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
        }
        
        title.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-5)
        }
    }
}
