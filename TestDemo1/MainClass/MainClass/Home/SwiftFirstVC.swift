//
//  SwiftFirstVC.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/3/21.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

@objc public class SwiftFirstVC: UIViewController {
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 83)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 1000)
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(loggerView)
        scrollView.addSubview(loggerMediumView)
        scrollView.addSubview(loggerSimpleView)

        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitle("Data", for: .normal)
        self.view.addSubview(button)
        button.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.top.equalTo(loggerSimpleView.snp_bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    lazy var loggerView: LoggerDataView = {
        let loggerView = LoggerDataView(frame: CGRect(x: 8, y: 0, width: self.view.frame.width - 16, height: 350))
        return loggerView
    }()
    
    lazy var loggerMediumView: LoggerDataMediumView = {
        let loggerView = LoggerDataMediumView(frame: CGRect(x: 8, y: 360, width: self.view.frame.width - 16, height: 350))
        return loggerView
    }()
    
    lazy var loggerSimpleView: LoggerDataSimpleView = {
        let loggerView = LoggerDataSimpleView(frame: CGRect(x: 8, y: 720, width: self.view.frame.width - 16, height: 140))
        return loggerView
    }()
    
    @objc func buttonAction() {
        self.loggerSimpleView.changeAction()
        self.loggerView.changeAction()
        self.loggerMediumView.changeAction()
    }
}
