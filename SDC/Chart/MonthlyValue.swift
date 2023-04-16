//
//  MonthlyValue.swift
//  SDC


import UIKit
import Charts

import Alamofire
import JGProgressHUD
import MOLH

class MonthlyValue: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var bellView: UIView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var marketDataTable: UITableView!

    
    
    
    var monthData = [String]()
    var valueData = [Double]()
    var arr_trd = [TradeAnlysis]()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        marketDataTable.delegate = self
        marketDataTable.dataSource = self
        
        marketDataTable.register(UINib(nibName: "TradingXibView", bundle: nil), forCellReuseIdentifier: "TradingXibView")
        
        self.getMonthValue()

        scroll.roundCorners([.topLeft, .topRight], radius: 17)
        
        self.cerateBellView(bellview: self.bellView, count: "10")
        
        
        
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
        return arr_trd.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = self.marketDataTable.dequeueReusableCell(withIdentifier: "TradingXibView", for: indexPath) as? TradingXibView
      
        
        
        
        if cell == nil {
            let nib: [Any] = Bundle.main.loadNibNamed("TradingXibView", owner: self, options: nil)!
            cell = nib[0] as? TradingXibView
        }
        
        
        return cell!
    }

    
    
    
    
    //    API Call
        
        func getMonthValue(){
            
            

    //
            let hud = JGProgressHUD(style: .light)
    //        hud.textLabel.text = "Please Wait".localized()
            hud.show(in: self.view)

        
         
            let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": MOLHLanguage.isRTLLanguage() ? "ar": "en", "date":"2020-01-07"
     ]
         
            let link = URL(string: APIConfig.OwnershipAnalysis)

            AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
                if response.error == nil {
                    do {
                        let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                       

                        if jsonObj != nil {
                            
                            
                                
                                
                            if let status = jsonObj!["status"] as? Int {
                                if status == 200 {
                                    
                                        
                                    if let data = jsonObj!["data"] as? [[String: Any]]{
                                                for item in data {
                                                    let model = TradeAnlysis(data: item)
                                                    self.arr_trd.append(model)
                                     
                                                }
                                                
                                                DispatchQueue.main.async {
                                                    
                                                    
                                                    
                                                    
                                                    self.monthData = self.arr_trd.map { $0.Month ?? "" }
                                                    self.valueData = self.arr_trd.map{ Double($0.Market_Value_Sell ?? "") ?? 0.0 }
                                                 
                                                    self.marketDataTable.reloadData()
                                          

                                          

print("MYUERAAARAY")
                                                    self.setChart(dataPoints: self.monthData, values: self.valueData)

                                                    print(self.monthData)
                                                    print(self.valueData )
                                                    

                                                    hud.dismiss()
    //                                                self.showSuccessHud(msg: message ?? "", hud: hud)
                                                    
    //                                                if self.car_arr.count == 0{
    //
    //
    //                                                    self.noDataImage.isHidden = false
    //                                                }else{
    //
    //                                                    self.noDataImage.isHidden = true
    //                                                }

                                                }
                                            }
                                    
                                        }
    //                             Session ID is Expired
                                else if status == 400{
                                    let msg = jsonObj!["message"] as? String
    //                                self.showErrorHud(msg: msg ?? "")
                                    self.seassionExpired(msg: msg ?? "")
                                }
                                    
                                    
                                    
                                    
    //                                other Wise Problem
                                else {
                                                    hud.dismiss(animated: true)      }
                          
                                
                            }
                            
                        }

                    } catch let err as NSError {
                        print("Error: \(err)")
                        self.serverError(hud: hud)
                        

                  }
                } else {
                    print("Error")

                    self.serverError(hud: hud)
                        


                }
            }




            
            
            
        }
    
}

