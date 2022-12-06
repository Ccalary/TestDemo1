//
//  LayoutVC.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/11/23.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import UIKit
import SystemLayoutKit

class LayoutVC: UIViewController {

    let layoutView = LayoutView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    func initView() {
        self.view.backgroundColor = UIColor.lightGray
        
        layoutView.frame = CGRect(x: 0, y: 80, width: UIScreen.main.bounds.size.width, height: 400)
        layoutView.backgroundColor = UIColor.white
        layoutView.selectedEntryBlock = { entry in
            if let entry = entry {
                print("回调来了:\(entry.title ?? "")")
            }
        }
        self.view.addSubview(layoutView)
        
        self.setupData()
        
        let refreshBtn = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width/2.0 - 40 - 100, y: 520, width: 100, height: 40))
        refreshBtn.setTitle("物理布局", for: .normal)
        refreshBtn.backgroundColor = UIColor("#4E95F8")
        refreshBtn.addTarget(self, action: #selector(refreshAction), for: .touchUpInside)
        self.view.addSubview(refreshBtn)
        
        let eleBtn = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width/2.0 + 40, y: 520, width: 100, height: 40))
        eleBtn.setTitle("电气布局", for: .normal)
        eleBtn.backgroundColor = UIColor("#4E95F8")
        eleBtn.addTarget(self, action: #selector(eleBtnAction), for: .touchUpInside)
        self.view.addSubview(eleBtn)
        
        let resetBtn = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width/2.0 - 50, y: 520 + 60, width: 100, height: 40))
        resetBtn.setTitle("复位", for: .normal)
        resetBtn.backgroundColor = UIColor("#4E95F8")
        resetBtn.addTarget(self, action: #selector(resetBtnAction), for: .touchUpInside)
        self.view.addSubview(resetBtn)
    }
    
    /// 物理布局
    func setupData() {
        
        var dataSets: [LayoutItemDataSet] = []
        
        dataSets.append(contentsOf: normalData())
        dataSets.append(modulesGroupData())
//        dataSets.append(inverterData())
        
        let data = LayoutData(dataSets: dataSets)
        
        layoutView.drawBorderEnabled = true
        layoutView.isElectricLayout = false
        layoutView.data = data
    }
    
    /// 电气布局
    func eleData() {
        let data = LayoutData(lineDataSets: eleBuildData())
        /// 是否绘制外框
        layoutView.drawBorderEnabled = true
        /// 是否是电气布局
        layoutView.isElectricLayout = true
        layoutView.data = data
    }
    
    func eleBuildData() -> [LayoutItemDataSet] {
             
        func inverterData() -> InverterLayoutDataSet {
            let entry = InverterLayoutDataEntry(title: "1", content: "9000000012-1")
            entry.xaxisIndex = 1
            entry.yaxisIndex = 1
            entry.fillColor = UIColor("#1D489C")
            
            let dataSet = InverterLayoutDataSet(entries: [entry], name: "group")
            dataSet.rows = 1
            dataSet.columns = 1
            dataSet.angle = 0//Double(arc4random()%360)
            dataSet.itemHeight = 75
            return dataSet
        }
        
        func eleNormalData() -> ModuleLayoutDataSet {
            let rowNum = 1
            let columnNum = arc4random()%50
            var entries = [ModuleLayoutDataEntry]()

            for m in 0..<rowNum {
                for n in 0..<columnNum {
                    let random = arc4random()%2 + 1
                    var state: ModuleLayoutDataEntry.State = .empty
                    switch random {
                        case 1:
                            state = .bind
                        case 2:
                            state = .unbound
                        default:
                            state = .empty
                    }
                    let content = arc4random()%1000
                    let entry = ModuleLayoutDataEntry(title:"1.\(m).\(n)", content: "\(content)", subContent: "W", state: state)
                    if content <= 20 {
                        entry.fillColor = UIColor("#1D489C")
                    }else if (content <= 40) {
                        entry.fillColor = UIColor("#3677CC")
                    }else if (content <= 60) {
                        entry.fillColor = UIColor("#4696EC")
                    }else if (content <= 80) {
                        entry.fillColor = UIColor("#77B5F0")
                    }else {
                        entry.fillColor = UIColor("#9BC9F5")
                    }
                    entry.xaxisIndex = Int(m + 1)
                    entry.yaxisIndex = Int(n + 1)
                    entries.append(entry)
                }
            }

            let dataSet = ModuleLayoutDataSet(entries: entries, name: "group")
            dataSet.xaxisPoint = (arc4random()%2 == 0) ? -Double(arc4random()%1000) : Double(arc4random()%1000)
            dataSet.yaxisPoint = (arc4random()%2 == 0) ? -Double(arc4random()%1000) : Double(arc4random()%1000)
            dataSet.rows = Int(rowNum)
            dataSet.columns = Int(columnNum)
            dataSet.angle = 0//Double(arc4random()%360)
            
            return dataSet
        }
        
        var dataSets: [LayoutItemDataSet] = []
        
        for _ in 0...10 {
            let inverterDataSet = inverterData()
            inverterDataSet.groupId = Int(arc4random()%11)
            dataSets.append(inverterDataSet)
            
            let moduleDataSet1 = eleNormalData()
            moduleDataSet1.groupId = Int(arc4random()%11)
            dataSets.append(moduleDataSet1)
            
            let moduleDataSet2 = eleNormalData()
            moduleDataSet2.groupId = Int(arc4random()%11)
            dataSets.append(moduleDataSet2)
        }
        return dataSets
    }
    
    func normalData() -> [ModuleLayoutDataSet] {
        
        var dataSets: [ModuleLayoutDataSet] = []
        let groupNum = 100
        for i in 0..<groupNum {
            let rowNum = arc4random()%5 + 1
            let columnNum = arc4random()%6 + 1

            var entries = [ModuleLayoutDataEntry]()

            for m in 0..<rowNum {
                for n in 0..<columnNum {
                    let random = arc4random()%3
                    var state: ModuleLayoutDataEntry.State = .empty
                    switch random {
                        case 1:
                            state = .bind
                        case 2:
                            state = .unbound
                        default:
                            state = .empty
                    }
                    let content = arc4random()%1000
                    let entry = ModuleLayoutDataEntry(title:"1.\(m).\(n)", content: "\(content)", subContent: "W", state: state)
                    if content <= 20 {
                        entry.fillColor = UIColor("#1D489C")
                    }else if (content <= 40) {
                        entry.fillColor = UIColor("#3677CC")
                    }else if (content <= 60) {
                        entry.fillColor = UIColor("#4696EC")
                    }else if (content <= 80) {
                        entry.fillColor = UIColor("#77B5F0")
                    }else {
                        entry.fillColor = UIColor("#9BC9F5")
                    }
                    entry.xaxisIndex = Int(m + 1)
                    entry.yaxisIndex = Int(n + 1)
                    entries.append(entry)
                }
            }

            let dataSet = ModuleLayoutDataSet(entries: entries, name: "group\(i)")
            dataSet.xaxisPoint = (arc4random()%2 == 0) ? -Double(arc4random()%1000) : Double(arc4random()%1000)
            dataSet.yaxisPoint = (arc4random()%2 == 0) ? -Double(arc4random()%1000) : Double(arc4random()%1000)
            dataSet.rows = Int(rowNum)
            dataSet.columns = Int(columnNum)
            dataSet.angle = Double(arc4random()%360)
            dataSets.append(dataSet)
        }
        return dataSets
    }
    
    /// 组件组
    func modulesGroupData() -> ModuleLayoutDataSet {
        let entry = ModuleLayoutDataEntry(title: "1.1.1", content: "12.11", subContent: "kW", state: .bind)
        entry.fillColor = UIColor("#1D489C")
        entry.xaxisIndex = 1
        entry.yaxisIndex = 1
        
        let entry1 = ModuleLayoutDataEntry(title: "1.2.2", content: "1401.31", subContent: "W", state: .bind)
        entry1.fillColor = UIColor("#9BC9F5")
        entry1.xaxisIndex = 1
        entry1.yaxisIndex = 2
        
        let entry2 = ModuleLayoutDataEntry(title: "1.1.3", content: "120.29", subContent: "W", state: .unbound)
        entry2.xaxisIndex = 1
        entry2.yaxisIndex = 3
        
        let dataSet = ModuleLayoutDataSet(entries: [entry, entry1, entry2], name: "group")
        dataSet.xaxisPoint = -0
        dataSet.yaxisPoint = -0
        dataSet.rows = 1
        dataSet.columns = 4
//        dataSet.direction = .vertical
//        if (dataSet.direction == .vertical) {
//            dataSet.itemCellRows = 3
//            dataSet.itemCellColumns = 6
//            dataSet.itemWidth = 72
//            dataSet.itemHeight = 48
//        }
        dataSet.angle = 0//Double(arc4random()%360)
        
        return dataSet
    }
    
    /// 微逆/逆变器
    func inverterData() -> InverterLayoutDataSet {
        let entry = InverterLayoutDataEntry(title: "1", content: "9000000012-1")
        entry.xaxisIndex = 1
        entry.yaxisIndex = 1
        entry.fillColor = UIColor("#1D489C")
        
        let dataSet = InverterLayoutDataSet(entries: [entry], name: "group")
        dataSet.xaxisPoint = -2000
        dataSet.yaxisPoint = -2000
        dataSet.rows = 1
        dataSet.columns = 1
        dataSet.angle = 0//Double(arc4random()%360)
        return dataSet
    }
    
    
    @objc func refreshAction() {
        setupData()
    }
    
    @objc func eleBtnAction() {
        eleData()
    }
    
    @objc func resetBtnAction() {
        layoutView.resetZoom()
    }
}
