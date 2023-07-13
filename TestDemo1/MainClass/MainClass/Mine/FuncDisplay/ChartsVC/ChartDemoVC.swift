//
//  ChartDemoVC.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/22.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

@objc public class ChartDemoVC: UIViewController {
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        self.navigationItem.title = "ChartDemo"
        self.view.backgroundColor = UIColor.bgColorf2f2f2()
        
        let button = UIButton()
        button.backgroundColor = UIColor.fontColorBlue()
        button.addTarget(self, action: #selector(barAction), for: .touchUpInside)
        button.setTitle("Bar", for: .normal)
        self.view.addSubview(button)
        button.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        let lineButton = UIButton()
        lineButton.backgroundColor = UIColor.fontColorBlue()
        lineButton.addTarget(self, action: #selector(lineAction), for: .touchUpInside)
        lineButton.setTitle("Line", for: .normal)
        self.view.addSubview(lineButton)
        lineButton.snp.makeConstraints { make in
            make.width.height.centerX.equalTo(button)
            make.top.equalTo(button.snp_bottom).offset(50)
        }
        
        let lineWeekButton = UIButton()
        lineWeekButton.backgroundColor = UIColor.fontColorBlue()
        lineWeekButton.addTarget(self, action: #selector(lineWeekAction), for: .touchUpInside)
        lineWeekButton.setTitle("LineWeek", for: .normal)
        self.view.addSubview(lineWeekButton)
        lineWeekButton.snp.makeConstraints { make in
            make.width.height.centerX.equalTo(button)
            make.top.equalTo(lineButton.snp_bottom).offset(50)
        }
    }
    
    @objc func barAction() {
        self.navigationController?.pushViewController(ChartsBarVC(), animated: true)
    }
    
    @objc func lineAction() {
        self.navigationController?.pushViewController(ChartsLineVC(), animated: true)
    }
    
    @objc func lineWeekAction() {
        self.navigationController?.pushViewController(ChartsLineWeekVC(), animated: true)
    }
    
}
