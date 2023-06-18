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
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var dolar: DesignableButton!
    @IBOutlet weak var dinar: DesignableButton!
    @IBOutlet weak var busnissCard: UICollectionView!
    @IBOutlet weak var anlyssSection: UICollectionView!
    @IBOutlet weak var bellView: UIView!
    
    var isDolarSelected : Bool = true
    var isDinarSelected : Bool = false
    var monthData  = [String]()
    var valueChart  = [Double]()
    var notificationCount : String?
    var checkSideMenu = false
    
    var tradeAnlysis = [TradeAnlysis]()
    var bank = SectorAnylisisModel(data: [:])
    var insuarance = SectorAnylisisModel(data: [:])
    var service = SectorAnylisisModel(data: [:])
    var industry = SectorAnylisisModel(data: [:])
    var total = SectorAnylisisModel(data: [:])
    var quantities : [Int] = []
    var securities  : [Int] = []
    var marketValues : [Double] = []

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
    
    //function for change background selected background color for with and without zero btn
    
    func highlightedButtons() {
        if isDolarSelected && !isDinarSelected {
            DispatchQueue.main.async {
                self.dolar.setTitleColor(.white, for: .normal)
                self.dolar.cornerRadius = 12
                self.dolar.backgroundColor  = UIColor(named: "AccentColor")
                self.dinar.borderWidth = 0
                self.dinar.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
                self.dinar.backgroundColor  = .white
                self.dinar.cornerRadius = 12
                self.dinar.borderColor =  UIColor(named: "AccentColor")
                self.dinar.borderWidth = 1
            }
        }
        else if !isDolarSelected && isDinarSelected {
            DispatchQueue.main.async {
                self.dinar.setTitleColor(.white, for: .normal)
                self.dinar.backgroundColor  = UIColor(named: "AccentColor")
                self.dinar.cornerRadius = 12
                self.dinar.borderWidth = 0
                self.dolar.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
                self.dolar.backgroundColor  = .white
                self.dolar.cornerRadius = 12
                self.dolar.borderColor =  UIColor(named: "AccentColor")
                self.dolar.borderWidth = 1
            }
        }
    }
    
    
    @IBAction func dolarPressed(_ sender: Any) {
        isDolarSelected = true
        isDinarSelected = false
        highlightedButtons()
    }
    
    @IBAction func backPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: {
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            self.present(vc, animated: true, completion: nil)
        })
    }
    
    @IBAction func dinarPressed(_ sender: Any) {
        isDolarSelected = false
        isDinarSelected = true
        highlightedButtons()
    }
     
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getInvestoreInfo()
        isDolarSelected = true
        isDinarSelected = false
        highlightedButtons()
        if checkSideMenu == true {
            backBtn.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
            sideMenuBtn.isHidden = true
        }
        else {
            backBtn.isHidden = true
        }
        
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
            
            return 3
        }
        }
    

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CardThereVc") as! CardThereVc
        vc.modalPresentationStyle = .fullScreen
        vc.trans = self.lastTransarr[indexPath.row]
        
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
            cell?.mainCardView.layer.cornerRadius = 20
            cell?.mainCardView.clipsToBounds = true
            cell?.layer.borderWidth = 0
            cell?.layer.shadowColor = UIColor.black.cgColor
            cell?.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell?.layer.shadowRadius = 5
            cell?.layer.shadowOpacity = 0.2
            cell?.layer.masksToBounds = false
            
            let data  = lastTransarr[indexPath.row]

            cell?.firstlbl.text =  self.convertIntToArabicNumbers(intString: data.Security_Id ?? "")
            
            cell?.secondlbl.text = data.Security_Name
            
            // ?????
            
            cell?.theredlbl.text =  self.doubleToArabic(value: data.Price ??  "")

            return cell!
            
        }
        
        else {
            // pie chart
            
            var cell = self.anlyssSection.dequeueReusableCell(withReuseIdentifier: "HomePropretyXib", for: indexPath) as? HomePropretyXib
            
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
            
            switch indexPath.row {
            case 0:
                cell?.title.text = "Shareholders" .localized()
            customizeChart(dataPoints: categoryArray, values: yearArray.map{ Double($0) ?? 0.0 },pieChartView: (cell?.chartView!)!)

            case 1:
                cell?.title.text = "Securities" .localized()
//                let data =  ownershapeAnlusis[indexPath.row]

              // Market Value
            case 2:
                cell?.title.text = "Market Value" .localized()
            default:
                print("defaultt")
            }
        
//            let data =  ownershapeAnlusis[indexPath.row]
//            cell?.title.text = data.Main_Security_Cat_Desc
//            customizeChart(dataPoints: categoryArray, values: yearArray.map{ Double($0) ?? 0.0 },pieChartView: (cell?.chartView!)!)
            
            return cell!
        }
   
    }
    
    
        func customizeChart(dataPoints: [String] , values: [Double],pieChartView:PieChartView) {
    
          // 1. Set ChartDataEntry
          
          // 2. Set ChartDataSet
            
          // 3. Set ChartData
         
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
    
    
    
    
    
//    func customizeChart(dataPoints: [String], values: [Double],pieChartView:PieChartView) {
//
//      // 1. Set ChartDataEntry
//      var dataEntries: [ChartDataEntry] = []
//      for i in 0..<dataPoints.count {
//        let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: "" as AnyObject)
//        dataEntries.append(dataEntry)
//      }
//      // 2. Set ChartDataSet
//        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "nil")
//      pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
//      // 3. Set ChartData
//      let pieChartData = PieChartData(dataSet: pieChartDataSet)
//      let format = NumberFormatter()
//      format.numberStyle = .none
//      let formatter = DefaultValueFormatter(formatter: format)
//      pieChartData.setValueFormatter(formatter)
//      // 4. Assign it to the chart’s data
//      pieChartView.data = pieChartData
//    }
//
//    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
//      var colors: [UIColor] = []
//      for _ in 0..<numbersOfColor {
//        let red = Double(arc4random_uniform(256))
//        let green = Double(arc4random_uniform(256))
//        let blue = Double(arc4random_uniform(256))
//        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
//        colors.append(color)
//      }
//      return colors
//    }
//
    
    
    
    
    
    
    
    @IBAction func marketValue(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TradingValue") as! TradingValue
        vc.modalPresentationStyle = .fullScreen
  

        vc.tradeAnlysis = self.tradeAnlysis
        
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
  

                                                }
                                            }
                                    
                                        }
    //                             Session ID is Expired
                                else if status == 400{
                                    let msg = jsonObj!["message"] as? String
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
    
    
    //    API Call for pie chart
    
    func getInvestoreInfo(){
//
        let hud = JGProgressHUD(style: .light)
//        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)

    
        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": "en" ,
                                    "with_zero" : 1
 ]
     
        let link = URL(string: APIConfig.GetInvOwnership)

        AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                   

                    if jsonObj != nil {
                        if let status = jsonObj!["status"] as? Int {
                            if status == 200 {
                                
                                if let total = jsonObj!["total"] as? [String: Any]{
                                    if let one = total["1"] as? [String: Any] {
                                        let model = SectorAnylisisModel(data: total)
                                        self.total = model
                                        
                                    }
                                }
                                
                                if let ownershipBysector = jsonObj!["ownershipBysector"] as? [String: Any]{
                                    if let one = ownershipBysector["1"] as? [String: Any] {
                                        
                                        if let banks = one["Banks"] as? [String: Any] {
                                            
                                            let model = SectorAnylisisModel(data: banks)
                                            self.bank = model
                                            self.quantities.append(model.Quantity ?? 0)
                                            self.securities.append(model.sec_count ?? 0)
                                            self.marketValues.append(model.market_value ?? 0 )
                                        }
                                        
                                        if let insurance = one["insurance"] as? [String: Any] {
                                            let model = SectorAnylisisModel(data: insurance)
                                            self.insuarance = model
                                            self.quantities.append(model.Quantity ?? 0)
                                            self.securities.append(model.sec_count ?? 0)
                                            self.marketValues.append(model.market_value ?? 0)
                                        }
                                        
                                        if let industry = one["Industry"] as? [String: Any] {
                                            
                                            let model = SectorAnylisisModel(data: industry)
                                            self.industry = model
                                    self.quantities.append(model.Quantity ?? 0)
                                            self.securities.append(model.sec_count ?? 0)
                                            self.marketValues.append(model.market_value ?? 0)
                                        }
                                        
                                        if let Services = one["Services"] as? [String: Any] {
                                            
                                            let model = SectorAnylisisModel(data: Services)
                                            self.service = model
                                            self.quantities.append(model.Quantity ?? 0)
                                            self.securities.append(model.sec_count ?? 0)
                                            self.marketValues.append(model.market_value ?? 0)
                                        }
                                        
                                        if let industry = one["Industry"] as? [String: Any] {
                                            let model = SectorAnylisisModel(data: industry)
                                            self.industry = model
                                            self.quantities.append(model.Quantity ?? 0)
                                            self.securities.append(model.sec_count ?? 0)
                                            self.marketValues.append(model.market_value ?? 0)
                                        }
                                        
                                        
                                    }
                                }
                                
                                
                                    
                               
                                            DispatchQueue.main.async {
                                                self.anlyssSection.reloadData()
                                    hud.dismiss()


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
                                    
                                    self.lastloginInfo.text  =    MOLHLanguage.isRTLLanguage() ? self.convertDateAndTimeToArabicNumbers(dateString: sysDate ?? ""): sysDate ?? ""
                                    
                                    //convertDateToArabicNumbers
                                   
                                    
//                                    self.lastloginInfo.text =  sysDate ?? "" +  (lastUpdate ?? "")
//
                                        
                            
                                    
                                    
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
