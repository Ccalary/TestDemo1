//
//  AutolayoutDemo.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/4.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation
import UIKit

class AutoLayoutDemo: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let redView = UIView()
        redView.backgroundColor = UIColor.red
        
        let blueView = UIView()
        blueView.backgroundColor = UIColor.blue
        
        let yellowView = UIView()
        yellowView.backgroundColor = UIColor.yellow
        
        self.view.addSubview(redView)
        self.view.addSubview(blueView)
        self.view.addSubview(yellowView)
        
        redView.translatesAutoresizingMaskIntoConstraints = false
        blueView.translatesAutoresizingMaskIntoConstraints = false
        yellowView.translatesAutoresizingMaskIntoConstraints = false
        
        let redViewTopToSuperViewTop = NSLayoutConstraint(item: redView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 30)
        let redViewLeftToSuperViewLeft = NSLayoutConstraint(item: redView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 15)
        
        let redViewRightToSuperRight = NSLayoutConstraint(item: redView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: -15)
        
        let redViewHeight = NSLayoutConstraint(item: redView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 100)
        
        self.view.addConstraints([redViewTopToSuperViewTop, redViewLeftToSuperViewLeft, redViewRightToSuperRight, redViewHeight])
        
        self.view.layoutIfNeeded()
    }
}
