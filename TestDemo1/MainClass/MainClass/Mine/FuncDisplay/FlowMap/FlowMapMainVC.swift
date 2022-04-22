//
//  SwiftFirstVC.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/3/21.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import UIKit

@objc public class FlowMapMainVC: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    func initView() {
        self.navigationItem.title = "Logger"
        self.view.backgroundColor = UIColor.lightGray
        
        let flowMapView = FlowMapView()
        self.view.addSubview(flowMapView)
        
        let entry = FlowEntry(iconName: "icon_pro_48", name: "Production", value: "12.22", unit: "kW")
        let legend = FlowLegend(entry: entry, positon: .topLeft, textPosition: .top)
        
        let entry1 = FlowEntry(iconName: "icon_generador_48", name: "Generador", value: "5.22", unit: "kW")
        let legend1 = FlowLegend(entry: entry1, positon: .topCenter, textPosition: .top, flowEnable: false)
        
        let entry2 = FlowEntry(iconName: "icon_grid_48", name: "Grid", value: "2.01", unit: "kW")
        let legend2 = FlowLegend(entry: entry2, positon: .topRight, textPosition: .top, flowDirection: .reverse)
        
        let entry3 = FlowEntry(iconName: "icon_mi_48", name: "Microinverter", value: "5.01", unit: "kW")
        let legend3 = FlowLegend(entry: entry3, positon: .centerLeft, textPosition: .top)
        
        let entry4 = FlowEntry(iconName: "icon_dcac_51x63")
        let legend4 = FlowLegend(entry: entry4, positon: .center)
        
        let entry5 = FlowEntry(iconName: "icon_smart_48", name: "SmartLoad", value: "15.01", unit: "kW")
        let legend5 = FlowLegend(entry: entry5, positon: .centerRight, textPosition: .top)
        
        let entry6 = FlowEntry(iconName: "icon_battery_48", name: "Battery", value: "5.01", unit: "kW", subValue: "80%")
        let legend6 = FlowLegend(entry: entry6, positon: .bottomLeft)
        
        let entry7 = FlowEntry(iconName: "icon_ups_48", name: "Ups-Load", value: "5.01", unit: "kW")
        let legend7 = FlowLegend(entry: entry7, positon: .bottomCenter)
        
        let entry8 = FlowEntry(iconName: "icon_consump_48", name: "Consumption", value: "5.01", unit: "kW")
        let legend8 = FlowLegend(entry: entry8, positon: .bottomRight)
        
        flowMapView.dataSets = [legend, legend1, legend2, legend3, legend4, legend5, legend6, legend7, legend8]
                    
        flowMapView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(400)
        }
    }
}
