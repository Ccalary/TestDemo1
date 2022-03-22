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
        
//        let pointArray = [CGPoint(x: 50, y: 50),
//                            CGPoint(x: 100, y: 50),
//                            CGPoint(x: 100, y: 100),
//                            CGPoint(x: 150, y: 100)]
//        let animationView = PathAnimationView(pointArray: pointArray)
//        self.view.addSubview(animationView)
        
        
        self.initLoggerView()
        
    }
    
    func initLoggerView() {
        let loggerView = LoggerDataView(frame: CGRect(x: 8, y: 0, width: self.view.frame.width - 16, height: 350))
        self.view.addSubview(loggerView)
    }
}
