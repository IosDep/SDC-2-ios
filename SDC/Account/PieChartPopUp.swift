//
//  PieChartPopUp.swift
//  SDC
//
//  Created by Razan Barq on 19/06/2023.
//

import UIKit
import Charts

class PieChartPopUp: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chartView: PieChartView!
    @IBOutlet weak var date: UILabel!
 
    
    @IBOutlet weak var mainView: UIView!
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
        
        tableView.register(UINib(nibName: "TotalHeaderView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "TotalHeaderView")
        
        tableView.register(UINib(nibName: "TotalFooterView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "TotalFooterView")
        
        self.categories = ["Banks" , "insurance" , "Services" , "Industry"]
        customizeChart(dataPoints: categories, values: chartValues ,pieChartView: chartView)
        
        if pieFlag == 0 {
            mainTitle.text = "Shareholders".localized()
        }
        
        else if pieFlag == 1 {
            mainTitle.text = "Securities".localized()
        }
        
        else if pieFlag == 2 {
            mainTitle.text = "Market Value".localized()
            
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
        format.numberStyle = .percent
        format.locale = Locale(identifier: "en")
        format.maximumFractionDigits = 1
        format.multiplier = 1.0
        
        
        // 4. Assign it to the chart’s data
        pieChartView.data = pieChartData
        pieChartData.setValueFormatter(DefaultValueFormatter(formatter: format))

        
        
    }
    
    
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        colors = [UIColor(red: 1.00, green: 0.95, blue: 0.50, alpha: 1.00)
                  , UIColor(red: 1.00, green: 0.60, blue: 0.00, alpha: 1.00)
                   , UIColor(red: 0.30, green: 0.76, blue: 0.55, alpha: 1.00) , UIColor(red: 0.82, green: 0.83, blue: 0.84, alpha: 1.00)]
        return colors
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TotalHeaderView") as! TotalHeaderView
        
        
        if pieFlag == 0 {
            headerView.sectorLabel.text = "Shareholders".localized()
            headerView.marketValLabel.isHidden = true
            
        }
        
        else if pieFlag == 1 {
            headerView.sectorLabel.text = "Securities".localized()

            headerView.marketValLabel.isHidden = true

        }
        
        else if pieFlag == 2 {
            headerView.sectorLabel.text = "Market Value".localized()
            headerView.marketValLabel.isHidden = false
        }
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if touch?.view == self.mainView{
            
        }else {
            self.dismiss(animated: true,completion: {
                print("Done WIth  2 second ")
            })
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TotalFooterView") as! TotalFooterView
        
        if pieFlag == 0 {
            footerView.totalValue.text = self.formatDoubleToString(totalAnlysis.sec_count ?? 0.0)
            footerView.totalPercentage.isHidden = true
        }
        
        else if pieFlag == 1 {
            footerView.totalValue.text = self.formatDoubleToString(totalAnlysis.Quantity ?? 0.0)
            footerView.totalPercentage.isHidden = true
        }
        
        else if pieFlag == 2 {
            footerView.totalValue.text = self.numFormat(value: totalAnlysis.market_value ?? 0.0)
            footerView.totalPercentage.isHidden = false
            footerView.totalPercentage.text = "100 %"
//            self.numFormat(value: percanetageValues[section] ?? 0.0)

        }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pieTableHolder.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // PieTableCell
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "PieTableCell", for: indexPath) as? PieTableCell
        
        cell?.title.text = pieTableHolder[indexPath.row].title
        
        if pieFlag == 0 {
            cell?.value.text = self.formatDoubleToString(pieTableHolder[indexPath.row].array.sec_count ?? 0.0) 
            cell?.percentageValue.isHidden = true
            cell?.imageColor.backgroundColor = pieTableHolder[indexPath.row].color
        }
        
        else if pieFlag == 1 {
            cell?.value.text = self.formatDoubleToString(pieTableHolder[indexPath.row].array.Quantity ?? 0.0)
            cell?.percentageValue.isHidden = true
            cell?.imageColor.backgroundColor = pieTableHolder[indexPath.row].color
        }
        
        else if pieFlag == 2 {
            cell?.value.text = self.numFormat(value: pieTableHolder[indexPath.row].array.market_value ?? 0)
            cell?.percentageValue.isHidden = false
            cell?.percentageValue.text = self.percentageNum(value: percanetageValues[indexPath.row] ?? 0.0)
            cell?.imageColor.backgroundColor = pieTableHolder[indexPath.row].color

        }
        
        return cell!
    }
    
}
