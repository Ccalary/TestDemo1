//
//  Test.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/5/17.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation
import UIKit

class Test: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        self.navigationItem.title = "测试"
        self.view.backgroundColor = UIColor.white
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 10, y: 10))
        path.addLine(to: CGPoint(x: 200, y: 200))
        path.stroke()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 2
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineDashPattern = [10, 10]
        self.view.layer.addSublayer(shapeLayer)
        
    }
}

