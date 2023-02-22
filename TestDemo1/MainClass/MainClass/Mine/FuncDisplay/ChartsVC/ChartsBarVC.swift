//
//  ChartsTestVC.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/3/24.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation
import UIKit

@objc public class ChartsBarVC: UIViewController {
    
    private var barChartView = CustomBarChartView()
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "BarChart"
        self.view.backgroundColor = UIColor.white
        
        let barChartView = CustomBarChartView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400))
        view.addSubview(barChartView)
        barChartView.backgroundColor = UIColor(hex: 0xAD59E7, alpha: 0.1)
        self.barChartView = barChartView
        self.barChartView.doubleTapToZoomEnabled = false
        self.barChartView.delegate = self
        
        let button = UIButton()
        button.backgroundColor = UIColor.fontColorBlue()
        button.addTarget(self, action: #selector(normalButtonAction), for: .touchUpInside)
        button.setTitle("month", for: .normal)
        self.view.addSubview(button)
        button.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(40)
            make.top.equalTo(barChartView.snp_bottom).offset(50)
            make.left.equalToSuperview().offset(15)
        }
        
        let groupButton = UIButton()
        groupButton.backgroundColor = UIColor.fontColorBlue()
        groupButton.addTarget(self, action: #selector(groupButtonAction), for: .touchUpInside)
        groupButton.setTitle("year", for: .normal)
        self.view.addSubview(groupButton)
        groupButton.snp.makeConstraints { make in
            make.width.height.centerY.equalTo(button)
            make.centerX.equalToSuperview()
        }
        
        let groupMoreButton = UIButton()
        groupMoreButton.backgroundColor = UIColor.fontColorBlue()
        groupMoreButton.addTarget(self, action: #selector(groupMoreButtonAction), for: .touchUpInside)
        groupMoreButton.setTitle("total", for: .normal)
        self.view.addSubview(groupMoreButton)
        groupMoreButton.snp.makeConstraints { make in
            make.width.height.centerY.equalTo(button)
            make.right.equalToSuperview().offset(-15)
        }
        
        // 禁止y轴缩放
        barChartView.scaleYEnabled = false
        // 是否绘制图表边框，绘制后就不需要绘制x轴和y轴的轴线了。默认false
        barChartView.drawBordersEnabled = true
        // 图表边框颜色。默认black
        barChartView.borderColor = UIColor(0xE5E5E8)
        // 图表边框宽度。默认1.0
        barChartView.borderLineWidth = 0.5
        // 柱状上面的字隐藏
        barChartView.data?.setDrawValues(false)
        // 图例是否展示
        barChartView.legend.enabled = false
        
        // MARK: - xAxis
        let xAxis = barChartView.xAxis
        // x轴位置,上、下，both
        xAxis.labelPosition = .bottom
        // 不绘制x轴
        xAxis.drawAxisLineEnabled = false
        // 网格线颜色
        xAxis.gridColor = UIColor(0xE5E5E8)
        // 文字颜色
        xAxis.labelTextColor = UIColor(0x92959C)
        // 文字大小
        xAxis.labelFont = UIFont.systemFont(ofSize: 11)
        // 分割粒度
        xAxis.granularity = 1
        // label局中
        xAxis.centerAxisLabelsEnabled = true
        
        
        // MARK: - leftYAxis
        let leftAxis = barChartView.leftAxis
        leftAxis.drawAxisLineEnabled = false
        leftAxis.gridColor = UIColor(0xE5E5E8)
        // 最小值
        leftAxis.axisMinimum = 0
//        leftAxis.axisMaximum = 500
        leftAxis.labelTextColor = UIColor(0x92959C)
        leftAxis.labelFont = UIFont.systemFont(ofSize: 11)
        
        // MARK: - rightYAxis
        let rightAxis = barChartView.rightAxis
        rightAxis.drawAxisLineEnabled = false
        // 隐藏网格线
        rightAxis.drawGridLinesEnabled = false
        rightAxis.axisMinimum = 0
        rightAxis.labelTextColor = UIColor(0x92959C)
        rightAxis.labelFont = UIFont.systemFont(ofSize: 11)
        
        barChartView.xImageAxis.iconPosition = .bottom
        barChartView.xImageAxis.iconSize = CGSize(width: 15, height: 15)
        // 设置自定义渲染方式
        barChartView.setupCustomRenderer()
        
        
        setNoDataAvailable()
    }
    
    @objc func normalButtonAction() {
        monthData()
    }
    
    @objc func groupButtonAction() {
        yearData()
    }
    
    @objc func groupMoreButtonAction() {
        totalData()
    }
    
    func monthData() {
        
        // [155, 10953, 21752, 32666, 43368, 54156, 64961, 75762]
        let imageDataEntry1 = ChartDataEntry(x: 1, y: 0, data: "weather_cloudy")
        let imageDataEntry2 = ChartDataEntry(x: 3, y: 0, data: "weather_drizzling")
        let imageDataEntry3 = ChartDataEntry(x: 5, y: 0, data: "weather_foggy")
        let imageDataEntry4 = ChartDataEntry(x: 7, y: 0, data: "weather_heavy_rain")
        let imageDataEntry5 = ChartDataEntry(x: 8, y: 0, data: "weather_snowy")
        let imageDataEntry6 = ChartDataEntry(x: 10, y: 0, data: "weather_snowy")
        let imageDataEntry7 = ChartDataEntry(x: 12, y: 0, data: "weather_heavy_rain")
        let imageDataEntry8 = ChartDataEntry(x: 20, y: 0, data: "weather_cloudy")
        barChartView.xImageAxis.dataEntries = [imageDataEntry1, imageDataEntry2, imageDataEntry3, imageDataEntry4, imageDataEntry5, imageDataEntry6, imageDataEntry7, imageDataEntry8]
        
        
        let jsonDataArray = getModelArayWithFileName("month03")
//        jsonDataArray.removeLast()
        var dataSets = [BarChartDataSet]()
        let colors = self.barColors()
        
        var entries1 = [BarChartDataEntry]()
        var entries2 = [BarChartDataEntry]()
        var entries3 = [BarChartDataEntry]()
        var entries4 = [BarChartDataEntry]()
        
        var yMin = 0.0
        var yMax = 0.0
        
        // 按月展示数据
        var valueFormatterValues: [String] = []
        for item in jsonDataArray {
            if let day = item.day {
                let power = item.generationValue ?? 0.0
                let entry1 = BarChartDataEntry(x: Double(day), y: power)
                entries1.append(entry1)
                
                let useValue = item.useValue ?? 0.0
                let entry2 = BarChartDataEntry(x: Double(day), y: useValue)
                entries2.append(entry2)
                
                let buyValue = item.buyValue ?? 0.0
                let entry3 = BarChartDataEntry(x: Double(day), y: buyValue)
                entries3.append(entry3)
                
                let entry4 = BarChartDataEntry(x: Double(day), yValues: [-buyValue/3.0, useValue/3.0, power/3.0])
                entries4.append(entry4)
                
                let entry4Y = buyValue/3.0 + useValue/3.0 + power/3.0
                yMin = min(power, useValue, buyValue, entry4Y, yMin)
                yMax = max(power, useValue, buyValue, entry4Y, yMax)
                
                valueFormatterValues.append("\(day)")
            }
        }
        let entriesArray = [entries1, entries2, entries3, entries4]
        
        for i in 0..<entriesArray.count {
            let entries = entriesArray[i]
            let set = BarChartDataSet(entries: entries, label: "")
            let color = colors[i % colors.count]
            // 柱状颜色
            if entries.first?.stackSize == 1 {
                set.colors = [color]
            }else {
                set.colors = [color, colors[(i+1) % colors.count], colors[(i+2) % colors.count]]
            }
            
            // 是否显示label数据
            set.drawValuesEnabled = true
            // 是否支持高亮
            set.highlightEnabled = true
            // 高亮颜色
            set.highlightColor = UIColor(hex: 0x4E95F8)
            
            let valueFormatter = DefaultValueFormatter()
            valueFormatter.decimals = 0
            // 数据显示类型
            set.valueFormatter = valueFormatter
            
            dataSets.append(set)
        }
        let barNum = entriesArray.count
        let groupSpace = 0.16
        // 间距
        let barSpace = 0.00
        //柱子宽度（(barSpace + barWidth) * 系列数 + groupSpace = 1.00 -> interval per "group"）
        let barWidth = (1 - groupSpace)/Double(barNum) - barSpace
        
        let data = BarChartData(dataSets: dataSets)
        // bar的宽度比例，默认0.85
        data.barWidth = barWidth
        
        // 可控制31天一半全部展示
        barChartView.xAxis.labelCount = 15
        
        barChartView.xAxis.axisMinimum = 0
        barChartView.xAxis.axisMaximum = Double(jsonDataArray.count) //0 + data.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(jsonDataArray.count)
        data.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        self.barChartView.data = data
        
        barChartView.xAxis.centerAxisLabelsEnabled = true
        barChartView.setVisibleXRangeMinimum(1)
//        barChartView.xAxis.valueFormatter =  IndexAxisValueFormatter(values: valueFormatterValues)
        
    
        barChartView.leftAxis.drawLabelsEnabled = true
        barChartView.rightAxis.drawLabelsEnabled = true
        
        barChartView.leftAxis.axisMinimum = yMin.yRoundedToNextSignificant()
        // TODO: 有负值要处理最小值
        // MARK: Y轴分布问题处理
        // 处理Y轴点位分布问题
        let labelCount = barChartView.leftAxis.labelCount
//        let range = abs(yMax - leftAxis.axisMinimum)
        let range = abs(yMax - yMin)
        // 间隔
        var interval = Double(range) / Double(labelCount - 1)
        interval = interval.yRoundedToNextSignificant()
        barChartView.leftAxis.axisMaximum = barChartView.leftAxis.axisMinimum + interval*Double(labelCount - 1)
        
        barChartView.rightAxis.axisMinimum = barChartView.leftAxis.axisMinimum
        barChartView.rightAxis.axisMaximum = barChartView.leftAxis.axisMaximum
    }
    
    func yearData() {
        // 7个可以展示全12个月
        barChartView.xAxis.labelCount = 12
        
        var jsonDataArray = getModelArayWithFileName("year2021")
        jsonDataArray.sort(by: {$0.month! < $1.month!})
        
        var dataSets = [BarChartDataSet]()
        let colors = self.barColors()
        
        var entries1 = [BarChartDataEntry]()
        var entries2 = [BarChartDataEntry]()
        var entries3 = [BarChartDataEntry]()
        var yMin = 0.0
        var yMax = 0.0
        // 按月展示数据
        var valueFormatterValues: [String] = []
        for item in jsonDataArray {
            if let month = item.month {
                let power = item.generationValue ?? 0.0
                let entry1 = BarChartDataEntry(x: Double(month), y: power)
                entries1.append(entry1)
                
                let useValue = item.useValue ?? 0.0
                let entry2 = BarChartDataEntry(x: Double(month), y: useValue)
                entries2.append(entry2)
                
                let buyValue = item.buyValue ?? 0.0
                let entry3 = BarChartDataEntry(x: Double(month), y: buyValue)
                entries3.append(entry3)
                
                yMin = min(power, useValue, buyValue, yMin)
                yMax = max(power, useValue, buyValue, yMax)
                valueFormatterValues.append("\(month)")
            }
        }
        let entriesArray = [entries1, entries2, entries3]
        
        for i in 0..<entriesArray.count {
            let entries = entriesArray[i]
            let set = BarChartDataSet(entries: entries, label: "")
            let color = colors[i % colors.count]
            // 柱状颜色
            set.colors = [color]
            // 是否显示label数据
            set.drawValuesEnabled = true
            // 是否支持高亮
            set.highlightEnabled = true
            // 高亮颜色
            set.highlightColor = UIColor(hex: 0x4E95F8)
            
            dataSets.append(set)
        }
        let barNum = entriesArray.count
        let groupSpace = 0.16
        // 间距
        let barSpace = 0.02
        //柱子宽度（(barSpace + barWidth) * 系列数 + groupSpace = 1.00 -> interval per "group"）
        let barWidth = (1 - groupSpace)/Double(barNum) - barSpace
        
        let data = BarChartData(dataSets: dataSets)
        
        
        
        // bar的宽度比例，默认0.85
        data.barWidth = barWidth
        barChartView.xAxis.axisMinimum = 0
        barChartView.xAxis.axisMaximum = 0 + data.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(jsonDataArray.count)
        data.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        
        self.barChartView.data = data
        
        // 数据展示格式，两位小数展示
        let valueFormatter = DefaultValueFormatter(decimals: 2)
        self.barChartView.barData?.setValueFormatter(valueFormatter)
        
        
        barChartView.xAxis.centerAxisLabelsEnabled = true
        barChartView.setVisibleXRangeMinimum(1)
//        barChartView.xAxis.valueFormatter =  IndexAxisValueFormatter(values: valueFormatterValues)
        
        
        barChartView.leftAxis.drawLabelsEnabled = true
        barChartView.rightAxis.drawLabelsEnabled = true
        // TODO: 有负值要处理最小值
        // MARK: Y轴分布问题处理
        // 处理Y轴点位分布问题
        barChartView.leftAxis.axisMinimum = yMin.yRoundedToNextSignificant()
        let labelCount = barChartView.leftAxis.labelCount
        let range = abs(yMax - yMin)
        // 间隔
        var interval = Double(range) / Double(labelCount - 1)
        interval = interval.yRoundedToNextSignificant()
        barChartView.leftAxis.axisMaximum = barChartView.leftAxis.axisMinimum + interval*Double(labelCount - 1)
        
        barChartView.rightAxis.axisMinimum = barChartView.leftAxis.axisMinimum
        barChartView.rightAxis.axisMaximum = barChartView.leftAxis.axisMaximum
    }
    
    func totalData() {
        var jsonDataArray = getModelArayWithFileName("total")
        jsonDataArray.sort(by: {$0.year! < $1.year!})
        
        var dataSets = [BarChartDataSet]()
        let colors = self.barColors()
        
        var entries1 = [BarChartDataEntry]()
        var entries2 = [BarChartDataEntry]()
        var entries3 = [BarChartDataEntry]()
        
        var yMin = 0.0
        var yMax = 0.0
        // 按月展示数据
        var valueFormatterValues: [String] = []
        for item in jsonDataArray {
            if let year = item.year {
                let power = item.generationValue ?? 0.0
                let entry1 = BarChartDataEntry(x: Double(year), y: power)
                entries1.append(entry1)
                
                 let useValue = item.useValue ?? 0.0
//                if let useValue = item.useValue {
                    let entry2 = BarChartDataEntry(x: Double(year), y: useValue)
                    entries2.append(entry2)
//                }
                 let buyValue = item.buyValue ?? 0.0
//                if let buyValue = item.buyValue {
                    let entry3 = BarChartDataEntry(x: Double(year), y: buyValue)
                    entries3.append(entry3)
//                }
                
                yMin = min(power, useValue, buyValue, yMin)
                yMax = max(power, useValue, buyValue, yMax)
            
                valueFormatterValues.append("\(year)")
            }
        }
        let entriesArray = [entries1, entries2, entries3]
        
        for i in 0..<entriesArray.count {
            let entries = entriesArray[i]
            let set = BarChartDataSet(entries: entries, label: "")
            let color = colors[i % colors.count]
            // 柱状颜色
            set.colors = [color]
            // 是否显示label数据
            set.drawValuesEnabled = true
            // 是否支持高亮
            set.highlightEnabled = true
            // 高亮颜色
            set.highlightColor = UIColor(hex: 0x4E95F8)
            dataSets.append(set)
        }
        let barNum = entriesArray.count
        let groupSpace = 0.16
        // 间距
        let barSpace = 0.02
        //柱子宽度（(barSpace + barWidth) * 系列数 + groupSpace = 1.00 -> interval per "group"）
        let barWidth = (1 - groupSpace)/Double(barNum) - barSpace
        
        let data = BarChartData(dataSets: dataSets)
        // bar的宽度比例，默认0.85
        data.barWidth = barWidth
        barChartView.xAxis.axisMinimum = 0
        barChartView.xAxis.axisMaximum = 0 + data.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(jsonDataArray.count)
        data.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        self.barChartView.data = data
        
        barChartView.xAxis.centerAxisLabelsEnabled = true
        barChartView.setVisibleXRangeMinimum(1)
        barChartView.xAxis.valueFormatter =  IndexAxisValueFormatter(values: valueFormatterValues)
        
        barChartView.leftAxis.drawLabelsEnabled = false
        barChartView.rightAxis.drawLabelsEnabled = false
        
        barChartView.leftAxis.axisMinimum = yMin.yRoundedToNextSignificant()
        // TODO: 有负值要处理最小值
        // MARK: Y轴分布问题处理
        // 处理Y轴点位分布问题
        let labelCount = barChartView.leftAxis.labelCount
//        let range = abs(yMax - leftAxis.axisMinimum)
        let range = abs(yMax - yMin)
        // 间隔
        var interval = Double(range) / Double(labelCount - 1)
        interval = interval.yRoundedToNextSignificant()
        barChartView.leftAxis.axisMaximum = barChartView.leftAxis.axisMinimum + interval*Double(labelCount - 1)
        
        barChartView.rightAxis.axisMinimum = barChartView.leftAxis.axisMinimum
        barChartView.rightAxis.axisMaximum = barChartView.leftAxis.axisMaximum
    }
    
    // 获取数据
    func getModelArayWithFileName(_ fileName: String) -> [RecordModel] {
        var jsonDataArray: [RecordModel] = [RecordModel]()
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
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
                if let result: [RecordModel] = [RecordModel].deserialize(from: jsonData) as? [RecordModel] {
                    result.forEach({(model) in
                        jsonDataArray.append(model)
                    })
                }
            }
        } catch let error as Error? {
            print("读取本地数据出现错误!",error ?? "")
        }
        return jsonDataArray
    }
    
    // 无数据界面展示
    func setNoDataAvailable() {
        let entries = [BarChartDataEntry(x: 0, y: 0)]
        let set1 = BarChartDataSet(entries: entries, label: "")
        set1.colors = [UIColor.clear]
        set1.drawValuesEnabled = false
        let data = BarChartData(dataSet: set1)
        data.barWidth = 0.7
        barChartView.data = data
        barChartView.xAxis.axisMinimum = 0
        barChartView.xAxis.axisMaximum = 30
        // x轴label是否居中
        barChartView.xAxis.centerAxisLabelsEnabled = true
        
        let values = (0...30).map {"\($0+1)"}
        barChartView.xAxis.valueFormatter =  IndexAxisValueFormatter(values: values)
    }
    
    func setGroupData(_ count: Int, range: Double, barNum: Int = 1) {
        var datas: [[Double]] = []
        // 几组数据
        for _ in 0..<barNum {
            let yVals = (0..<count).map { (i) -> Double in
                let mult = range + 1
                let val = Double(arc4random_uniform(UInt32(mult)))
                return val
            }
            datas.append(yVals)
        }
        let groupCount = count
        var dataSetMax: Double = 0
        let groupSpace = 0.16
        // 间距
        let barSpace = 0.02
        //柱子宽度（(barSpace + barWidth) * 系列数 + groupSpace = 1.00 -> interval per "group"）
//        let barWidth = 0.12
        let barWidth = (1 - groupSpace)/Double(barNum) - barSpace

        var dataSets = [BarChartDataSet]()
        for i in 0..<datas.count {
           var yValues = [BarChartDataEntry]()
           var set = BarChartDataSet()
           let data = datas[i]
           for j in 0..<data.count {
               let value = data[j]
               dataSetMax = max(value, dataSetMax)
               yValues.append(BarChartDataEntry(x: Double(j), y: value))
               set = BarChartDataSet(entries: yValues, label: "第\(i)个图例")
               set.setColor(UIColor(red: CGFloat(arc4random() % 256) / 255.0, green: CGFloat(arc4random() % 256) / 255.0, blue: CGFloat(arc4random() % 256) / 255.0, alpha: 1.0))
               set.drawValuesEnabled = true
           }
           dataSets.append(set)
        }
//        dataSetMax = (dataSetMax + dataSetMax * 0.1)
//        self.chartView.leftAxis.axisMaximum = dataSetMax
//        self.chartView.leftAxis.axisMinimum = 0

        let data = BarChartData(dataSets: dataSets)
        data.barWidth = barWidth
        
        barChartView.xAxis.axisMinimum = 0
        barChartView.xAxis.axisMaximum = 0 + data.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(groupCount)
        // x轴label居中
        barChartView.xAxis.centerAxisLabelsEnabled = true
        data.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        
        // 最多显示多少个
//        chartView.setVisibleXRangeMaximum()
        
        self.barChartView.data = data
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
}

extension ChartsBarVC: ChartViewDelegate {
    public func chartViewDidEndPanning(_ chartView: ChartViewBase) {
        print("endPanning");
                
        let viewPortHandler = chartView.viewPortHandler
        
        let scaleX = min(max(viewPortHandler.minScaleX, viewPortHandler.touchMatrix.a), viewPortHandler.maxScaleX)
        
        let maxTransX = -viewPortHandler.contentRect.width * (scaleX - 1.0)
        
        print("endPanning-maxTransX:\(maxTransX)")
        
        print("endPanning-transX:\(viewPortHandler.transX)")
        
        if (viewPortHandler.transX == 0) {
            print("右切换下一个")
        }else if (viewPortHandler.transX == (maxTransX)) {
            print("左切换上一个")
        }
    }
}

extension ChartsBarVC {
    func barColors() -> [NSUIColor] {
        return [
            UIColor(0xFC403F),
            UIColor(0x7AB2FF),
            UIColor(0x6DD07F),
            UIColor(0xF6BD3D),
            UIColor(0x8452F5),
            UIColor(0x3BBCAD)
        ]
    }
}
