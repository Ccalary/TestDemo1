//
//  FlowLegendRenderer.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/13.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import UIKit
import CoreGraphics

class FlowLegendRenderer {
    
    weak var layer: CALayer?
    var legend: FlowLegend?
    let viewPortHandler: FlowViewPortHandler
    private var animationLayer = FlowPathAnimationLayer()
    
    public init(layer: CALayer, viewPortHandler: FlowViewPortHandler, legend: FlowLegend?) {
        self.layer = layer
        self.viewPortHandler = viewPortHandler
        self.legend = legend
        self.layer?.addSublayer(animationLayer)
    }
    
    convenience init(layer: CALayer, viewPortHandler: FlowViewPortHandler) {
        self.init(layer: layer, viewPortHandler: viewPortHandler, legend: nil)
    }

    open func computeLegend() {
        guard let legend = legend else {
            return
        }
    
        // 计算中心点位置
        switch legend.position {
            case .topLeft:
                legend.centerPoint = CGPoint(x: viewPortHandler.offsetLeft + legend.iconSize/2.0,
                                             y: viewPortHandler.offsetTop + legend.iconSize/2.0)
            case .topCenter:
                legend.centerPoint = CGPoint(x: viewPortHandler.contentCenter.x,
                                             y: viewPortHandler.offsetTop + legend.iconSize/2.0)
            case .topRight:
                legend.centerPoint = CGPoint(x: viewPortHandler.contentWidth - viewPortHandler.offsetRight - legend.iconSize/2.0,
                                             y: viewPortHandler.offsetTop + legend.iconSize/2.0)
            case .centerLeft:
                legend.centerPoint = CGPoint(x: viewPortHandler.offsetLeft + legend.iconSize/2.0,
                                             y: viewPortHandler.contentCenter.y)
            case .center:
                legend.centerPoint = viewPortHandler.contentCenter
            case .centerRight:
                legend.centerPoint = CGPoint(x: viewPortHandler.contentWidth - viewPortHandler.offsetRight - legend.iconSize/2.0,
                                             y: viewPortHandler.contentCenter.y)
            case .bottomLeft:
                legend.centerPoint = CGPoint(x: viewPortHandler.offsetLeft + legend.iconSize/2.0,
                                             y: viewPortHandler.contentHeight - viewPortHandler.offsetBottom - legend.iconSize/2.0)
            case .bottomCenter:
                legend.centerPoint = CGPoint(x: viewPortHandler.contentCenter.x,
                                             y:  viewPortHandler.contentHeight - viewPortHandler.offsetBottom - legend.iconSize/2.0)
            case .bottomRight:
                legend.centerPoint = CGPoint(x: viewPortHandler.contentWidth - viewPortHandler.offsetRight - legend.iconSize/2.0,
                                             y: viewPortHandler.contentHeight - viewPortHandler.offsetBottom - legend.iconSize/2.0)
        }
    }
    
    open func renderLegend(context: CGContext) {
        guard let legend = legend,
              let currentImage = UIImage(named: legend.entry.iconName) else {
            return
        }
        context.saveGState()
        defer { context.restoreGState() }
        
        // 中心点绘制
        if legend.position == .center {
            let imageRect = CGRect(x: legend.centerPoint.x - viewPortHandler.contentCenterIconSize.width/2.0,
                                   y: legend.centerPoint.y - viewPortHandler.contentCenterIconSize.height/2.0,
                                   width: viewPortHandler.contentCenterIconSize.width,
                                   height: viewPortHandler.contentCenterIconSize.height)
            currentImage.draw(in: imageRect)
        }else {
            let imageRect = CGRect(x: legend.centerPoint.x - legend.iconSize/2.0,
                                   y: legend.centerPoint.y - legend.iconSize/2.0,
                                   width: legend.iconSize,
                                   height: legend.iconSize)
            currentImage.draw(in: imageRect)
            
            // draw text
            let nameText = legend.entry.name
            let nameAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                NSAttributedString.Key.foregroundColor: UIColor("#999999")
            ]
            let nameTextSize = nameText.size(withAttributes: nameAttributes)
            
            // 小数点前面文字大写处理
            let valueText = legend.entry.value + legend.entry.unit
            let valueArray = valueText.split(separator: ".")
            
            let firstValue = String(valueArray.first ?? "0") + "."
            let firstValueAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .medium),
                NSAttributedString.Key.foregroundColor: UIColor("#39414A")
            ]
            let firstValueTextSize = firstValue.size(withAttributes: firstValueAttributes)
            
            let lastValue = String(valueArray.last ?? "0")
            let lastValueAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: .medium),
                NSAttributedString.Key.foregroundColor: UIColor("#39414A")
            ]
            let lastValueTextSize = lastValue.size(withAttributes: lastValueAttributes)
            
            // subValue
            let subValue = legend.entry.subValue
            let subValueAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: .medium),
                NSAttributedString.Key.foregroundColor: UIColor("#333333")
            ]
            let subValueTextSize = subValue.size(withAttributes: subValueAttributes)
            
            var namePoint = CGPoint.zero
            var firstValuePoint = CGPoint.zero
            // 和名称的位置相反
            var subValuePoint = CGPoint.zero
            
            switch legend.textPosition {
                case .top:
                    namePoint = CGPoint(x: legend.centerPoint.x - nameTextSize.width/2.0,
                                        y: imageRect.minY - nameTextSize.height/2.0 - 2)
                    firstValuePoint = CGPoint(x: legend.centerPoint.x - (firstValueTextSize.width + lastValueTextSize.width)/2.0,
                                              y: namePoint.y - firstValueTextSize.height)
                    subValuePoint = CGPoint(x: legend.centerPoint.x - subValueTextSize.width/2.0,
                                            y: imageRect.maxY + 2)
                case .bottom:
                    firstValuePoint = CGPoint(x: legend.centerPoint.x - (firstValueTextSize.width + lastValueTextSize.width)/2.0,
                                              y: imageRect.maxY + 2)
                    namePoint = CGPoint(x: legend.centerPoint.x - nameTextSize.width/2.0,
                                        y: firstValuePoint.y + firstValueTextSize.height)
                    subValuePoint = CGPoint(x: legend.centerPoint.x - subValueTextSize.width/2.0,
                                        y: imageRect.minY - subValueTextSize.height/2.0 - 4)
            }
            
            let lastValuePoint = CGPoint(x: firstValuePoint.x + firstValueTextSize.width,
                                         y: firstValuePoint.y + (firstValueTextSize.height - lastValueTextSize.height) - 1)
            
            (nameText as NSString).draw(at: namePoint,
                                        withAttributes: nameAttributes)
            (firstValue as NSString).draw(at: firstValuePoint,
                                          withAttributes: firstValueAttributes)
            (lastValue as NSString).draw(at: lastValuePoint,
                                         withAttributes: lastValueAttributes)
            (subValue as NSString).draw(at: subValuePoint,
                                         withAttributes: subValueAttributes)
        
            self.addAnimationLayer()
        }
    }
    
    // 动画
    func addAnimationLayer() {
        guard let legend = legend else {
            return
        }
        var pointArray = [CGPoint]()
        switch legend.position {
        case .topLeft:
            switch legend.flowPathType {
                case .normal:
                    let startPoint = CGPoint(x: legend.centerPoint.x + legend.iconSize/2.0,
                                             y: legend.centerPoint.y)
                    let endPoint = CGPoint(x: viewPortHandler.centerIconLeft - viewPortHandler.centerIconMargin,
                                       y: viewPortHandler.contentCenter.y - viewPortHandler.lineMargin)
                    pointArray = [startPoint,
                                  CGPoint(x: (startPoint.x + endPoint.x)/2.0, y: startPoint.y),
                                  CGPoint(x: (startPoint.x + endPoint.x)/2.0, y: endPoint.y),
                                  endPoint]
                case .simple:
                    let startPoint = CGPoint(x: legend.centerPoint.x,
                                             y: legend.centerPoint.y + legend.iconSize/2.0)
                    let endPoint = CGPoint(x: viewPortHandler.centerIconLeft - viewPortHandler.centerIconMargin,
                                           y: viewPortHandler.contentCenter.y)
                    pointArray = [startPoint,
                                  CGPoint(x: startPoint.x, y: endPoint.y),
                                  endPoint]
                    break
            }
        case .topCenter:
            let startPoint = CGPoint(x: legend.centerPoint.x,
                                     y: legend.centerPoint.y + legend.iconSize/2.0)
            let endPoint = CGPoint(x: legend.centerPoint.x,
                                   y: viewPortHandler.centerIconTop - viewPortHandler.centerIconMargin)
            pointArray = [startPoint, endPoint]
        case .topRight:
            switch legend.flowPathType {
                case .normal:
                    let startPoint = CGPoint(x: legend.centerPoint.x - legend.iconSize/2.0,
                                             y: legend.centerPoint.y)
                    let endPoint = CGPoint(x: viewPortHandler.centerIconRight + viewPortHandler.centerIconMargin,
                                           y: viewPortHandler.contentCenter.y - viewPortHandler.lineMargin)
                    pointArray = [startPoint,
                                  CGPoint(x: (startPoint.x + endPoint.x)/2.0, y: startPoint.y),
                                  CGPoint(x: (startPoint.x + endPoint.x)/2.0, y: endPoint.y),
                                  endPoint]
                case .simple:
                    let startPoint = CGPoint(x: legend.centerPoint.x,
                                             y: legend.centerPoint.y + legend.iconSize/2.0)
                    let endPoint = CGPoint(x: viewPortHandler.centerIconRight + viewPortHandler.centerIconMargin,
                                           y: viewPortHandler.contentCenter.y)
                    pointArray = [startPoint,
                                  CGPoint(x: startPoint.x, y: endPoint.y),
                                  endPoint]
                }
        case .centerLeft:
            let startPoint = CGPoint(x: legend.centerPoint.x + legend.iconSize/2.0,
                                     y: legend.centerPoint.y)
            let endPoint = CGPoint(x: viewPortHandler.centerIconLeft - viewPortHandler.centerIconMargin,
                                   y: viewPortHandler.contentCenter.y)
            pointArray = [startPoint, endPoint]
        case .center:
            break
        case .centerRight:
            let startPoint = CGPoint(x: legend.centerPoint.x - legend.iconSize/2.0,
                                     y: legend.centerPoint.y)
            let endPoint = CGPoint(x: viewPortHandler.centerIconRight + viewPortHandler.centerIconMargin,
                                   y: viewPortHandler.contentCenter.y)
            pointArray = [startPoint, endPoint]
        case .bottomLeft:
            switch legend.flowPathType {
                case .normal:
                    let startPoint = CGPoint(x: legend.centerPoint.x + legend.iconSize/2.0,
                                             y: legend.centerPoint.y)
                    let endPoint = CGPoint(x: viewPortHandler.centerIconLeft - viewPortHandler.centerIconMargin,
                                           y: viewPortHandler.contentCenter.y + viewPortHandler.lineMargin)
                    pointArray = [startPoint,
                                  CGPoint(x: (startPoint.x + endPoint.x)/2.0, y: startPoint.y),
                                  CGPoint(x: (startPoint.x + endPoint.x)/2.0, y: endPoint.y),
                                  endPoint]
                case .simple:
                    let startPoint = CGPoint(x: legend.centerPoint.x,
                                             y: legend.centerPoint.y - legend.iconSize/2.0)
                    let endPoint = CGPoint(x: viewPortHandler.centerIconLeft - viewPortHandler.centerIconMargin,
                                           y: viewPortHandler.contentCenter.y)
                    pointArray = [startPoint,
                                  CGPoint(x: startPoint.x, y: endPoint.y),
                                  endPoint]
                }
        case .bottomCenter:
            let startPoint = CGPoint(x: legend.centerPoint.x,
                                     y: legend.centerPoint.y - legend.iconSize/2.0)
            let endPoint = CGPoint(x: legend.centerPoint.x,
                                   y: viewPortHandler.centerIconBottom + viewPortHandler.centerIconMargin)
            pointArray = [startPoint, endPoint]
        case .bottomRight:
            switch legend.flowPathType {
                case .normal:
                    let startPoint = CGPoint(x: legend.centerPoint.x - legend.iconSize/2.0,
                                             y: legend.centerPoint.y)
                    let endPoint = CGPoint(x: viewPortHandler.centerIconRight + viewPortHandler.centerIconMargin,
                                           y: viewPortHandler.contentCenter.y + viewPortHandler.lineMargin)
                    pointArray = [startPoint,
                                  CGPoint(x: (startPoint.x + endPoint.x)/2.0, y: startPoint.y),
                                  CGPoint(x: (startPoint.x + endPoint.x)/2.0, y: endPoint.y),
                                  endPoint]
                case .simple:
                    let startPoint = CGPoint(x: legend.centerPoint.x,
                                             y: legend.centerPoint.y - legend.iconSize/2.0)
                    let endPoint = CGPoint(x: viewPortHandler.centerIconRight + viewPortHandler.centerIconMargin,
                                           y: viewPortHandler.contentCenter.y)
                    pointArray = [startPoint,
                                  CGPoint(x: startPoint.x, y: endPoint.y),
                                  endPoint]
                }
        }
        
        // 反转
        if legend.flowDirection == .reverse {
            pointArray = pointArray.reversed()
        }
        self.animationLayer.moveEnable = legend.flowEnable
        self.animationLayer.lineStokeColor = legend.flowEnable ? UIColor("#D8E1F2") : UIColor("#E0E0E0")
        
        self.animationLayer.pointArray = pointArray
        self.animationLayer.refreshLayer()
    }
}
