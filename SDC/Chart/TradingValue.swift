//
//  TradingValue.swift
//  SDC
//
//  Created by Blue Ray on 26/03/2023.
//

import UIKit
import Charts
import MOLH
import JGProgressHUD
import Alamofire
class TradingValue: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{

    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var bellView: UIView!
    @IBOutlet weak var scroll: UIScrollView!
    
    
    
    @IBOutlet weak var tradeTableVeiw: UITableView!
    
  static  var monthData  = [String]()
    static  var valueChart  = [Double]()
    
    
    var tradeAnlysis = [TradeAnlysis]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//       let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [50.0, 25.0, 50.0, 75.0, 100.0, 75.0]

        scroll.roundCorners([.topLeft, .topRight], radius: 17)
        
        self.cerateBellView(bellview: self.bellView, count: "10")
        
        
        tradeTableVeiw.delegate = self
        tradeTableVeiw.dataSource =  self
        
        tradeTableVeiw.register(UINib(nibName: "TradingXibView", bundle: nil), forCellReuseIdentifier: "TradingXibView")
        
        self.setChart(dataPoints: TradingValue.monthData  , values: TradingValue.valueChart )
        print("adfslkdhasl;DHAKLSjGHRZR")
        print(TradingValue.valueChart)
        print(TradingValue.monthData)
   
        

    }
    override func viewDidAppear(_ animated: Bool) {
     
        
    }
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }

        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "nil")
        chartDataSet.circleRadius = 5
        chartDataSet.circleHoleRadius = 2
        chartDataSet.drawValuesEnabled = false

        let chartData = LineChartData(dataSets: [chartDataSet])


        lineChartView.data = chartData

        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.avoidFirstLastClippingEnabled = true

        lineChartView.rightAxis.drawAxisLineEnabled = false
        lineChartView.rightAxis.drawLabelsEnabled = false

        lineChartView.leftAxis.drawAxisLineEnabled = false
        lineChartView.pinchZoomEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        lineChartView.legend.enabled = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tradeAnlysis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = self.tradeTableVeiw.dequeueReusableCell(withIdentifier: "TradingXibView", for: indexPath) as? TradingXibView
      
        
        if cell == nil {
            let nib: [Any] = Bundle.main.loadNibNamed("TradingXibView", owner: self, options: nil)!
            cell = nib[0] as? TradingXibView
        }
        
        
        return cell!
    }

    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let scrollViewContentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
      
        
        
        let yOffset = scrollView.contentOffset.y

        if scrollView == self.scroll {
            if yOffset >= scrollViewContentHeight - screenHeight {
                print("Reached bottom of scroll view")

                scrollView.isScrollEnabled = false
                tradeTableVeiw.isScrollEnabled = true
            }
        }

        if scrollView == self.tradeTableVeiw {
            if yOffset <= 0 {
                self.scroll.isScrollEnabled = true
                self.tradeTableVeiw.isScrollEnabled = false
            }
        }
    }
    

    }

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
