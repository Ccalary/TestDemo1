//
//  LayoutView.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/24.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

class LayoutView: UIView {
    
    // 数据渲染器
    var renderer: LayoutDataRenderer!
    public internal(set) lazy var viewPortHandler = LayoutViewPortHandler(width: bounds.size.width, height: bounds.size.height)
    
    internal var _tapGestureRecognizer: UITapGestureRecognizer!
    internal var _pinchGestureRecognizer: UIPinchGestureRecognizer!
    internal var _panGestureRecognizer: UIPanGestureRecognizer!
    internal var _longPressGestureRecognizer: UILongPressGestureRecognizer!
        
    /// 记录最后拖拽的位置
    private var _lastPanPoint = CGPoint()
    /// 布局数据
    var data: LayoutData? {
        didSet {
            guard let data = data else {
                return
            }
            self.renderer.data = data
            notifyDataSetChanged()
        }
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    convenience init() {
        self.init(frame: .zero)
        self.backgroundColor = UIColor.clear
    }
    
    internal func initialize() {
        addObserver(self, forKeyPath: "bounds", options: .new, context: nil)
        addObserver(self, forKeyPath: "frame", options: .new, context: nil)
        
        renderer = LayoutDataRenderer(data: nil, viewPortHandler: viewPortHandler)
        
        _tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized(_:)))
        _longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized(_:)))
        _longPressGestureRecognizer.minimumPressDuration = 1
        _panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized(_:)))
        _pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureRecognized(_:)))
        
//        self.addGestureRecognizer(_tapGestureRecognizer)
//        self.addGestureRecognizer(_longPressGestureRecognizer)
//        self.addGestureRecognizer(_panGestureRecognizer)
//        self.addGestureRecognizer(_pinchGestureRecognizer)
    }
    
    deinit{
        removeObserver(self, forKeyPath: "bounds")
        removeObserver(self, forKeyPath: "frame")
    }
    
    // 布局更改监听
    public override func observeValue(forKeyPath keyPath: String?,
                                    of object: Any?,
                                    change: [NSKeyValueChangeKey : Any]?,
                                    context: UnsafeMutableRawPointer?) {
        
        if keyPath == "bounds" || keyPath == "frame" {
            let bounds = self.bounds
            if ((bounds.size.width != viewPortHandler.contentWidth ||
                bounds.size.height != viewPortHandler.contentHeight)) {
                viewPortHandler.setLayoutDimens(width: bounds.size.width, height: bounds.size.height)
                calculateSize()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        renderer.drawData(context: context)
        
    }
    
    /// 通知view，数据更改了
    private func notifyDataSetChanged() {
        
        calculateSize()
        
        setNeedsDisplay()
    }
    
    private func calculateSize() {
        guard let data = data else {
            return
        }
        let drawWidth = data.xMax - data.xMin
        let drawHeight = data.yMax - data.yMin
        
        let scale = min(viewPortHandler.resetWidth/drawWidth, viewPortHandler.resetHeight/drawHeight)
        
        var matrix = CGAffineTransform.identity
        matrix = matrix.translatedBy(x: -data.xMin*scale, y: -data.yMin*scale)
        matrix = matrix.scaledBy(x: scale, y: scale)// 缩放后左上角在(0,0)点位置
        
        let drawRect = CGRect(x: data.xMin, y: data.yMin, width: drawWidth, height: drawHeight).applying(matrix)
        /// 定位在中心区域
        matrix = matrix.translatedBy(x: (viewPortHandler.contentCenter.x - drawRect.midX)/scale, y: (viewPortHandler.contentCenter.y - drawRect.midY)/scale)
    
        _ = viewPortHandler.refresh(newMatrix: matrix, layout: self)
    }
    
    @objc private func tapGestureRecognized(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .began {
           print("tapGestureRecognized-begin")
        }else if recognizer.state == .changed {
            print("tapGestureRecognized-changed")
        }else if recognizer.state == .ended {
            print("tapGestureRecognized-ended")
        }
        
        let point = recognizer.location(in: self)
        print("tapPoint:\(point)")
        
        let highlight = getHighlightByTouchPoint(point)
        
    }
    
    @objc private func longPressGestureRecognized(_ recognizer: UILongPressGestureRecognizer) {
        let location = recognizer.location(in: self)
        if recognizer.state == .began {
            print("longPressGestureRecognized-began")
            viewPortHandler.updateLongPressPoint(newPoint: location, layout: self)
        }else if recognizer.state == .changed {
            print("longPressGestureRecognized-changed")
        }else if recognizer.state == .ended {
            print("longPressGestureRecognized-ended")
        }
        print("longPress:\(location)")
    }
    
    @objc private func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
        print("panGestureRecognized")
        if recognizer.state == .began {
            _lastPanPoint = recognizer.translation(in: self)
        }else if recognizer.state == .changed {
            let originalTranslation = recognizer.translation(in: self)
            let translation = CGPoint(x: originalTranslation.x - _lastPanPoint.x, y: originalTranslation.y - _lastPanPoint.y)
            let _ = performPanChange(translation: translation)
            
            _lastPanPoint = originalTranslation
        }
    }
    
    @objc private func pinchGestureRecognized(_ recognizer: UIPinchGestureRecognizer) {
        if recognizer.state == .began {
           print("pinchGestureRecognized-begin")
        }else if recognizer.state == .changed {
            print("pinchGestureRecognized-changed")
            
            let location = recognizer.location(in: self)
            print("pinchPoint:\(location), scale:\(recognizer.scale)")
    
            /// 是否是放大
//            let isZoomingOut = (recognizer.scale < 1)
            
            let scale = recognizer.scale
            
            /// 先偏移然后变换，最后再复位
            var matrix = CGAffineTransform(translationX: location.x, y: location.y)
                        .scaledBy(x: scale, y: scale)
                        .translatedBy(x: -location.x, y: -location.y)
            /*
             用来让 CGAffineTransform实例 关联我们指定的 CGAffineTransform 实例
             通过关联我们上次变换后的CGAffineTransform实例, 就可以实现每次都在上次变换的基础上再进行变换
             其实是向量相乘
             Concatenate `t2' to `t1' and return the result:
             t' = t1 * t2
             */
            matrix = viewPortHandler.touchMatrix.concatenating(matrix)
                    
            _ = viewPortHandler.refresh(newMatrix: matrix, layout: self)
            /// 设置后每次会按照新的比例开始
            recognizer.scale = 1
            
        }else if recognizer.state == .ended {
            print("pinchGestureRecognized-ended")
        }
        
    }
    
    // 平移操作
    private func performPanChange(translation: CGPoint) -> Bool {
        
        let originalMatrix = viewPortHandler.touchMatrix
        
        var matrix = CGAffineTransform(translationX: translation.x, y: translation.y)
        matrix = originalMatrix.concatenating(matrix)
        matrix = viewPortHandler.refresh(newMatrix: matrix, layout: self)
        
        // 是否进行了平移操作
        return matrix.tx != originalMatrix.tx || matrix.ty != originalMatrix.ty
    }
    
    private func getHighlightByTouchPoint(_ point: CGPoint) -> LayoutHighlight? {

        guard let dataSets = data?.dataSets else {
            return nil
        }
        
        /// 倒序遍历
        for i in (dataSets.count-1)...0 {
            let dataSet = dataSets[i]
            let matrix = LayoutUtils.rectRotated(angle: dataSet.angle, anchorPoint: CGPoint(x: dataSet.rect.midX, y: dataSet.rect.midY)).concatenating(viewPortHandler.touchMatrix)
            
            let topLeftPoint = dataSet.rect.origin
            let topRightPoint = CGPoint(x: topLeftPoint.x + dataSet.rect.width, y: topLeftPoint.y)
            let bottomLeftPoint = CGPoint(x: topLeftPoint.x, y: topLeftPoint.y + dataSet.rect.height)
            let bottomRightPoint = CGPoint(x: topRightPoint.x , y: bottomLeftPoint.y)
            
            let isContains = point.isInPolygon([topLeftPoint.applying(matrix), topRightPoint.applying(matrix), bottomRightPoint.applying(matrix), bottomLeftPoint.applying(matrix)])
            
            if (isContains) {
                return LayoutHighlight(dataSetIndex: i)
            }
        }
        return nil
    }
}
