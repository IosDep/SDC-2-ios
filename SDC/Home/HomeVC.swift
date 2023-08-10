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

class HomeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource  {
    
    
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var dayLogin: UILabel!
    @IBOutlet weak var dayUpdate: UILabel!
    @IBOutlet weak var lastUpdateInfo: UILabel!
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
    var currencyFlag : String?
    var updatedDay : String?
    var loginDay : String?
    
    var bank = SectorAnylisisModel(data: [:])
    var insuarance = SectorAnylisisModel(data: [:])
    var service = SectorAnylisisModel(data: [:])
    var industrry = SectorAnylisisModel(data: [:])
    var totalAnlysis = SectorAnylisisModel(data: [:])
    var quantities : [Double] = []
    var securities  : [Double] = []
    var marketValues : [Double] = []
    var categories = [String]()
    var pieTableHolder = [PieTableHolder]()
    var notifications = [NotificationModel]()

    var dbank = SectorAnylisisModel(data: [:])
    var dinsuarance = SectorAnylisisModel(data: [:])
    var dservice = SectorAnylisisModel(data: [:])
    var dindustry = SectorAnylisisModel(data: [:])
    var dtotalAnlysis = SectorAnylisisModel(data: [:])
    var dquantities : [Double] = []
    var dsecurities  : [Double] = []
    var dmarketValues : [Double] = []
    var dpieTableHolder = [PieTableHolder]()
    
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
    
    //function for change background selected background color for with and without zero btn
    
    func highlightedButtons() {
        self.busnissCard.reloadData()
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
        currencyFlag = "22"
        
        DispatchQueue.main.async {
            
            self.anlyssSection.reloadData()
            
        }
        
        isDolarSelected = true
        isDinarSelected = false
        highlightedButtons()
    }
    
    
    @IBAction func dinarPressed(_ sender: Any) {
        currencyFlag = "1"
        DispatchQueue.main.async {
        
            self.anlyssSection.reloadData()
        }
        isDolarSelected = false
        isDinarSelected = true
        highlightedButtons()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeImage.sd_setImage(with: URL(string: WelcomePageVC.homeImage ?? ""))
        
        self.busnissCard.tag = 1
        self.anlyssSection.tag = 2
        currencyFlag = "1"
        
//        self.getInvestoreInfo()
        isDolarSelected = false
        isDinarSelected = true
        highlightedButtons()
        
        self.getNotificationInfo()
        
        if checkSideMenu == true {
            sideMenuBtn.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        }
        else {
            sideMenuBtn.setImage(UIImage(named: "menus"), for: .normal)
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
        collLayout.itemSize = CGSize(width: 300, height: 200)
        
        collLayouta.scrollDirection = UICollectionView.ScrollDirection.horizontal
        collLayouta.itemSize = CGSize(width: 300, height: 140)
        self.busnissCard.backgroundColor = .clear
        self.busnissCard.setCollectionViewLayout(collLayouta, animated: false)
        self.busnissCard.bouncesZoom = false
        self.busnissCard.bounces = false
        self.busnissCard.isDirectionalLockEnabled  = false
        self.categories = ["Banks" , "insurance" , "Services" , "Industry"]
        self.anlyssSection.backgroundColor = .clear
        self.anlyssSection.setCollectionViewLayout(collLayout, animated: false)

        self.getLastTrans()
        
        self.getLastDate()
        
        if  MOLHLanguage.isRTLLanguage() == true {
           
         busnissCard.semanticContentAttribute = .forceRightToLeft
        }
        
        else {
            busnissCard.semanticContentAttribute = .forceLeftToRight
        }
        
    }
    
    
    @IBAction func setupMenu(_ sender: Any) {
        
        if self.checkSideMenu == true {
            self.dismiss(animated: true)
        }
        else if checkSideMenu == false {
            self.side_menu()
        }
        
    }
    
    func getAllData() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        self.getInvestoreInfo()
        dispatchGroup.leave()
        
        dispatchGroup.enter()
        self.getLastTrans()
        dispatchGroup.leave()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == busnissCard {
            
            return lastTransarr.count
            
        }
        
        else if collectionView == anlyssSection {
            return 3
        }
        
        else {
            return 0
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == busnissCard {
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "CardThereVc") as! CardThereVc
            vc.modalPresentationStyle = .fullScreen
            vc.trans = self.lastTransarr[indexPath.row]
        
            self.present(vc, animated: true)
        }
        
        else if collectionView == anlyssSection {
            
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PieChartPopUp") as! PieChartPopUp
            
            vc.bank = self.bank
            vc.insuarance = self.insuarance
            vc.service = self.service
            vc.industry = self.industrry
            
            if currencyFlag == "1" {
                vc.totalAnlysis = totalAnlysis

            }
            
            else if currencyFlag == "22" {
                vc.totalAnlysis = dtotalAnlysis

            }
//            vc.pieFlag = indexPath.row
        
            if currencyFlag == "1" {
                vc.pieTableHolder = self.pieTableHolder

            }
            
            else if currencyFlag == "22" {
                vc.pieTableHolder = self.dpieTableHolder

            }

            if indexPath.row == 0 {
                if currencyFlag == "1" {
                    vc.chartValues = securities
                }
                else if currencyFlag == "22" {
                    vc.chartValues = dsecurities
                }
                
                vc.pieFlag = 0
            }
            
            else if indexPath.row == 1 {
                
                if currencyFlag == "1" {
                    vc.chartValues = quantities
                }
                else if currencyFlag == "22" {
                    vc.chartValues = dquantities
                }

                vc.pieFlag = 1
            }
            
            else if indexPath.row == 2 {
                if currencyFlag == "1" {
                    vc.chartValues = marketValues
                }
                else if currencyFlag == "22" {
                    vc.chartValues = dmarketValues
                }

                vc.pieFlag = 2
            }
            
            vc.modalPresentationStyle = .popover
            self.present(vc, animated: true)

        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == busnissCard {
            var cell = self.busnissCard.dequeueReusableCell(withReuseIdentifier: "BusnissCard", for: indexPath) as? BusnissCard
            
            if cell == nil {
                
                self.busnissCard.register(UINib(nibName: "BusnissCard", bundle: nil), forCellWithReuseIdentifier: "BusnissCard")
                cell = self.busnissCard.dequeueReusableCell(withReuseIdentifier: "BusnissCard", for: indexPath) as? BusnissCard
                //                let nib: [Any] = Bundle.main.loadNibNamed("BusnissCard", owner: self, options: nil)!
                //                cell = nib[0] as? BusnissCard
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
            
            cell?.firstlbl.text = data.Security_Reuter_Code ?? ""
            
            cell?.secondlbl.text = data.Security_Name
            
            cell?.theredlbl.text =  data.Quantity ??  ""
            
            return cell!
            
        }
        
        else {
            
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
            
            
            
            if indexPath.row == 0 {
                
                if currencyFlag == "1" {
                    
                    
                    cell?.title.text = "Shareholders" .localized()
                    
                    if (securities.count != 0)  {
                        customizeChart(dataPoints: categories, values: securities,pieChartView: (cell?.chartView!)!)
                        cell?.logo.image = UIImage(named: "shareholder")
                    }
                    
                }
                
                else if currencyFlag == "22" {
                    
                    cell?.title.text = "Shareholders" .localized()
                    
                    if (dsecurities.count != 0)  {
                        customizeChart(dataPoints: categories, values: dsecurities,pieChartView: (cell?.chartView!)!)
                        cell?.logo.image = UIImage(named: "shareholder")
                    }
                }
            }
            
            else if indexPath.row == 1 {
                
                if currencyFlag == "1" {
                    
                    if (quantities.count != 0)  {
                        cell?.title.text = "Securities" .localized()
                        customizeChart(dataPoints: categories, values: quantities,pieChartView: (cell?.chartView!)!)
                        cell?.logo.image = UIImage(named: "securities")
                        
                    }
                }
                
                else if currencyFlag == "22" {
                    
                    if (dquantities.count != 0)  {
                        cell?.title.text = "Securities" .localized()
                        customizeChart(dataPoints: categories, values: dquantities,pieChartView: (cell?.chartView!)!)
                        cell?.logo.image = UIImage(named: "securities")
                        
                    }
                }
            }
                
                else if indexPath.row == 2 {
                    
                    if currencyFlag == "1" {
                        if (marketValues.count != 0)  {
                            
                                cell?.title.text = "Market Value" .localized()
                                customizeChart(dataPoints: categories, values: marketValues ,pieChartView: (cell?.chartView!)!)
                                cell?.logo.image = UIImage(named: "marketValue")
                            }
                            
                           
                        }
                    
                  else if currencyFlag == "22" {
                        if (dmarketValues.count != 0)  {
                            
                                cell?.title.text = "Market Value" .localized()
                                customizeChart(dataPoints: categories, values: dmarketValues ,pieChartView: (cell?.chartView!)!)
                                cell?.logo.image = UIImage(named: "marketValue")
                            }
                            
                           
                        }
                }
            
            
//             if currencyFlag == "22" {
//
//                if indexPath.row == 0 {
//
//                    cell?.title.text = "Shareholders" .localized()
//
//                    if (dsecurities.count != 0)  {
//                        customizeChart(dataPoints: categories, values: dsecurities,pieChartView: (cell?.chartView!)!)
//                        cell?.logo.image = UIImage(named: "shareholder")
//                    }
//
//                }
//
//               else if indexPath.row == 1 {
//
//                       if (dquantities.count != 0)  {
//                           cell?.title.text = "Securities" .localized()
//                            customizeChart(dataPoints: categories, values: dquantities,pieChartView: (cell?.chartView!)!)
//                           cell?.logo.image = UIImage(named: "securities")
//
//                       }
//                            }
//
//                else if indexPath.row == 2 {
//
//                        if (dmarketValues.count != 0)  {
//
//                            cell?.title.text = "Market Value" .localized()
//                            customizeChart(dataPoints: categories, values: dmarketValues ,pieChartView: (cell?.chartView!)!)
//                            cell?.logo.image = UIImage(named: "marketValue")
//                        }
//                }
//            }
       
            return cell!
  
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
                  ,   UIColor(red: 0.30, green: 0.76, blue: 0.55, alpha: 1.00) , UIColor(red: 0.82, green: 0.83, blue: 0.84, alpha: 1.00) ]
        return colors
    }
    
    
   
    
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
                                    
                                    
                                }
                                DispatchQueue.main.async {
                                    self.busnissCard.reloadData()
                                    self.getInvestoreInfo()
                                    hud.dismiss()
                                    
                                    
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
        
        
        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang":"en",
                                    "with_zero" : "1"
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
                                        let model = SectorAnylisisModel(data: one)
                                        self.totalAnlysis = model
                                        
                                    }
                                    
                                    if let dolar = total["22"] as? [String: Any] {
                                        let model = SectorAnylisisModel(data: dolar)
                                        self.dtotalAnlysis = model
                                        
                                    }
                                }
                                
                                if let ownershipBysector = jsonObj!["ownershipBysector"] as? [String: Any]{
                                    if let one = ownershipBysector["1"] as? [String: Any] {
                                        
                                        if let banks = one["Banks"] as? [String: Any] {
                                            
                                            let model = SectorAnylisisModel(data: banks)
                                            
                                            self.bank = model
                                            
                                            let qun = ( model.Quantity! / (self.totalAnlysis.Quantity ?? 0.0) ) * 100
                                            
                                            let sec = ( model.sec_count! / (self.totalAnlysis.sec_count ?? 0.0) ) * 100
                                            
                                            let marketVal = ( model.market_value! / (self.totalAnlysis.market_value ?? 0.0) ) * 100
                                            
                                            
                                            
                                            self.quantities.append(qun)
                                            
                                            
                                            self.securities.append(sec)
                                            
                                           
                                                self.marketValues.append(marketVal)
                                        
                                        
                                        }
                                        
                                        if let insurance = one["Insurance"] as? [String: Any] {
                                            let model = SectorAnylisisModel(data: insurance)
                                            
                                            self.insuarance = model
                                            
                                            let qun = ( self.insuarance.Quantity! / (self.totalAnlysis.Quantity ?? 0.0) ) * 100
                                            
                                            let sec = ( model.sec_count! / (self.totalAnlysis.sec_count ?? 0.0) ) * 100
                                            
                                            let marketVal = ( model.market_value! / (self.totalAnlysis.market_value ?? 0.0) ) * 100
                                            
                                            self.quantities.append(qun)
                                            self.securities.append(sec)
                                            self.marketValues.append(marketVal )
                                        }
                                        
                                        
                                        if let Services = one["Services"] as? [String: Any] {
                                            
                                            let model = SectorAnylisisModel(data: Services)
                                            
                                            self.service = model
                                            
                                            let qun = ( model.Quantity! / (self.totalAnlysis.Quantity ?? 0.0) ) * 100
                                            
                                            let sec = ( model.sec_count! / (self.totalAnlysis.sec_count ?? 0.0) ) * 100
                                            
                                            let marketVal = ( model.market_value! / (self.totalAnlysis.market_value ?? 0.0) ) * 100
                                            
                                            self.quantities.append(qun)
                                            self.securities.append(sec)
                                            self.marketValues.append(marketVal )
                                        }
                                        
                                        if let industry = one["Industry"] as? [String: Any] {
                                            
                                            let model = SectorAnylisisModel(data: industry)
                                            self.industrry = model
                                            let qun = ( model.Quantity! / (self.totalAnlysis.Quantity ?? 0.0) ) * 100
                                            
                                            let sec = ( model.sec_count! / (self.totalAnlysis.sec_count ?? 0.0) ) * 100
                                            
                                            let marketVal = ( model.market_value! / (self.totalAnlysis.market_value ?? 0.0) ) * 100
                                            
                                            self.quantities.append(qun)
                                            self.securities.append(sec)
                                            self.marketValues.append(marketVal )
                                        }
                                        
                                        
                                        if self.bank.sec_count != 0 && self.bank.Quantity != 0 && self.bank.market_value != 0 {
                                            self.pieTableHolder.append(PieTableHolder(title: "Bank".localized(), array: self.bank, color: UIColor(named: "BankColor")!))
                                        }
                                        
                                         if self.insuarance.sec_count != 0 && self.insuarance.Quantity != 0 && self.insuarance.market_value != 0 {
                                             self.pieTableHolder.append(PieTableHolder(title: "Insurance".localized(), array: self.insuarance, color: UIColor(named: "InsuranceCollor")!))
                                        }
                                        
                                         if self.service.sec_count != 0 && self.service.Quantity != 0 && self.service.market_value != 0 {
                                            self.pieTableHolder.append(PieTableHolder(title: "Services".localized(), array: self.service , color: UIColor(named: "ServiceColor")!))
                                        }
                                        
                                        if self.industrry.sec_count != 0 && self.industrry.Quantity != 0 && self.industrry.market_value != 0 {
                                            self.pieTableHolder.append(PieTableHolder(title: "Industry".localized(), array: self.industrry , color: UIColor(named: "industryColor")!))
                                        }
                                        
                                    }
                                    
                                    if let dolar = ownershipBysector["22"] as? [String: Any] {
                                        
                                        if let banks = dolar["Banks"] as? [String: Any] {
                                            
                                            let model = SectorAnylisisModel(data: banks)
                                            
                                            self.dbank = model
                                            
                                            let dqun = ( model.Quantity! / (self.dtotalAnlysis.Quantity ?? 0.0) ) * 100
                                            
                                            let dsec = ( model.sec_count! / (self.dtotalAnlysis.sec_count ?? 0.0) ) * 100
                                            
                                            let dmarketVal = ( model.market_value! / (self.dtotalAnlysis.market_value ?? 0.0) ) * 100
                                            
                                            
                                            
                                    self.dquantities.append(dqun)
                                            
                                    self.dsecurities.append(dsec)
                                            
                                    self.dmarketValues.append(dmarketVal)
                                            
                                            
                                        }
                                        
                                    if let insurance = dolar["Insurance"] as? [String: Any] {
                                            let model = SectorAnylisisModel(data: insurance)
                                            
                                    self.dinsuarance = model
                                            
                                            let dqun = ( self.insuarance.Quantity! / (self.dtotalAnlysis.Quantity ?? 0.0) ) * 100
                                            
                                            let dsec = ( model.sec_count! / (self.dtotalAnlysis.sec_count ?? 0.0) ) * 100
                                            
                                            let dmarketVal = ( model.market_value! / (self.dtotalAnlysis.market_value ?? 0.0) ) * 100
                                            
                                        self.dquantities.append(dqun)
                                        self.dsecurities.append(dsec)
                                        self.dmarketValues.append(dmarketVal )
                                        }
                                        
                                        
                                        if let Services = dolar["Services"] as? [String: Any] {
                                            
                                            let model = SectorAnylisisModel(data: Services)
                                            
                                            self.dservice = model
                                            
                                            let dqun = ( model.Quantity! / (self.dtotalAnlysis.Quantity ?? 0.0) ) * 100
                                            
                                            let dsec = ( model.sec_count! / (self.dtotalAnlysis.sec_count ?? 0.0) ) * 100
                                            
                                            let dmarketVal = ( model.market_value! / (self.dtotalAnlysis.market_value ?? 0.0) ) * 100
                                            
                                            self.dquantities.append(dqun)
                                            self.dsecurities.append(dsec)
                                            self.dmarketValues.append(dmarketVal)
                                        }
                                        
                                        if let industry = dolar["Industry"] as? [String: Any] {
                                            
                                            let model = SectorAnylisisModel(data: industry)
                                            self.dindustry = model
                                            let dqun = ( model.Quantity! / (self.dtotalAnlysis.Quantity ?? 0.0) ) * 100
                                            
                                            let dsec = ( model.sec_count! / (self.dtotalAnlysis.sec_count ?? 0.0) ) * 100
                                            
                                            let dmarketVal = ( model.market_value! / (self.dtotalAnlysis.market_value ?? 0.0) ) * 100
                                            
                                            self.dquantities.append(dqun)
                                            self.dsecurities.append(dsec)
                                            self.dmarketValues.append(dmarketVal )
                                        }
                                        
                                        
                                        if self.dbank.sec_count != 0 && self.dbank.Quantity != 0 && self.dbank.market_value != 0 {
                                            self.dpieTableHolder.append(PieTableHolder(title: "Bank".localized(), array: self.dbank , color: UIColor(named: "BankColor")!))
                                        }
                                        
                                        else if self.dinsuarance.sec_count != 0 && self.dinsuarance.Quantity != 0 && self.dinsuarance.market_value != 0 {
                                            self.dpieTableHolder.append(PieTableHolder(title: "Insurance".localized(), array: self.dinsuarance , color: UIColor(named: "InsuranceCollor")!))
                                        }
                                        
                                        else if self.dservice.sec_count != 0 && self.dservice.Quantity != 0 && self.dservice.market_value != 0 {
                                            self.dpieTableHolder.append(PieTableHolder(title: "Services".localized(), array: self.dservice , color: UIColor(named: "ServiceColor")!))
                                        }
                                        
                                        else if self.dindustry.sec_count != 0 && self.dindustry.Quantity != 0 && self.dindustry.market_value != 0 {
                                            self.dpieTableHolder.append(PieTableHolder(title: "Industry".localized(), array: self.dindustry , color: UIColor(named: "industryColor")!))
                                        }
                                        
                                    }
                                    
                                    
                                    
                                    
                                }
                                
                                DispatchQueue.main.async {
                                    self.anlyssSection.reloadData()
//                                    self.busnissCard.reloadData()
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
                                        //                                                    self.anlyssSection.reloadData()
                                        
                                        
                                        self.yearArray = self.ownershapeAnlusis.map { $0.Market_Value_Buy ?? "" }
                                        //                                                    self.categoryArray = self.ownershapeAnlusis.map{ $0.Month ?? "" }
                                        
                                        
                                        
                                        print("MYUERAAARAY")
                                        print(self.yearArray)
                                        //                                                    print(self.categoryArray)
                                        
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
                                
                                self.loginDay = self.getDayOfWeek(dateTimeString: sysDate ?? "")
                               
                                
                                let lastUpdate =     data!["lastUpdate"] as? String
                                                                
                                self.updatedDay = self.getDayOfWeek(dateTimeString: lastUpdate ?? "")
                                
                                
                                self.lastloginInfo.text  = ((self.loginDay ?? "") + " " + (sysDate ?? ""))
                                self.lastUpdateInfo.text = ((self.updatedDay ?? "") + " " + (lastUpdate ?? "") )
                                
                                
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
    
//    func getTradingValue(){
//        let hud = JGProgressHUD(style: .light)
//        //        hud.textLabel.text = "Please Wait".localized()
//        hud.show(in: self.view)
//
//        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": MOLHLanguage.isRTLLanguage() ? "ar": "en", "date":"2020-01-07"
//        ]
//
//        let link = URL(string: APIConfig.TradesAnalysis)
//
//        AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
//            if response.error == nil {
//                do {
//                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
//
//
//                    if jsonObj != nil {
//
//
//
//
//                        if let status = jsonObj!["status"] as? Int {
//                            if status == 200 {
//
//
//                                if let data = jsonObj!["data"] as? [[String: Any]]{
//                                    for item in data {
//                                        let model = TradeAnlysis(data: item)
//                                        self.tradeAnlysis.append(model)
//
//                                    }
//
//                                    DispatchQueue.main.async {
//
//
//
//                                        TradingValue.monthData = self.tradeAnlysis.map { $0.Month ?? "" }
//                                        TradingValue.valueChart = self.tradeAnlysis.map{ Double($0.Market_Value_Sell ?? "") ?? 0.0 }
//
//                                        print("MYUERAAARAY")
//                                        print(self.monthData)
//                                        print(TradingValue.valueChart )
//
//
//                                        hud.dismiss()
//
//
//                                    }
//                                }
//
//                            }
//                            //                             Session ID is Expired
//                            else if status == 404{
//                                let msg = jsonObj!["message"] as? String
//                                //                                self.showErrorHud(msg: msg ?? "")
//                                self.seassionExpired(msg: msg ?? "")
//                            }
//
//                            //                                other Wise Problem
//                            else {
//                                hud.dismiss(animated: true)      }
//
//                        }
//
//                    }
//
//                } catch let err as NSError {
//                    print("Error: \(err)")
//                    self.serverError(hud: hud)
//                }
//            } else {
//                print("Error")
//
//                self.serverError(hud: hud)
//
//            }
//        }
//    }
    
    func getNotificationInfo(){
//
        let hud = JGProgressHUD(style: .light)
//        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)

        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": MOLHLanguage.isRTLLanguage() ? "ar": "en"
 ]
     
        let link = URL(string: APIConfig.GetNotfication)

        AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                   

                    if jsonObj != nil {
                        if let status = jsonObj!["status"] as? Int {
                            if status == 200 {
                                if let data = jsonObj!["notifications"] as? [[String: Any]]{
                                            for item in data {
                                                let model = NotificationModel(data: item)
                                                self.notifications.append(model)
                                 
                                            }
                                    
                                    Helper.shared.saveNotificationCount(count: self.notifications.count ?? 0)
                                    
                                    let notcount = "\(Helper.shared.getNotificationCount()!)"
                                    self.cerateBellView(bellview: self.bellView, count: notcount)
                                    
                                        }
                                
                                DispatchQueue.main.async {
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
    
    func getDayOfWeek(dateTimeString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        // Get the app's preferred language
        let preferredLanguage = Locale.preferredLanguages.first ?? "en"
        
        // Set the locale based on the preferred language
        dateFormatter.locale = Locale(identifier: preferredLanguage)
        
        if let dateTime = dateFormatter.date(from: dateTimeString) {
            let calendar = Calendar.current
            let components = calendar.component(.weekday, from: dateTime)
            
            // Get the weekday symbols based on the app's language
            let weekdaySymbols = dateFormatter.weekdaySymbols
            
            // Adjust the index to align with the weekday symbols array
            let weekday = weekdaySymbols?[components - 1]
            return weekday
        } else {
            return nil
        }
    }

    
    
}

struct PieTableHolder {
    var title : String
    var array : SectorAnylisisModel
    var color : UIColor
}
