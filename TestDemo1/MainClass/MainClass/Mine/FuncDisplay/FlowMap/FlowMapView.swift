//
//  LoggerView.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/12.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class FlowMapView: UIView {
    
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
        self.backgroundColor = UIColor.white
        self.initRenders()
    }
    
    internal func initialize() {
        addObserver(self, forKeyPath: "bounds", options: .new, context: nil)
        addObserver(self, forKeyPath: "frame", options: .new, context: nil)
    }
    
    deinit{
        removeObserver(self, forKeyPath: "bounds")
        removeObserver(self, forKeyPath: "frame")
    }
    
    func initRenders() {
        self.legendRenders.removeAll()
        for _ in 0..<9 {
            let render = FlowLegendRenderer(layer:self.layer, viewPortHandler: viewPortHandler)
            self.legendRenders.append(render)
        }
    }
    
    open internal(set) lazy var viewPortHandler = FlowViewPortHandler(width: bounds.size.width, height: bounds.size.height)
    
    var legendRenders: [FlowLegendRenderer] = [FlowLegendRenderer]()
    
    var dataSets: [FlowLegend] = [FlowLegend]() {
        didSet {
            dataSets.forEach { legend in
                if self.legendRenders.count > legend.position.rawValue {
                    self.legendRenders[legend.position.rawValue].legend = legend
                }
            }
            notifyDataSetChanged()
        }
    }
    
    override func draw(_ rect: CGRect) {
    
        let optionalContext = UIGraphicsGetCurrentContext()
        guard let context = optionalContext else {
            return
        }
        self.legendRenders.forEach { render in
            render.renderLegend(context: context)
        }
    }
    
    // 布局更改监听
    open override func observeValue(forKeyPath keyPath: String?,
                                    of object: Any?,
                                    change: [NSKeyValueChangeKey : Any]?,
                                    context: UnsafeMutableRawPointer?) {
        
        if keyPath == "bounds" || keyPath == "frame" {
            let bounds = self.bounds
            if ((bounds.size.width != viewPortHandler.contentWidth ||
                bounds.size.height != viewPortHandler.contentHeight)) {
                viewPortHandler.setFlowMapDimens(width: bounds.size.width, height: bounds.size.height)
                notifyDataSetChanged()
            }
        }
    }
    
    // 数据更改
    func notifyDataSetChanged() {
        
        self.legendRenders.forEach { render in
            render.computeLegend()
        }
        setNeedsDisplay()
    }
}
