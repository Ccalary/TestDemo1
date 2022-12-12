//
//  SceneFlowVC.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/12/7.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

class SceneFlowVC: UIViewController {
    
    let sceneFlowView = SceneFlowView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        self.navigationItem.title = "场景流动图"
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(sceneFlowView)
        sceneFlowView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(300)
        }
        
        let button = UIButton()
        button.setTitle("刷新", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(refreshAction), for: .touchUpInside)
        self.view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(sceneFlowView.snp_bottom)
            make.centerX.equalTo(sceneFlowView)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
    }
    
    @objc func refreshAction() {
        
    }
}
