//
//  CGDemoVC.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/6.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

class CGDemoVC: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    func initView() {
        self.navigationItem.title = "CoreGraphics"
        self.view.backgroundColor = UIColor.bgColorf2f2f2()
        
        let cgView = CGView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        cgView.backgroundColor = UIColor.gray
        self.view.addSubview(cgView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.setNeedsDisplay()
        self.view.layoutIfNeeded()
    }
}

class CGView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        print("draw")
        // 获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
//        context.saveGState()
//        context.rotate(by: CGFloat.pi/18)
//        context.scaleBy(x: 0.2, y: 0.4)
        // 创建绘制区域
        let drawRect = CGRect(x: 50, y: 50, width: 100, height: 100)
        let drawRect2 = CGRect(x: 160, y: 50, width: 100, height: 100)
//        path.addRect(drawRect)
//        let path = CGMutablePath()
//        path.move(to: CGPoint(x: drawRect.minX, y: drawRect.minY))
//        path.addLine(to: CGPoint(x: drawRect.maxX, y: drawRect.maxY))
//        context.addPath(path)
//        context.addRect(drawRect)
//        context.setStrokeColor(UIColor.blue.cgColor)
//        context.strokePath()
//        context.setFillColor(UIColor.blue.cgColor)
//        context.fillPath()
    
        context.clip(to: [drawRect, drawRect2])
        
        
        
//        context.restoreGState()
        
        let text = "IGEN"
        
        
        let style = NSMutableParagraphStyle()
        style.alignment = .center
                   
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.red,
            NSAttributedString.Key.paragraphStyle: style
        ]
//        (text as NSString).draw(in: drawRect, withAttributes: attributes)
        
        context.drawText(text, at: CGPoint(x: 50, y: 50), align: .center, attributes: attributes)
    }
    
    /*
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        print("draw")
        // 获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
 
        
//        context.saveGState()
//        context.rotate(by: CGFloat.pi/18)
//        context.scaleBy(x: 0.2, y: 0.4)
        // 创建绘制区域
        let drawRect = CGRect(x: 50, y: 50, width: 100, height: 100)
//        path.addRect(drawRect)
//        let path = CGMutablePath()
//        path.move(to: CGPoint(x: drawRect.minX, y: drawRect.minY))
//        path.addLine(to: CGPoint(x: drawRect.maxX, y: drawRect.maxY))
//        context.addPath(path)
//        context.addRect(drawRect)
//        context.setStrokeColor(UIColor.blue.cgColor)
//        context.strokePath()
//        context.setFillColor(UIColor.red.cgColor)
//        context.fillPath()
    
//        context.restoreGState()
        
        let text = "IGEN"
        
        
        let style = NSMutableParagraphStyle()
        style.alignment = .center
                   
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.red,
            NSAttributedString.Key.paragraphStyle: style
        ]
        (text as NSString).draw(in: drawRect, withAttributes: attributes)
    }
     */
}
