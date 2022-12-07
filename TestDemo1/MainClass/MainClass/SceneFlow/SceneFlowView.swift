//
//  SceneFlowView.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/12/7.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

class SceneFlowView: UIView {
    
    let UIRate = UIScreen.main.bounds.width/375.0
    /// 流动线距离两端的间隔
    public var lineMargin = 4.0
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init() {
        self.init(frame: .zero)
        self.backgroundColor = UIColor.white
        self.initView()
    }
    
    func initView() {
        
        self.addSubview(topImageView)
        topImageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(182*UIRate)
        }
        
        self.addSubview(bottomImageView)
        bottomImageView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(topImageView.snp_bottom)
        }
        
        /// DC/AC
        self.addSubview(dcAcImageView)
        dcAcImageView.snp.makeConstraints { make in
            make.width.height.equalTo(37*UIRate)
            make.centerX.equalToSuperview()
            make.top.equalTo(bottomImageView).offset(35*UIRate)
        }
        
        /// 发电
        self.addSubview(generationImageView)
        generationImageView.snp.makeConstraints { make in
            make.width.height.equalTo(37*UIRate)
            make.left.equalToSuperview().offset(25*UIRate)
            make.bottom.equalTo(topImageView.snp_bottom).offset(-40*UIRate)
        }
        
        generationTitleLabel.text = "发电"
        self.addSubview(generationTitleLabel)
        generationTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(generationImageView)
            make.bottom.equalTo(generationImageView.snp_top).offset(-4*UIRate)
        }
        
        generationContentLabel.text = "0kW"
        self.addSubview(generationContentLabel)
        generationContentLabel.snp.makeConstraints { make in
            make.centerX.equalTo(generationImageView)
            make.bottom.equalTo(generationTitleLabel.snp_top).offset(-2*UIRate)
        }
        
        /// 房子
        self.addSubview(houseImageView)
        houseImageView.snp.makeConstraints { make in
            make.width.equalTo(154*UIRate)
            make.height.equalTo(87*UIRate)
            make.left.equalToSuperview().offset(84*UIRate)
            make.bottom.equalTo(topImageView.snp_bottom)
        }
        
        /// 电网
        self.addSubview(gridImageView)
        gridImageView.snp.makeConstraints { make in
            make.width.equalTo(36*UIRate)
            make.height.equalTo(50*UIRate)
            make.right.equalToSuperview().offset(-25*UIRate)
            make.bottom.equalTo(topImageView.snp_bottom)
        }
        
        gridTitleLabel.text = "电网"
        self.addSubview(gridTitleLabel)
        gridTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(gridImageView)
            make.bottom.equalTo(gridImageView.snp_top).offset(-4*UIRate)
        }
        
        gridContentLabel.text = "0kW"
        self.addSubview(gridContentLabel)
        gridContentLabel.snp.makeConstraints { make in
            make.centerX.equalTo(gridImageView)
            make.bottom.equalTo(gridTitleLabel.snp_top).offset(-2*UIRate)
        }
        
        /// 储能
        self.addSubview(energyImageView)
        energyImageView.snp.makeConstraints { make in
            make.width.equalTo(30*UIRate)
            make.height.equalTo(28*UIRate)
            make.right.equalTo(gridImageView.snp_left).offset(-30*UIRate)
            make.bottom.equalTo(topImageView.snp_bottom)
        }
        
        energyTitleLabel.text = "储能"
        self.addSubview(energyTitleLabel)
        energyTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(energyImageView)
            make.bottom.equalTo(energyImageView.snp_top).offset(-4*UIRate)
        }
        
        energyContentLabel.text = "0kW"
        self.addSubview(energyContentLabel)
        energyContentLabel.snp.makeConstraints { make in
            make.centerX.equalTo(energyImageView)
            make.bottom.equalTo(energyTitleLabel.snp_top).offset(-2*UIRate)
        }
        
        /// 执行后获取真实布局数据
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.initFlowView()
        }
    }
    
    func initFlowView() {
        
        let generationPointArray = [CGPoint(x: CGRectGetMinX(self.dcAcImageView.frame) - lineMargin*UIRate, y: self.dcAcImageView.center.y), CGPoint(x: self.generationImageView.center.x, y: self.dcAcImageView.center.y), CGPoint(x: self.generationImageView.center.x, y: CGRectGetMaxY(self.generationImageView.frame) + lineMargin*UIRate)]
        let generationPathLayer = SceneFlowPathLayer(pointArray: generationPointArray)
        self.layer.addSublayer(generationPathLayer)
        
        let generationHousePointArray = [CGPoint(x: CGRectGetMaxX(self.generationImageView.frame) + lineMargin*UIRate, y: self.generationImageView.center.y), CGPoint(x: CGRectGetMaxX(self.generationImageView.frame) + lineMargin*UIRate + 36*UIRate, y: self.generationImageView.center.y)]
        let generationHousePathLayer = SceneFlowPathLayer(pointArray: generationHousePointArray)
        self.layer.addSublayer(generationHousePathLayer)
        
        let housePointArray = [CGPoint(x: self.dcAcImageView.center.x, y: CGRectGetMinY(self.dcAcImageView.frame) - lineMargin*UIRate), CGPoint(x: self.dcAcImageView.center.x, y: CGRectGetMaxY(self.houseImageView.frame) + lineMargin*UIRate)]
        let housePathLayer = SceneFlowPathLayer(pointArray: housePointArray)
        self.layer.addSublayer(housePathLayer)
        
        let energyPointArray = [CGPoint(x: CGRectGetMaxX(self.dcAcImageView.frame) + lineMargin*UIRate, y: self.dcAcImageView.center.y), CGPoint(x: self.energyImageView.center.x, y: self.dcAcImageView.center.y), CGPoint(x: self.energyImageView.center.x, y: CGRectGetMaxY(self.energyImageView.frame) + lineMargin*UIRate)]
        let energyPathLayer = SceneFlowPathLayer(pointArray: energyPointArray)
        self.layer.addSublayer(energyPathLayer)
        
        let gridPointArray = [CGPoint(x: CGRectGetMaxX(self.dcAcImageView.frame) + lineMargin*UIRate, y: self.dcAcImageView.center.y), CGPoint(x: self.gridImageView.center.x, y: self.dcAcImageView.center.y), CGPoint(x: self.gridImageView.center.x, y: CGRectGetMaxY(self.gridImageView.frame) + lineMargin*UIRate)]
        let gridPathLayer = SceneFlowPathLayer(pointArray: gridPointArray)
        self.layer.addSublayer(gridPathLayer)
        
    }
    
    /* 顶部图片 */
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "scene_ground_front"))
        return imageView
    }()
    
    /* 底部图片 */
    private lazy var bottomImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "scene_ground_back"))
        return imageView
    }()
    
    /* dcac */
    private lazy var dcAcImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "scene_dcac"))
        return imageView
    }()
    
    /* 发电 */
    private lazy var generationImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "scene_generation"))
        return imageView
    }()
    
    /* 发电-title */
    private lazy var generationTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor("#123766")
        label.font = UIFont.systemFont(ofSize: 11*UIRate)
        return label
    }()
    
    /* 发电-content */
    private lazy var generationContentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor("#123766")
        label.font = UIFont.systemFont(ofSize: 14*UIRate)
        return label
    }()
    
    /* 房子 */
    private lazy var houseImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "scene_house"))
        return imageView
    }()
    
    /* 电网 */
    private lazy var gridImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "scene_grid"))
        return imageView
    }()
    
    /* 电网-title */
    private lazy var gridTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor("#123766")
        label.font = UIFont.systemFont(ofSize: 11*UIRate)
        return label
    }()
    
    /* 电网-content */
    private lazy var gridContentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor("#123766")
        label.font = UIFont.systemFont(ofSize: 14*UIRate)
        return label
    }()
    
    /* 储能 */
    private lazy var energyImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "scene_energy"))
        return imageView
    }()
    
    /* 储能-title */
    private lazy var energyTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor("#123766")
        label.font = UIFont.systemFont(ofSize: 11*UIRate)
        return label
    }()
    
    /* 储能-content */
    private lazy var energyContentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor("#123766")
        label.font = UIFont.systemFont(ofSize: 14*UIRate)
        return label
    }()
}
