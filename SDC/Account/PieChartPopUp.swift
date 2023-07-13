//
//  PieChartPopUp.swift
//  SDC
//
//  Created by Razan Barq on 19/06/2023.
//

import UIKit
import Charts

class PieChartPopUp: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
   
    @IBOutlet weak var totalPercentage: UILabel!
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var percentageTitle: DesignableLabel!
    
    @IBOutlet weak var tableTitle: DesignableLabel!
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chartView: PieChartView!
    @IBOutlet weak var date: UILabel!
 
    
    var chartValues : [Double] = []
    var percanetageValues : [Double] = []
    var categories = [String]()
    var bank = SectorAnylisisModel(data: [:])
    var insuarance = SectorAnylisisModel(data: [:])
    var service = SectorAnylisisModel(data: [:])
    var industry = SectorAnylisisModel(data: [:])
    var totalAnlysis = SectorAnylisisModel(data: [:])
    var dtotalAnlysis = SectorAnylisisModel(data: [:])

    
    var pieTableHolder = [PieTableHolder]()
    var pieFlag : Int?
    var currencyFlag : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        self.tableView.register(UINib(nibName: "PieTableCell", bundle: nil), forCellReuseIdentifier: "PieTableCell")
        self.categories = ["Banks" , "insurance" , "Services" , "Industry"]
        customizeChart(dataPoints: categories, values: chartValues ,pieChartView: chartView)
        
        if pieFlag == 0 {
            mainTitle.text = "Shareholders".localized()
            tableTitle.text = "Shareholders".localized()
            percentageTitle.isHidden = true
            totalPercentage.isHidden = true
            
            
            totalValue.text = self.numFormat(value: totalAnlysis.sec_count ?? 0.0)
            
        
        }
        
        else if pieFlag == 1 {
            mainTitle.text = "Securities".localized()
            tableTitle.text = "Securities".localized()
            percentageTitle.isHidden = true
            totalPercentage.isHidden = true
            totalValue.text = self.numFormat(value: totalAnlysis.Quantity ?? 0.0)

        }
        
        else if pieFlag == 2 {
            mainTitle.text = "Market Value".localized()
            tableTitle.text = "Market Value".localized()
            percentageTitle.isHidden = false
            totalPercentage.isHidden = false
            totalValue.text = self.numFormat(value: totalAnlysis.market_value ?? 0.0)
            
            for i in chartValues {
                if i != 0 {
                    percanetageValues.append(i)
                }
            }

        }
        
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
        pieChartView.legend.enabled = false
        
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
                   , UIColor(red: 0.30, green: 0.76, blue: 0.55, alpha: 1.00) , UIColor(red: 0.82, green: 0.83, blue: 0.84, alpha: 1.00)]
        return colors
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pieTableHolder.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // PieTableCell
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "PieTableCell", for: indexPath) as? PieTableCell
        
        cell?.title.text = pieTableHolder[indexPath.row].title
        
        if pieFlag == 0 {
            cell?.value.text = self.numFormat(value: pieTableHolder[indexPath.row].array.sec_count ?? 0.0)
            cell?.percentageValue.isHidden = true
            cell?.colorBtn.setImage(UIImage(systemName: "square.fill"), for: .normal)
            cell?.colorBtn.tintColor = pieTableHolder[indexPath.row].color
        }
        
        else if pieFlag == 1 {
            cell?.value.text = self.numFormat(value: pieTableHolder[indexPath.row].array.Quantity ?? 0.0)
            cell?.percentageValue.isHidden = true
            cell?.colorBtn.setImage(UIImage(systemName: "square.fill"), for: .normal)
            cell?.colorBtn.tintColor = pieTableHolder[indexPath.row].color
        }
        
        else if pieFlag == 2 {
            cell?.value.text = self.numFormat(value: pieTableHolder[indexPath.row].array.market_value ?? 0)
            cell?.percentageValue.isHidden = false
            cell?.percentageValue.text = self.numFormat(value: percanetageValues[indexPath.row] ?? 0.0)
            cell?.colorBtn.tintColor = pieTableHolder[indexPath.row].color

        }
        return cell!
    }
    
}
