//
//  ChartLineVC.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/3/24.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation
import Charts

@objc public class ChartsLineVC: UIViewController {
    
    private var chartView = LineChartView()
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let lineChartView = LineChartView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400))
        view.addSubview(lineChartView)
        self.chartView = lineChartView
        
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(normalButtonAction), for: .touchUpInside)
        button.setTitle("Normal", for: .normal)
        self.view.addSubview(button)
        button.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.top.equalTo(lineChartView.snp_bottom).offset(50)
            make.right.equalTo(self.view.snp_centerX).offset(-20)
        }
        
        let groupButton = UIButton()
        groupButton.backgroundColor = UIColor.blue
        groupButton.addTarget(self, action: #selector(groupButtonAction), for: .touchUpInside)
        groupButton.setTitle("Group", for: .normal)
        self.view.addSubview(groupButton)
        groupButton.snp.makeConstraints { make in
            make.width.height.centerY.equalTo(button)
            make.left.equalTo(self.view.snp_centerX).offset(20)
        }
        
        // 禁止双击手势
        lineChartView.doubleTapToZoomEnabled = false
        // 禁止y轴缩放
        lineChartView.scaleYEnabled = false
        // 是否绘制图表边框，绘制后就不需要绘制x轴和y轴的轴线了。默认false
        lineChartView.drawBordersEnabled = true
        // 图表边框颜色。默认black
        lineChartView.borderColor = UIColor(0xE5E5E8)
        // 图表边框宽度。默认1.0
        lineChartView.borderLineWidth = 0.5
    
        
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom
        // 不绘制x轴
        xAxis.drawAxisLineEnabled = false
        // 网格线颜色
        xAxis.gridColor = UIColor(0xE5E5E8)
        // 文字颜色
        xAxis.labelTextColor = UIColor(0x92959C)
        // 文字大小
        xAxis.labelFont = UIFont.systemFont(ofSize: 11)
        
        
        let leftAxis = lineChartView.leftAxis
        leftAxis.drawAxisLineEnabled = false
        // 网格线颜色
        leftAxis.gridColor = UIColor(0xE5E5E8)
        // 文字颜色
        leftAxis.labelTextColor = UIColor(0x92959C)
        // 文字大小
        leftAxis.labelFont = UIFont.systemFont(ofSize: 11)
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = 500
        
        // 禁用掉右轴
        lineChartView.rightAxis.enabled = false
        
        // MARK: DATA
        var entries = [ChartDataEntry]()
        for i in 0...31 {
            let entry = ChartDataEntry(x: Double(i), y: Double(arc4random_uniform(450)))
            entries.append(entry)
        }

        let set = CustomLineChartDataSet(entries: entries, label: "图例")
        // 渐变色
        let gradientColors = [ChartColorTemplates.colorFromString("#0024BF6A").cgColor,
                              ChartColorTemplates.colorFromString("#ff24BF6A").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        // 填充色
        set.fill = LinearGradientFill(gradient: gradient, angle: 90)
        set.fillAlpha = 1
        // 是否增加填充色
        set.drawFilledEnabled = true
        // 是否绘制圆点
        set.drawCirclesEnabled = false
        // 折线样式，平滑的曲线、折线
        set.mode = .horizontalBezier
        // 线段颜色
        set.colors = [UIColor(0x00B050)]
        // 高亮时横向辅助线。默认true
        set.drawHorizontalHighlightIndicatorEnabled = false
        // 高亮时颜色
        set.highlightColor = UIColor(0x00B050)
        // 高亮时宽度
        set.highlightLineWidth = 1
        // 高亮时虚线分割
        set.highlightLineDashLengths = [5.0,5.0]
        
        
        let data = LineChartData(dataSet: set)
        // 是否显示数值
        data.setDrawValues(false)
        lineChartView.data = data

        
    }
    
    @objc func normalButtonAction() {
        setDataCount(31, range: 500, lineNum: 1)
    }
    
    @objc func groupButtonAction() {
        setDataCount(31, range: 500)
    }
    
    // TODO: Refine data creation
    func setDataCount(_ count: Int, range: UInt32, lineNum: Int = 3) {
        let colors = self.vordiplom()[0...2]
        let alphaColors = self.vordiplom(0.0)[0...2]
        
        let block: (Int) -> ChartDataEntry = { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let dataSets = (0..<lineNum).map { i -> LineChartDataSet in
            let yVals = (0..<count).map(block)
            let set = CustomLineChartDataSet(entries: yVals, label: "DataSet \(i)")
            set.lineWidth = 2.5
            set.circleRadius = 4
            set.circleHoleRadius = 2
            let color = colors[i % colors.count]
            let alphaColor = alphaColors[i % colors.count]
            set.setColor(color)
            set.setCircleColor(color)
            
            // 渐变色
            let gradientColors = [alphaColor.cgColor,
                                  color.cgColor]
            let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
            // 填充色
            set.fill = LinearGradientFill(gradient: gradient, angle: 90)
            set.fillAlpha = 1
            // 是否增加填充色
            set.drawFilledEnabled = true
            // 是否绘制圆点
            set.drawCirclesEnabled = false
            // 折线样式，平滑的曲线、折线
            set.mode = .horizontalBezier
            // 线段颜色
            set.colors = [color]
            // 高亮时横向辅助线。默认true
            set.drawHorizontalHighlightIndicatorEnabled = false
            // 高亮时颜色
            set.highlightColor = color
            // 高亮时宽度
            set.highlightLineWidth = 1
            // 高亮时虚线分割
            set.highlightLineDashLengths = [5.0,5.0]
            
            return set
        }
        
        let data = LineChartData(dataSets: dataSets)
        data.setDrawValues(false)
        chartView.data = data
    }
    
    // 计算一个月的天数
    private func days(forMonth month: Int, year: Int) -> Int {
        // month is 1-based
        switch month {
        case 2:
            var is29Feb = false
            if year < 1582 {
                is29Feb = (year < 1 ? year + 1 : year) % 4 == 0
            } else if year > 1582 {
                is29Feb = year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
            }
            return is29Feb ? 29 : 28
        case 4, 6, 9, 11:
            return 30
        default:
            return 31
        }
    }
    
    func vordiplom (_ alpha: CGFloat = 0.6) -> [NSUIColor]
    {
        return [
            NSUIColor(red: 233/255.0, green: 63/255.0, blue: 55/255.0, alpha: alpha),
            NSUIColor(red: 122/255.0, green: 178/255.0, blue: 255/255.0, alpha: alpha),
            NSUIColor(red: 36/255.0, green: 191/255.0, blue: 106/255.0, alpha: alpha),
        ]
    }
}

// 处理点击不准确的问题
class CustomLineChartDataSet: LineChartDataSet {
    override func entriesForXValue(_ xValue: Double) -> [ChartDataEntry] {
        var entries = [ChartDataEntry]()
        var low = startIndex
        var high = endIndex - 1

        while low <= high {
            var mid = (high + low) / 2
            var entry = self[mid]
            // if we have a match
            if xValue == entry.x {
                while mid > 0 && self[mid - 1].x == xValue {
                    mid -= 1
                }
                high = endIndex
                // loop over all "equal" entries
                while mid < high {
                    entry = self[mid]
                    if entry.x == xValue {
                        entries.append(entry)
                    } else {
                        break
                    }
                    mid += 1
                }
                break
            } else {
                if xValue > entry.x {
                    low = mid + 1
                } else {
                    high = mid - 1
                }
            }
        }
        return entries
    }

}
