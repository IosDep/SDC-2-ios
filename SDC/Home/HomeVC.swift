//
//  HomeVC.swift
//  SDC
//
//  Created by Blue Ray on 05/02/2023.
//

import UIKit
import Charts
import SideMenu
import MOLH
import JGProgressHUD
import Alamofire

class HomeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var lastloginInfo: UILabel!
    
    @IBOutlet weak var busnissCard: UICollectionView!
    
    @IBOutlet weak var anlyssSection: UICollectionView!


    @IBOutlet weak var bellView: UIView!
    
    
    var monthData  = [String]()
    var valueChart  = [Double]()
    
    
    var tradeAnlysis = [TradeAnlysis]()
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }
    
//Dummy Chart
//    let players = ["A","V","BS","ASD","WWQ","Qw",]
//    let goals = [6, 8, 26, 30, 8, 10]
//    Arrays
    var lastTransarr = [LastTransaction]()
    var ownershapeAnlusis = [OwnerShapeAnlysisModel]()
    var yearArray = [String]()
    var categoryArray = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        busnissCard.delegate = self
        busnissCard.dataSource  = self
        
        anlyssSection.delegate = self
        anlyssSection.dataSource  = self
        busnissCard.register(UINib(nibName: "BusnissCard", bundle: nil), forCellWithReuseIdentifier: "BusnissCard")

        anlyssSection.register(UINib(nibName: "HomePropretyXib", bundle: nil), forCellWithReuseIdentifier: "HomePropretyXib")

        let collLayout = UICollectionViewFlowLayout()
        let collLayouta = UICollectionViewFlowLayout()

        
        collLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        collLayout.itemSize = CGSize(width: 260, height: 200)

        collLayouta.scrollDirection = UICollectionView.ScrollDirection.horizontal
        collLayouta.itemSize = CGSize(width: 300, height: 140)
        self.busnissCard.backgroundColor = .clear
        self.busnissCard.setCollectionViewLayout(collLayouta, animated: false)
        self.busnissCard.bouncesZoom = false
        self.busnissCard.bounces = false
        self.busnissCard.isDirectionalLockEnabled  = false
        
        self.anlyssSection.backgroundColor = .clear
        self.anlyssSection.setCollectionViewLayout(collLayout, animated: false)
        
        self.cerateBellView(bellview: self.bellView, count: "12")
        
        
//        call api
        self.getLastTrans()
        self.getLastDate()
        self.getOwnerShapeList()
        self.getTradingValue()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == busnissCard {
            
            return lastTransarr.count
            
        }else {
            return ownershapeAnlusis.count
        }
        }
    

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CardInfo") as! CardInfo
        vc.modalPresentationStyle = .fullScreen
  
        
        self.present(vc, animated: true)

        
        
        
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == busnissCard {
            var cell = self.busnissCard.dequeueReusableCell(withReuseIdentifier: "BusnissCard", for: indexPath) as? BusnissCard
            //            .dequeueReusableCell(withReuseIdentifier: "EductionSystemCell", for: indexPath) as? EductionSystemCell
            
            
            
            if cell == nil {
                let nib: [Any] = Bundle.main.loadNibNamed("BusnissCard", owner: self, options: nil)!
                cell = nib[0] as? BusnissCard
            }
            cell?.mainCardView.layer.cornerRadius = 10
            cell?.mainCardView.clipsToBounds = true
            cell?.layer.borderWidth = 0
            cell?.layer.shadowColor = UIColor.black.cgColor
            cell?.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell?.layer.shadowRadius = 5
            cell?.layer.shadowOpacity = 0.2
            cell?.layer.masksToBounds = false
            
            let data  = lastTransarr[indexPath.row]

            cell?.firstlbl.text =  data.Member_Name
            cell?.secondlbl.text = data.Account_No
            cell?.theredlbl.text =  data.Price


            return cell!
            
        }else {
            
            var cell = self.anlyssSection.dequeueReusableCell(withReuseIdentifier: "HomePropretyXib", for: indexPath) as? HomePropretyXib
            //            .dequeueReusableCell(withReuseIdentifier: "EductionSystemCell", for: indexPath) as? EductionSystemCell
            
            
            
            if cell == nil {
                let nib: [Any] = Bundle.main.loadNibNamed("HomePropretyXib", owner: self, options: nil)!
                cell = nib[0] as? HomePropretyXib
            }
            

            cell?.mainview.layer.cornerRadius = 10
            cell?.mainview.clipsToBounds = true
            cell?.layer.borderWidth = 0
            cell?.layer.shadowColor = UIColor.black.cgColor
            cell?.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell?.layer.shadowRadius = 5
            cell?.layer.shadowOpacity = 0.2
            cell?.layer.masksToBounds = false
            
            let data =  ownershapeAnlusis[indexPath.row]
            cell?.title.text = data.Main_Security_Cat_Desc
            customizeChart(dataPoints: categoryArray, values: yearArray.map{ Double($0) ?? 0.0 },pieChartView: (cell?.chartView!)!)
            return cell!
        }
   
    }
    func customizeChart(dataPoints: [String], values: [Double],pieChartView:PieChartView) {
      
      // 1. Set ChartDataEntry
      var dataEntries: [ChartDataEntry] = []
      for i in 0..<dataPoints.count {
        let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: "" as AnyObject)
        dataEntries.append(dataEntry)
      }
      // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "nil")
      pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
      // 3. Set ChartData
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
      for _ in 0..<numbersOfColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
      }
      return colors
    }
    @IBAction func marketValue(_ sender: Any) {
        
        
 
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TradingValue") as! TradingValue
        vc.modalPresentationStyle = .fullScreen
  
//        vc.monthData = self.monthData
//        vc.valueChart = self.valueChart
        vc.tradeAnlysis = self.tradeAnlysis
//
        
        
        self.present(vc, animated: true)
    }
    

    @IBAction func trading(_ sender: Any) {
        
        


        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MonthlyValue") as! MonthlyValue
        vc.modalPresentationStyle = .fullScreen
  
        
        self.present(vc, animated: true)
        
    }
    
    
    
  

    
    //    API Call
        
        func getLastTrans(){
            
            

    //
            let hud = JGProgressHUD(style: .light)
    //        hud.textLabel.text = "Please Wait".localized()
            hud.show(in: self.view)

        
         
            let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": MOLHLanguage.isRTLLanguage() ? "ar": "en"
     ]
         
            let link = URL(string: APIConfig.GetLastTrans)

            AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
                if response.error == nil {
                    do {
                        let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                       

                        if jsonObj != nil {
                            
                            
                                
                                
                            if let status = jsonObj!["status"] as? Int {
                                if status == 200 {
                                    
                                
                                        
                                    if let data = jsonObj!["data"] as? [[String: Any]]{
                                                for item in data {
                                                    let model = LastTransaction(data: item)
                                                    self.lastTransarr.append(model)
                                     
                                                }
                                                
                                                DispatchQueue.main.async {
                                                    self.busnissCard.reloadData()
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
    
    
    //    API Call
        
        func getOwnerShapeList(){
            
            

    //
            let hud = JGProgressHUD(style: .light)
    //        hud.textLabel.text = "Please Wait".localized()
            hud.show(in: self.view)

        
         
            let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": MOLHLanguage.isRTLLanguage() ? "ar": "en"
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
                                                    let model = OwnerShapeAnlysisModel(data: item)
                                                    self.ownershapeAnlusis.append(model)
                                     
                                                }
                                                
                                                DispatchQueue.main.async {
                                                    self.anlyssSection.reloadData()
                                                    
                                                    
                                                    self.yearArray = self.ownershapeAnlusis.map { $0.Market_Value_Buy ?? "" }
                                                    self.categoryArray = self.ownershapeAnlusis.map{ $0.Month ?? "" }

                                                    
                                                    
print("MYUERAAARAY")
                                                    print(self.yearArray)
                                                    print(self.categoryArray)

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
    
    
    //    API Call
        
        func getLastDate(){
            
            

    //
            let hud = JGProgressHUD(style: .light)
    //        hud.textLabel.text = "Please Wait".localized()
            hud.show(in: self.view)

        
         
            let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": MOLHLanguage.isRTLLanguage() ? "ar": "en"
     ]
         
            let link = URL(string: APIConfig.GetSysDates)

            AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
                if response.error == nil {
                    do {
                        let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                       

                        if jsonObj != nil {
                            
                            
                                
                                
                            if let status = jsonObj!["status"] as? Int {
                                if status == 200 {
                                    
                                    hud.dismiss()
                                    let data  = jsonObj!["data"] as? [String:Any]
                                    
                                    let sysDate =     data!["sysDate"] as? String
                                    let lastUpdate =     data!["lastUpdate"] as? String

                                    self.lastloginInfo.text =  sysDate ?? "" +  (lastUpdate ?? "")
                                
                                        
                            
                                    
                                    
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
    
    
    
    
    //    API Call
        
        func getTradingValue(){
            
            

    //
            let hud = JGProgressHUD(style: .light)
    //        hud.textLabel.text = "Please Wait".localized()
            hud.show(in: self.view)

        
         
            let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": MOLHLanguage.isRTLLanguage() ? "ar": "en", "date":"2020-01-07" 
     ]
         
            let link = URL(string: APIConfig.TradesAnalysis)

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
                                                    self.tradeAnlysis.append(model)
                                     
                                                }
                                                
                                                DispatchQueue.main.async {
                                                    
                                                    
                                                    
                                                    TradingValue.monthData = self.tradeAnlysis.map { $0.Month ?? "" }
                                                    TradingValue.valueChart = self.tradeAnlysis.map{ Double($0.Market_Value_Sell ?? "") ?? 0.0 }
                                                 
                                                    
                                          

                                          

print("MYUERAAARAY")
                                                    print(self.monthData)
                                                    print(TradingValue.valueChart )
                                                    

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
