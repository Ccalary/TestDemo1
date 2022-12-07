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
            make.height.equalTo(270)
        }
    }
}
