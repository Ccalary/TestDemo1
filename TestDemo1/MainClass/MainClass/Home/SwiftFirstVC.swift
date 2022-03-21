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
        self.initView()
    }
    
    func initView() {
        let pointArray = [CGPoint(x: 50, y: 50), CGPoint(x: 100, y: 50), CGPoint(x: 100, y: 150), CGPoint(x: 150, y: 150)]
        let animationView = PathAnimation(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/2.0, height: 200), pointArray: pointArray)
        self.view.addSubview(animationView)
        
        let pointArray1 = [CGPoint(x: 150, y: 50), CGPoint(x: 100, y: 50), CGPoint(x: 100, y: 150), CGPoint(x: 50, y: 150)]
        let animationView1 = PathAnimation(frame: CGRect(x: self.view.frame.size.width/2.0, y: 0, width: self.view.frame.size.width/2.0, height: 200), pointArray: pointArray1, pathCornerRadius: 10)
        animationView1.animationDuration = 3
        animationView1.lineWidth = 3.0
        self.view.addSubview(animationView1)
    }
}
