//
//  PieChartPopUp.swift
//  SDC
//
//  Created by Razan Barq on 19/06/2023.
//

import UIKit
import Charts

class PieChartPopUp: UIViewController {

    @IBOutlet weak var chartView: PieChartView!
    
    @IBOutlet weak var date: UILabel!
    
    
    @IBOutlet weak var sec1: UILabel!
    @IBOutlet weak var sec2: UILabel!
    @IBOutlet weak var sec3: UILabel!
    @IBOutlet weak var sec4: UILabel!
    @IBOutlet weak var secTotal: UILabel!
    @IBOutlet weak var qun1: UILabel!
    @IBOutlet weak var qun2: UILabel!
    @IBOutlet weak var qun3: UILabel!
    @IBOutlet weak var qun4: UILabel!
    @IBOutlet weak var marketVal1: UILabel!
    @IBOutlet weak var qunTotal: UILabel!
    @IBOutlet weak var marketVal2: UILabel!
    @IBOutlet weak var marketVal3: UILabel!
    @IBOutlet weak var marketVal4: UILabel!
    @IBOutlet weak var marketValTotal: UILabel!
    @IBOutlet weak var val1: UILabel!
    @IBOutlet weak var val2: UILabel!
    @IBOutlet weak var val3: UILabel!
    @IBOutlet weak var valTotal: UILabel!
    @IBOutlet weak var val4: UILabel!
    
    @IBOutlet weak var insuranceStack: UIStackView!
    
    @IBOutlet weak var servicesStack: UIStackView!
    
    @IBOutlet weak var industryStack: UIStackView!
    @IBOutlet weak var bankStack: UIStackView!
    var chartValues : [Double] = []
    var categories = [String]()

    var bank = SectorAnylisisModel(data: [:])
    var insuarance = SectorAnylisisModel(data: [:])
    var service = SectorAnylisisModel(data: [:])
    var industry = SectorAnylisisModel(data: [:])
    
    
    var totalAnlysis = SectorAnylisisModel(data: [:])
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categories = ["Banks" , "Insurance" , "Services" , "Industry"]
        
        if bank.sec_count == 0 && bank.Quantity == 0 && bank.market_value == 0 {
            bankStack.isHidden = true
        }
        
      else  if insuarance.sec_count == 0 && insuarance.Quantity == 0 && insuarance.market_value == 0 {
            insuranceStack.isHidden = true
        }
        
        
        else if service.sec_count == 0 && service.Quantity == 0 && service.market_value == 0 {
            servicesStack.isHidden = true
        }
        
        
        
        else if industry.sec_count == 0 && industry.Quantity == 0 && industry.market_value == 0 {
            industryStack.isHidden = true
            
        }
        
        
        
        customizeChart(dataPoints: categories, values: chartValues ,pieChartView: chartView)
        
        
        
        if let security1 =  bank.sec_count as? Double {
            sec1.text =  "\(security1)"
        }
        
        if let quantity1 =  bank.Quantity as? Double {
            qun1.text =  "\(quantity1)"
        }
        
        if let value1 =  bank.market_value as? Double {
            marketVal1.text =  "\(value1)"
        }
        
        if let security2 =  insuarance.sec_count as? Double {
            sec2.text =  "\(security2)"
        }
        
        if let quantity2 =  insuarance.Quantity as? Double {
            qun2.text =  "\(quantity2)"
        }
        
        if let value2 =  insuarance.market_value as? Double {
            marketVal2.text =  "\(value2)"
        }
        
        if let security3 =  service.sec_count as? Double {
            sec3.text =  "\(security3)"
        }
        
        if let quantity3 =  service.Quantity as? Double {
            qun3.text =  "\(quantity3)"
        }
        
        if let value3 =  service.market_value as? Double {
            marketVal3.text =  "\(value3)"
        }
        
        if let security4 =  industry.sec_count as? Double {
            sec4.text =  "\(security4)"
        }
        
        if let quantity4 =  industry.Quantity as? Double {
            qun4.text =  "\(quantity4)"
        }
        
        if let value4 =  industry.market_value as? Double {
            marketVal4.text =  "\(value4)"
        }
        
        if let security0 =  totalAnlysis.sec_count as? Double {
            secTotal.text =  "\(security0)"
        }
        
        if let quantity0 =  totalAnlysis.Quantity as? Double {
            qunTotal.text =  "\(quantity0)"
        }
        
        if let value0 =  totalAnlysis.market_value as? Double {
            valTotal.text =  "\(value0)"
        }
        
        
        // market values percentage
        
        

    }
    
    
    
    func customizeChart(dataPoints: [String] , values: [Double],pieChartView:PieChartView) {
        
        //           1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: "", data: "" as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        //           2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        
        //           3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        // 4. Assign it to the chart’s data
        pieChartView.data = pieChartData
        
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        colors = [UIColor(red: 1.00, green: 0.95, blue: 0.50, alpha: 1.00)
                  , UIColor(red: 1.00, green: 0.60, blue: 0.00, alpha: 1.00)
                  , UIColor(red: 0.82, green: 0.83, blue: 0.84, alpha: 1.00) , UIColor(red: 0.30, green: 0.76, blue: 0.55, alpha: 1.00)]
        return colors
    }
    
   
}
