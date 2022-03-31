//
//  ChartLineVC.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/3/24.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation
import Charts
import simd
import HandyJSON

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
        
        let lineChartView = CustomLineChartView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400))
        view.addSubview(lineChartView)
        self.chartView = lineChartView
                
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
        // 图表右侧偏移量
        lineChartView.extraRightOffset = 15
        
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom
        // 不绘制x轴
        xAxis.drawAxisLineEnabled = false
        // 网格线颜色
        xAxis.gridColor = UIColor(0xE5E5E8)
//        xAxis.drawGridLinesEnabled = false;
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
        leftAxis.labelCount = 7
        // 强制数量
        leftAxis.forceLabelsEnabled = true
//        leftAxis.axisMaximum = 500000
        
        // 禁用掉右轴
        let rightAxis = lineChartView.rightAxis
        rightAxis.enabled = false
        
        // 设置自定义渲染方式
        lineChartView.setupCustomRenderer()
        
        var jsonDataArray: [DayModel] = [DayModel]()
        let path = Bundle.main.path(forResource: "day0321", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        // 带throws的方法需要抛异常
            do {
                  /*
                     * try 和 try! 的区别
                     * try 发生异常会跳到catch代码中
                     * try! 发生异常程序会直接crash
                     */
                let data = try Data(contentsOf: url)
                if let jsonData:[Any] = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any] {
                    if let result: [DayModel] = [DayModel].deserialize(from: jsonData) as? [DayModel] {
                        result.forEach({(model) in
                            jsonDataArray.append(model)
                        })
                    }
                }
            } catch let error as Error? {
                print("读取本地数据出现错误!",error ?? "")
            }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        let date1 = formatter.date(from: "20220321")
        let timeStamp = date1?.timeIntervalSince1970 ?? 0.0
        
        // MARK: DATA
        var entries = [ChartDataEntry]()
        var entries2 = [ChartDataEntry]()
        var yMax = 0.0
        for item in jsonDataArray {
            if let dateTime = item.dateTime {
                if let power = item.generationPower {
                    let entry = ChartDataEntry(x: Double(dateTime) - timeStamp, y: Double(power))
//                    let entry = ChartDataEntry(x: Double(dateTime) - timeStamp, y: Double(10000))
                    entries.append(entry)
                    yMax = max(Double(power), yMax)
                    
                    if let capacity = item.generationCapacity {
                        let y = Double(capacity*40000.0) + Double(arc4random_uniform(100000))
                        let entry2 = ChartDataEntry(x: Double(dateTime) - timeStamp, y: y)
                        entries2.append(entry2)
                        yMax = max(y, yMax)
                    }
                }
            }
        }
//        for i in 0...30 {
//            let entry = ChartDataEntry(x: Double(i), y: Double(arc4random_uniform(400)))
//            entries.append(entry)
//        }

        let colors = self.vordiplom()[0...2]
        let alphaColors = self.vordiplom(0.0)[0...2]
        let entriesArray = [entries, entries2]
        
        let sets = (0..<entriesArray.count).map { i -> LineChartDataSet in
            let entry = entriesArray[i]
            let set = LineChartDataSet(entries: entry, label: "图例")
            let color = colors[i % colors.count]
            let alphaColor = alphaColors[i % colors.count]
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
            set.highlightLineDashLengths = [3.0,3.0]
            return set
        }
        
        let data = LineChartData(dataSets: sets)
        // 是否显示数值
        data.setDrawValues(false)
        lineChartView.data = data
        
        // 设置最大最小值
        xAxis.axisMinimum = 0
        xAxis.axisMaximum = 24*60*60
        // 15分钟为最小单位
        xAxis.granularity = 15*60
        // x轴数据格式
        xAxis.valueFormatter =  TimeAxisValueFormatter()
        
        // MARK: Y轴分布问题处理
        // 处理Y轴点位分布问题
        let labelCount = leftAxis.labelCount
        let range = abs(yMax - leftAxis.axisMinimum)
        // 间隔
        var interval = Double(range) / Double(labelCount - 1)
        interval = interval.yRoundedToNextSignificant()
        leftAxis.axisMaximum = interval*Double(labelCount - 1)
    }
}

extension ChartsLineVC {
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
