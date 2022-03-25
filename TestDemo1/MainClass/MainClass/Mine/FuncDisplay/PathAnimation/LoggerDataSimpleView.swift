//
//  LoggerDataSimpleView.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/3/23.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

class LoggerDataSimpleView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: 0xf2f2f2)
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var proAnimationView = PathAnimationView()
    var gridAnimationView = PathAnimationView()
    
    func initView() {
        let centerImageView = UIImageView(image: UIImage(named: "icon_dcac_51x63"))
        self.addSubview(centerImageView)
        centerImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(20)
            make.width.equalTo(51)
            make.height.equalTo(63)
        }
        
        let proImageView = UIImageView(image: UIImage(named: "icon_pro_48"))
        self.addSubview(proImageView)
        proImageView.snp.makeConstraints { make in
            make.size.equalTo(48)
            make.centerY.equalTo(centerImageView)
            make.left.equalToSuperview().offset(25)
        }
        
        let gridImageView = UIImageView(image: UIImage(named: "icon_grid_48"))
        self.addSubview(gridImageView)
        gridImageView.snp.makeConstraints { make in
            make.size.centerY.equalTo(proImageView)
            make.right.equalToSuperview().offset(-25)
        }

        self.layoutIfNeeded()
        
        let imageMargin = 5.0 // 线到中间图表的距离
        
        let proArray = [CGPoint(x: proImageView.frame.maxX, y: proImageView.frame.midY),
                        CGPoint(x: centerImageView.frame.minX - imageMargin, y: centerImageView.frame.midY)]
        proAnimationView = PathAnimationView(pointArray: proArray)
        self.layer.addSublayer(proAnimationView)
        
        
        let gridArray = [CGPoint(x: centerImageView.frame.maxX + imageMargin, y: centerImageView.frame.midY),
                        CGPoint(x: gridImageView.frame.minX, y: gridImageView.frame.midY)]
        gridAnimationView = PathAnimationView(pointArray: gridArray, isDelayAnimation: true)
        self.layer.addSublayer(gridAnimationView)
        
        self.addSubview(proInfoView)
        self.addSubview(gridInfoView)
        
        proInfoView.snp.makeConstraints { make in
            make.centerX.equalTo(proImageView)
            make.bottom.equalTo(proImageView.snp_top)
        }
        gridInfoView.snp.makeConstraints { make in
            make.centerX.equalTo(gridImageView)
            make.bottom.equalTo(gridImageView.snp_top)
        }
    }

    // MARK: UI
    private lazy var proInfoView: LoggerInfoView = {
        let infoView = LoggerInfoView("Production  ", "0.00kw")
        return infoView;
    }()
    private lazy var gridInfoView: LoggerInfoView = {
        let infoView = LoggerInfoView("Grid  ", "0.00kw")
        return infoView;
    }()
    
    // MARK: Action
    func changeAction() {
        self.proInfoView.content = "25.01kw"
        self.proAnimationView.removePathAnimation()
        self.proAnimationView.lineStokeColor = UIColor.lightGray
    }
}
