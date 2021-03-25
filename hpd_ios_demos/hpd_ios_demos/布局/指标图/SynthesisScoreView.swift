//
//  SynthesisScoreView.swift
//  hpd_ios_demos
//
//  Created by huangpeidong on 2021/3/25.
//  Copyright © 2021 hpd. All rights reserved.
//

import UIKit

class SynthesisScoreView: UIView {
    
    // 图形
    public var innerViewWidthAndHeight: CGFloat = 150
    // 图形背景线条颜色
    public var backViewLineColor: UIColor = UIColor.gray
    // 平均分线条颜色
    public var averageScoreLineColor: UIColor = UIColor.yellow
    // 平均分线条颜色
    public var averageScoreFillColor: UIColor = UIColor.yellow.withAlphaComponent(0.5)
    // 真实分线条颜色
    public var scoreLineColor: UIColor = UIColor.red
    // 真实分线条颜色
    public var scoreFillColor: UIColor = UIColor.red.withAlphaComponent(0.2)
    // 最大分
    public var maxScore: CGFloat = 6

    private let innerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let leftFixLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    private let topFixLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    private let rightFixLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    private let bottomFixLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    private lazy var currentScoreLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .white
        $0.text = "本次成绩"
    }
    
    private lazy var currentScoreView = UIView().then {
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 2
    }
    
    private lazy var averageScoreLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .white
        $0.text = "雅思哥用户均分"
    }
    
    private lazy var averageScoreView = UIView().then {
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        
        currentScoreView.backgroundColor = scoreLineColor
        averageScoreView.backgroundColor = averageScoreLineColor
        
        addSubview(innerView)
        addSubview(leftFixLabel)
        addSubview(topFixLabel)
        addSubview(rightFixLabel)
        addSubview(bottomFixLabel)
        
        addSubview(currentScoreLabel)
        addSubview(currentScoreView)
        addSubview(averageScoreLabel)
        addSubview(averageScoreView)
        
        innerView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(innerViewWidthAndHeight)
        }
        
        leftFixLabel.snp.makeConstraints { (make) in
            make.right.equalTo(innerView.snp.left).offset(-10)
            make.centerY.equalTo(innerView)
        }
        
        topFixLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(innerView.snp.top).offset(-10)
            make.centerX.equalTo(innerView)
        }
        
        rightFixLabel.snp.makeConstraints { (make) in
            make.left.equalTo(innerView.snp.right).offset(10)
            make.centerY.equalTo(innerView)
        }
        
        bottomFixLabel.snp.makeConstraints { (make) in
            make.top.equalTo(innerView.snp.bottom).offset(10)
            make.centerX.equalTo(innerView)
        }
        
        averageScoreView.snp.makeConstraints { (make) in
            make.bottom.equalTo(-10)
            make.right.equalTo(-15)
            make.height.width.equalTo(12)
        }
        
        averageScoreLabel.snp.makeConstraints { (make) in
            make.right.equalTo(averageScoreView.snp.left).offset(-5)
            make.centerY.equalTo(averageScoreView)
        }
        
        currentScoreView.snp.makeConstraints { (make) in
            make.bottom.equalTo(averageScoreView.snp.top).offset(-10)
            make.right.equalTo(-15)
            make.height.width.equalTo(12)
        }
        
        currentScoreLabel.snp.makeConstraints { (make) in
            make.right.equalTo(currentScoreView.snp.left).offset(-5)
            make.centerY.equalTo(currentScoreView)
        }
        
        drawLine()
        drawLine2()
        drawLine3()
        
        setAverageScore(left: 3, top: 4, right: 5.5, bottom: 3.5)
        setScore(left: 4, top: 5, right: 4, bottom: 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawLine() {

        let linePath = UIBezierPath()
        linePath.move(to: CGPoint.init(x: 0, y: innerViewWidthAndHeight / 2))
        linePath.addLine(to: CGPoint.init(x: innerViewWidthAndHeight / 2, y: 0))
        linePath.addLine(to: CGPoint.init(x: innerViewWidthAndHeight, y: innerViewWidthAndHeight / 2))
        linePath.addLine(to: CGPoint.init(x: innerViewWidthAndHeight / 2, y: innerViewWidthAndHeight))
        linePath.addLine(to: CGPoint.init(x: 0, y: innerViewWidthAndHeight / 2))
    
        let lineLayer = CAShapeLayer()
        
        lineLayer.lineWidth = 3
        lineLayer.strokeColor = backViewLineColor.cgColor
        lineLayer.path = linePath.cgPath
        lineLayer.fillColor = UIColor.clear.cgColor
        
        innerView.layer.addSublayer(lineLayer)
    }
    
    private func drawLine2() {

        let linePath = UIBezierPath()
        linePath.move(to: CGPoint.init(x: 0, y: innerViewWidthAndHeight / 2))
        linePath.addLine(to: CGPoint.init(x: innerViewWidthAndHeight, y: innerViewWidthAndHeight / 2))
        
        linePath.move(to: CGPoint.init(x: innerViewWidthAndHeight / 2, y: 0))
        linePath.addLine(to: CGPoint.init(x: innerViewWidthAndHeight / 2, y: innerViewWidthAndHeight))
        
        let lineLayer = CAShapeLayer()
        
        lineLayer.lineWidth = 1
        lineLayer.strokeColor = backViewLineColor.cgColor
        lineLayer.path = linePath.cgPath
        lineLayer.fillColor = UIColor.clear.cgColor
        
        innerView.layer.addSublayer(lineLayer)
    }
    
    private func drawLine3() {
        
        let linePath = UIBezierPath()
        
        for i in 1...3 {
            let addition = CGFloat(i) * innerViewWidthAndHeight / (maxScore * 2)
            linePath.move(to: CGPoint.init(x: 0 + addition, y: innerViewWidthAndHeight / 2))
            linePath.addLine(to: CGPoint.init(x: innerViewWidthAndHeight / 2, y: addition))
            linePath.addLine(to: CGPoint.init(x: innerViewWidthAndHeight - addition, y: innerViewWidthAndHeight / 2))
            linePath.addLine(to: CGPoint.init(x: innerViewWidthAndHeight / 2, y: innerViewWidthAndHeight - addition))
            linePath.addLine(to: CGPoint.init(x: 0 + addition, y: innerViewWidthAndHeight / 2))
        }

        let lineLayer = CAShapeLayer()
        
        lineLayer.lineWidth = 1
        lineLayer.lineDashPattern = [5,5]
        lineLayer.strokeColor = backViewLineColor.cgColor
        lineLayer.path = linePath.cgPath
        lineLayer.fillColor = UIColor.clear.cgColor
        
        innerView.layer.addSublayer(lineLayer)
    }
    
    public func setAverageScore(left: CGFloat,top: CGFloat,right: CGFloat,bottom: CGFloat) {
        
        let linePath = UIBezierPath()
        
        let spage = innerViewWidthAndHeight / (maxScore * 2)
        let leftX = (maxScore - left) * spage
        let topY = (maxScore - top) * spage
        let rightX = innerViewWidthAndHeight - (maxScore - right) * spage
        let bottomY = innerViewWidthAndHeight - (maxScore - bottom) * spage
        
        linePath.move(to: CGPoint.init(x: leftX, y: innerViewWidthAndHeight / 2))
        linePath.addLine(to: CGPoint.init(x: innerViewWidthAndHeight / 2, y: topY))
        linePath.addLine(to: CGPoint.init(x: rightX, y: innerViewWidthAndHeight / 2))
        linePath.addLine(to: CGPoint.init(x: innerViewWidthAndHeight / 2, y: bottomY))
        linePath.addLine(to: CGPoint.init(x: leftX, y: innerViewWidthAndHeight / 2))
    
        let lineLayer = CAShapeLayer()
        
        lineLayer.lineWidth = 2
        lineLayer.strokeColor = averageScoreLineColor.cgColor
        lineLayer.path = linePath.cgPath
        lineLayer.fillColor = averageScoreFillColor.cgColor
        
        innerView.layer.addSublayer(lineLayer)
    }
    
    public func setScore(left: CGFloat,top: CGFloat,right: CGFloat,bottom: CGFloat) {
        
        leftFixLabel.text = "发音\nPronunciation\n\(left)分"
        topFixLabel.text = "语法多样性及准确性\nPronunciation\n\(top)分"
        rightFixLabel.text = "词汇多样性\nPronunciation\n\(right)分"
        bottomFixLabel.text = "流利性与连贯性\nPronunciation\n\(bottom)分"
        
        let linePath = UIBezierPath()
        
        let spage = innerViewWidthAndHeight / (maxScore * 2)
        let leftX = (maxScore - left) * spage
        let topY = (maxScore - top) * spage
        let rightX = innerViewWidthAndHeight - (maxScore - right) * spage
        let bottomY = innerViewWidthAndHeight - (maxScore - bottom) * spage
        
        linePath.move(to: CGPoint.init(x: leftX, y: innerViewWidthAndHeight / 2))
        linePath.addLine(to: CGPoint.init(x: innerViewWidthAndHeight / 2, y: topY))
        linePath.addLine(to: CGPoint.init(x: rightX, y: innerViewWidthAndHeight / 2))
        linePath.addLine(to: CGPoint.init(x: innerViewWidthAndHeight / 2, y: bottomY))
        linePath.addLine(to: CGPoint.init(x: leftX, y: innerViewWidthAndHeight / 2))
    
        let lineLayer = CAShapeLayer()
        
        lineLayer.lineWidth = 2
        lineLayer.strokeColor = scoreLineColor.cgColor
        lineLayer.path = linePath.cgPath
        lineLayer.fillColor = scoreFillColor.cgColor
        
        innerView.layer.addSublayer(lineLayer)
    }
}
