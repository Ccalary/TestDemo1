//
//  ChartsTestVC.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/3/24.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation
import Charts

@objc public class ChartsTestVC: UIViewController {
    
    private var chartView = BarChartView()
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let barChartView = BarChartView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400))
        view.addSubview(barChartView)
        self.chartView = barChartView
        self.chartView.doubleTapToZoomEnabled = false
        
        let button = UIButton()
        button.backgroundColor = UIColor.fontColorBlue()
        button.addTarget(self, action: #selector(normalButtonAction), for: .touchUpInside)
        button.setTitle("Normal", for: .normal)
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
        groupButton.setTitle("Group1", for: .normal)
        self.view.addSubview(groupButton)
        groupButton.snp.makeConstraints { make in
            make.width.height.centerY.equalTo(button)
            make.centerX.equalToSuperview()
        }
        
        let groupMoreButton = UIButton()
        groupMoreButton.backgroundColor = UIColor.fontColorBlue()
        groupMoreButton.addTarget(self, action: #selector(groupMoreButtonAction), for: .touchUpInside)
        groupMoreButton.setTitle("Group6", for: .normal)
        self.view.addSubview(groupMoreButton)
        groupMoreButton.snp.makeConstraints { make in
            make.width.height.centerY.equalTo(button)
            make.right.equalToSuperview().offset(-15)
        }

        var entries = [BarChartDataEntry]()
        let days = self.days(forMonth: 3, year: 2022)
        for i in 0..<days {
            let entry = BarChartDataEntry(x: Double(i), y: Double(arc4random_uniform(500)))
            entries.append(entry)
        }
        let set = BarChartDataSet(entries: entries, label: "图例")
        // 柱状颜色
        set.colors = [UIColor(0x7AB2FF)]
        // 是否显示label数据
        set.drawValuesEnabled = false
        // 是否支持高亮
        set.highlightEnabled = true
        // 高亮颜色
        set.highlightColor = .red
        let data = BarChartData(dataSet: set)
        // bar的宽度比例，默认0.85
        data.barWidth = 0.7
        
        barChartView.data = data
        
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
        barChartView.delegate = self
        
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
        
        // 底部数量
//        xAxis.labelCount = 6
//        xAxis.axisMaximum = 31
        // 分割粒度
        xAxis.granularity = 1
        
        // MARK: - leftYAxis
        let leftAxis = barChartView.leftAxis
        leftAxis.drawAxisLineEnabled = false
        leftAxis.gridColor = UIColor(0xE5E5E8)
        // 最小值
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = 500
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
        
        // MARK: 标签格式化，设置后则titles显示换成0开始的序列号
        // 按月展示数据
        var values: [String] = []
        for i in 0..<31 {
            values.append("\(i+1)")
        }
        xAxis.valueFormatter =  IndexAxisValueFormatter(values: values)
    }
    
    @objc func normalButtonAction() {
        setDataCount(31, range: 500)
    }
    
    @objc func groupButtonAction() {
        setGroupData(31, range: 500)
    }
    
    @objc func groupMoreButtonAction() {
        setGroupData(31, range: 500, barNum: 6)
    }
    
    func setDataCount(_ count: Int, range: Double) {
        let yVals = (0..<count).map { (i) -> BarChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(UInt32(mult)))
            return BarChartDataEntry(x: Double(i), y: val)
        }
        var set1: BarChartDataSet! = nil
        
        // 有数据的话更新数据
//        if let set = chartView.data?.first as? BarChartDataSet { // 有data
//            set1 = set
//            set1?.replaceEntries(yVals)
//            chartView.data?.notifyDataChanged()
//            chartView.notifyDataSetChanged()
//
//        } else {
        // 重新设置数据
        set1 = BarChartDataSet(entries: yVals, label: "Data Set")
        // 柱状颜色
        set1.colors = [UIColor(0x7AB2FF)]
        // 是否显示label数据
        set1.drawValuesEnabled = false
        // 是否支持高亮
        set1.highlightEnabled = true
        // 高亮颜色
        set1.highlightColor = .red
        
        let data = BarChartData(dataSet: set1)
        data.barWidth = 0.7
        chartView.data = data
//        chartView.fitBars = true
//        }
        chartView.xAxis.axisMinimum = -0.5
        chartView.xAxis.axisMaximum = 30.5
        // x轴label是否居中
        chartView.xAxis.centerAxisLabelsEnabled = false
        chartView.setNeedsDisplay()
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
               set.drawValuesEnabled = false
           }
           dataSets.append(set)
        }
//        dataSetMax = (dataSetMax + dataSetMax * 0.1)
//        self.chartView.leftAxis.axisMaximum = dataSetMax
//        self.chartView.leftAxis.axisMinimum = 0

        let data = BarChartData(dataSets: dataSets)
        data.barWidth = barWidth
        
        chartView.xAxis.axisMinimum = 0
        chartView.xAxis.axisMaximum = 0 + data.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(groupCount)
        // x轴label居中
        chartView.xAxis.centerAxisLabelsEnabled = true
        data.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        
        // 最多显示多少个
//        chartView.setVisibleXRangeMaximum()
        
        self.chartView.data = data
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

extension ChartsTestVC: ChartViewDelegate {
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("chartValueSelected")
    }
}
