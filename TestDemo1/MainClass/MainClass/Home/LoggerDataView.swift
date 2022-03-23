//
//  LoggerDataView.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/3/22.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation
import SnapKit

class LoggerDataView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: 0xf2f2f2)
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var miAnimationView = PathAnimationView()
    var proAnimationView = PathAnimationView()
    var batteryAnimationView = PathAnimationView()
    var genAnimationView = PathAnimationView()
    var upsAnimationView = PathAnimationView()
    var gridAnimationView = PathAnimationView()
    var smartAnimationView = PathAnimationView()
    var consAnimationView = PathAnimationView()
    
    func initView() {
        let centerImageView = UIImageView(image: UIImage(named: "icon_dcac_51x63"))
        self.addSubview(centerImageView)
        centerImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(51)
            make.height.equalTo(63)
        }
        
        let miImageView = UIImageView(image: UIImage(named: "icon_mi_48"))
        self.addSubview(miImageView)
        miImageView.snp.makeConstraints { make in
            make.size.equalTo(48)
            make.centerY.equalTo(centerImageView)
            make.left.equalToSuperview().offset(25)
        }
        
        let genImageView = UIImageView(image: UIImage(named: "icon_generador_48"))
        self.addSubview(genImageView)
        genImageView.snp.makeConstraints { make in
            make.size.equalTo(miImageView)
            make.centerX.equalTo(centerImageView)
            make.top.equalToSuperview().offset(48)
        }
        
        let smartImageView = UIImageView(image: UIImage(named: "icon_smart_48"))
        self.addSubview(smartImageView)
        smartImageView.snp.makeConstraints { make in
            make.size.equalTo(miImageView)
            make.centerY.equalTo(centerImageView)
            make.right.equalToSuperview().offset(-25)
        }
        
        let upsImageView = UIImageView(image: UIImage(named: "icon_ups_48"))
        self.addSubview(upsImageView)
        upsImageView.snp.makeConstraints { make in
            make.size.centerX.equalTo(genImageView)
            make.bottom.equalToSuperview().offset(-48)
        }
        
        let proImageView = UIImageView(image: UIImage(named: "icon_pro_48"))
        self.addSubview(proImageView)
        proImageView.snp.makeConstraints { make in
            make.size.centerX.equalTo(miImageView)
            make.centerY.equalTo(genImageView)
        }
        
        let gridImageView = UIImageView(image: UIImage(named: "icon_grid_48"))
        self.addSubview(gridImageView)
        gridImageView.snp.makeConstraints { make in
            make.size.centerY.equalTo(genImageView)
            make.centerX.equalTo(smartImageView)
        }

        let consImageView = UIImageView(image: UIImage(named: "icon_consump_48"))
        self.addSubview(consImageView)
        consImageView.snp.makeConstraints { make in
            make.size.centerX.equalTo(smartImageView)
            make.centerY.equalTo(upsImageView)
        }
        
        let batteryImageView = UIImageView(image: UIImage(named: "icon_battery_48"))
        self.addSubview(batteryImageView)
        batteryImageView.snp.makeConstraints { make in
            make.size.centerX.equalTo(miImageView)
            make.centerY.equalTo(upsImageView)
        }
        
        self.layoutIfNeeded()
        
        let lineMargin = 10.0 // path之间的距离
        let imageMargin = 5.0 // 线到中间图表的距离
        
        let leftStartX = proImageView.frame.maxX
        let leftSecondX = proImageView.frame.maxX + (genImageView.frame.minX - proImageView.frame.maxX)/2.0 - lineMargin
        let leftEndX = centerImageView.frame.minX - imageMargin
        
        let rightStartX = centerImageView.frame.maxX + imageMargin
        let rightSecondX = gridImageView.frame.minX - (gridImageView.frame.minX - genImageView.frame.maxX)/2.0 + lineMargin
        let rightEndX = gridImageView.frame.minX
        
        let miArray = [CGPoint(x: leftStartX, y: centerImageView.frame.midY),
                       CGPoint(x: leftEndX, y: centerImageView.frame.midY)]
        miAnimationView = PathAnimationView(pointArray: miArray, isNeedMove: false)
        self.layer.addSublayer(miAnimationView)
        
        let proArray = [CGPoint(x: leftStartX, y: proImageView.frame.midY),
                        CGPoint(x: leftSecondX, y: proImageView.frame.midY),
                        CGPoint(x: leftSecondX, y: centerImageView.frame.midY - lineMargin),
                        CGPoint(x: leftEndX, y: centerImageView.frame.midY - lineMargin)]
        proAnimationView = PathAnimationView(pointArray: proArray)
        self.layer.addSublayer(proAnimationView)
        
        let batteryArray = [CGPoint(x: leftStartX, y: batteryImageView.frame.midY),
                            CGPoint(x: leftSecondX, y: batteryImageView.frame.midY),
                            CGPoint(x: leftSecondX, y: centerImageView.frame.midY + lineMargin),
                            CGPoint(x: leftEndX, y: centerImageView.frame.midY + lineMargin)]
        batteryAnimationView = PathAnimationView(pointArray: batteryArray)
        self.layer.addSublayer(batteryAnimationView)
        
        let genArray = [CGPoint(x: centerImageView.frame.midX, y: genImageView.frame.maxY),
                        CGPoint(x: centerImageView.frame.midX, y: centerImageView.frame.minY - imageMargin)]
        genAnimationView = PathAnimationView(pointArray: genArray, isNeedMove: false)
        genAnimationView.lineStokeColor = UIColor(hex: 0xE0E0E0)
        self.layer.addSublayer(genAnimationView)
        
        let upsArray = [CGPoint(x: centerImageView.frame.midX, y: upsImageView.frame.minY),
                        CGPoint(x: centerImageView.frame.midX, y: centerImageView.frame.maxY + imageMargin)]
        upsAnimationView = PathAnimationView(pointArray: upsArray, isNeedMove: false)
        upsAnimationView.lineStokeColor = UIColor(hex: 0xE0E0E0)
        self.layer.addSublayer(upsAnimationView)
        
        let gridArray = [CGPoint(x: rightStartX, y: centerImageView.frame.midY - lineMargin),
                        CGPoint(x: rightSecondX, y: centerImageView.frame.midY - lineMargin),
                        CGPoint(x: rightSecondX, y: gridImageView.frame.midY),
                        CGPoint(x: rightEndX, y: gridImageView.frame.midY)]
        gridAnimationView = PathAnimationView(pointArray: gridArray, isDelayAnimation: true)
        self.layer.addSublayer(gridAnimationView)
        
        let smartArray = [CGPoint(x: rightStartX, y: smartImageView.frame.midY),
                        CGPoint(x: rightEndX, y: smartImageView.frame.midY)]
        smartAnimationView = PathAnimationView(pointArray: smartArray, isNeedMove: false)
        self.layer.addSublayer(smartAnimationView)
        
        let consArray = [CGPoint(x: rightStartX, y: centerImageView.frame.midY + lineMargin),
                        CGPoint(x: rightSecondX, y: centerImageView.frame.midY + lineMargin),
                        CGPoint(x: rightSecondX, y: consImageView.frame.midY),
                        CGPoint(x: rightEndX, y: consImageView.frame.midY)]
        consAnimationView = PathAnimationView(pointArray: consArray, isDelayAnimation: true)
        self.layer.addSublayer(consAnimationView)
        
        self.addSubview(batteryLabel)
        batteryLabel.snp.makeConstraints { make in
            make.centerX.equalTo(batteryImageView)
            make.bottom.equalTo(batteryImageView.snp_top)
        }
        
        self.addSubview(proInfoView)
        self.addSubview(genInfoView)
        self.addSubview(gridInfoView)
        self.addSubview(miInfoView)
        self.addSubview(smartInfoView)
        self.addSubview(batteryInfoView)
        self.addSubview(upsInfoView)
        self.addSubview(consInfoView)
        
        proInfoView.snp.makeConstraints { make in
            make.centerX.equalTo(proImageView)
            make.bottom.equalTo(proImageView.snp_top)
        }
        genInfoView.snp.makeConstraints { make in
            make.centerX.equalTo(genImageView)
            make.bottom.equalTo(genImageView.snp_top)
        }
        gridInfoView.snp.makeConstraints { make in
            make.centerX.equalTo(gridImageView)
            make.bottom.equalTo(gridImageView.snp_top)
        }
        miInfoView.snp.makeConstraints { make in
            make.centerX.equalTo(miImageView)
            make.top.equalTo(miImageView.snp_bottom)
        }
        smartInfoView.snp.makeConstraints { make in
            make.centerX.equalTo(smartImageView)
            make.top.equalTo(smartImageView.snp_bottom)
        }
        batteryInfoView.snp.makeConstraints { make in
            make.centerX.equalTo(batteryImageView)
            make.top.equalTo(batteryImageView.snp_bottom)
        }
        upsInfoView.snp.makeConstraints { make in
            make.centerX.equalTo(upsImageView)
            make.top.equalTo(upsImageView.snp_bottom)
        }
        consInfoView.snp.makeConstraints { make in
            make.centerX.equalTo(consImageView)
            make.top.equalTo(consImageView.snp_bottom)
        }
    }

    // MARK: UI
    private lazy var proInfoView: LoggerInfoView = {
        let infoView = LoggerInfoView("Production  ", "0.00kw")
        return infoView;
    }()
    private lazy var genInfoView: LoggerInfoView = {
        let infoView = LoggerInfoView("Generador  ", "0.00kw")
        return infoView;
    }()
    private lazy var gridInfoView: LoggerInfoView = {
        let infoView = LoggerInfoView("Grid  ", "0.00kw")
        return infoView;
    }()
    private lazy var miInfoView: LoggerInfoView = {
        let infoView = LoggerInfoView("Microinverter  ", "0.00kw")
        return infoView;
    }()
    private lazy var smartInfoView: LoggerInfoView = {
        let infoView = LoggerInfoView("SmartLoad  ", "0.00kw")
        return infoView;
    }()
    private lazy var batteryInfoView: LoggerInfoView = {
        let infoView = LoggerInfoView("Battery  ", "0.00kw")
        return infoView;
    }()
    private lazy var upsInfoView: LoggerInfoView = {
        let infoView = LoggerInfoView("Ups-Load  ", "0.00kw")
        return infoView;
    }()
    private lazy var consInfoView: LoggerInfoView = {
        let infoView = LoggerInfoView("Consumption  ", "0.00kw")
        return infoView;
    }()
    private lazy var batteryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor(0x333333)
        label.text = "80%"
        return label
    }()
    
    // MARK: Action
    func changeAction() {
        self.batteryLabel.text = "50%"
        self.proInfoView.content = "25.01kw"
        self.miAnimationView.addPathAnimation()
        self.proAnimationView.removePathAnimation()
        self.proAnimationView.lineStokeColor = UIColor.lightGray
    }
}

class LoggerInfoView: UIView {
    
    var content = "0.00kw" {
        didSet {
            let changeText = content.split(separator: ".").last ?? ""
            self.contentLabel.attributedText = ToolsHelper.changeTextSize(content, String(changeText), UIFont.systemFont(ofSize: 11))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ name: String, _ content: String) {
        self.init(frame: .zero)
        self.nameLabel.text = name
        self.contentLabel.text = content
        self.addSubview(nameLabel)
        self.addSubview(contentLabel)
        self.contentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(17)
        }
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentLabel.snp_bottom)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        let changeText = content.split(separator: ".").last ?? ""
        self.contentLabel.attributedText = ToolsHelper.changeTextSize(content, String(changeText), UIFont.systemFont(ofSize: 11))
    }

    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(0x333333)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(0x9999999)
        label.textAlignment = .center
        return label
    }()
}
