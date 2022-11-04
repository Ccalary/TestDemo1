//
//  LayoutVC.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/24.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation
import UIKit

class LayoutVC: UIViewController {
    
    let layoutView = LayoutView()
    
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
        self.view.backgroundColor = UIColor.white
        
        layoutView.backgroundColor = UIColor.bgColorf2f2f2()
        self.view.addSubview(layoutView)
        layoutView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(400)
        }
        self.setupData()
        
        let refreshBtn = UIButton()
        refreshBtn.setTitle("refresh", for: .normal)
        refreshBtn.backgroundColor = UIColor("#4E95F8")
        refreshBtn.addTarget(self, action: #selector(refreshAction), for: .touchUpInside)
        self.view.addSubview(refreshBtn)
        refreshBtn.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.top.equalTo(layoutView.snp_bottom).offset(50)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupData() {
        var dataSets: [LayoutDataSet] = []
        
        let groupNum = 10

        for i in 0..<groupNum {

            let rowNum = arc4random()%5
            let columnNum = arc4random()%6

            var entries = [LayoutDataEntry]()

            for m in 0..<rowNum {
                for n in 0..<columnNum {
                    let random = arc4random()%3
                    var state: LayoutDataEntry.State = .empty
                    switch random {
                        case 1:
                            state = .bind
                        case 2:
                            state = .unbound
                        default:
                            state = .empty
                    }
                    let entry = LayoutDataEntry(deviceSn: "9000-\(i)000-:\(m)\(n)", state: state)
                    entry.xaxisIndex = Int(m + 1)
                    entry.yaxisIndex = Int(n + 1)
                    entries.append(entry)
                }
            }

            let dataSet = LayoutDataSet(entries: entries, name: "group\(i)")
            dataSet.xaxisIndex = (arc4random()%2 == 0) ? -Double(arc4random()%1000) : Double(arc4random()%1000)
            dataSet.yaxisIndex = (arc4random()%2 == 0) ? -Double(arc4random()%1000) : Double(arc4random()%1000)
            dataSet.rowNum = Int(rowNum)
            dataSet.columnNum = Int(columnNum)
            dataSet.angle = 0//Double(arc4random()%360)
//            dataSets.append(dataSet)
        }
        
        let entry = LayoutDataEntry(deviceSn: "9000010000100020----------------2000", state: .bind)
        entry.xaxisIndex = 1
        entry.yaxisIndex = 1
        
        let entry1 = LayoutDataEntry(deviceSn: "9000100010002001000200", state: .bind)
        entry1.xaxisIndex = 2
        entry1.yaxisIndex = 2
        
        let entry2 = LayoutDataEntry(deviceSn: "9000010002000", state: .unbound)
        entry2.xaxisIndex = 1
        entry2.yaxisIndex = 3
        
        let dataSet = LayoutDataSet(entries: [entry, entry1, entry2], name: "group")
        dataSet.xaxisIndex = -2000
        dataSet.yaxisIndex = -2000
        dataSet.rowNum = 2
        dataSet.columnNum = 4
        dataSet.angle = 0
        
        dataSets.append(dataSet)
        
        let data = LayoutData(dataSets: dataSets)
        
        layoutView.data = data
    }
    
    @objc func refreshAction() {
        setupData()
    }
}

