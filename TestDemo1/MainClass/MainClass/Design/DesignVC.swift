//
//  Mode.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/12/8.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

class DesignVC: UIViewController {
    
    var contentLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    func initView() {
        self.navigationItem.title = "模式"
        self.view.backgroundColor = UIColor.white
    
        let startBtn = UIButton()
        startBtn.setTitle("Start", for: .normal)
        startBtn.backgroundColor = UIColor.main()
        startBtn.addTarget(self, action: #selector(startAction), for: .touchUpInside)
        self.view.addSubview(startBtn)
        startBtn.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(45)
            make.bottom.equalToSuperview().offset(-100)
            make.centerX.equalToSuperview()
        }
        
        contentLabel.numberOfLines = 0
        self.view.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
    }
    
    @objc func startAction() {
        print("开始计算")
        let content = Calculator().start()
        contentLabel.text = "计算器\n\n\(content)"
    }
}
