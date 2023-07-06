//
//  OnePaperOwnerShape.swift
//  SDC
//
//  Created by Blue Ray on 15/04/2023.
//

import UIKit
import Alamofire
import MOLH
import JGProgressHUD

struct SecurityOwnerShapeHolder {
    var title: String?
    var array: [SecurityOwnership]?
}



class OnePaperOwnerShape: UIViewController ,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UISearchBarDelegate , DataSelectedDelegate , SelectedNatDelegate{
    
    
    @IBOutlet weak var searchStack: UIStackView!
    
    @IBOutlet weak var staticCellInfo: UIView!
    @IBOutlet weak var securityNameLabel: UIButton!
    @IBOutlet weak var withZero: DesignableButton!
    @IBOutlet weak var withoutZero: DesignableButton!
    @IBOutlet weak var paperNameBtn: UIButton!
    @IBOutlet weak var search_bar: UISearchBar!
    @IBOutlet weak var literalNumBtn: UIButton!
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var busnissCard: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerConstrianett: NSLayoutConstraint!
    @IBOutlet weak var staticCellView: UIView!
    @IBOutlet weak var isinLabel: UILabel!
    @IBOutlet weak var reuterCode: UILabel!
    @IBOutlet weak var secNameLabel: UILabel!
    @IBOutlet weak var secStatusLabel: UILabel!
    @IBOutlet weak var secMarketLabel: UILabel!
    
//    @IBOutlet weak var bellView: UIView!
    
    var totalDolar : Double?
    var totalDinar : Double?
    var currencyFlag : String?
    var isSearching = false

    
    var dinarData, filteredData , dolarData , dolarFilteredData: [SecurityOwnerShapeHolder]?
    
    var dinarArray = [SecurityOwnership]()
    var dolarArray = [SecurityOwnership]()
    var dataArray = [PartialDataModel]()
    
    
    var memberId:String = ""
    var balanceType:String = ""
    var accountNo:String = ""
    var securityId:String = ""
    var invAccount = [InvestoreOwnerShape]()
    var securityOwnership = [SecurityOwnership]()
    var arr_search = [InvestoreOwnerShape]()
    var secData = [SecurityData]()
    var isZeroSelected : Bool?
    var isWithoutSelected : Bool?
    var withZeroFlag : String?
    var refreshControl: UIRefreshControl!
    var seatrching = false
    var numberCode = [String]()
    var securityName = [String]()
    var selectedPaperName : String?
    var selectedLiteralNum : String?
    var checkSideMenu = false
    var securtyIdToCallApi:String?
    var previousScrollViewYOffset: CGFloat = 0
    var headerViewIsHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchStack.isHidden = true
        staticCellInfo.isHidden = true
        
        if checkSideMenu == true {
            sideMenuBtn.setImage(UIImage(named: ""), for: .normal)
        }
        
//        self.cerateBellView(bellview: bellView, count: "12")
        self.getInvestoreInfo(withZero: withZeroFlag ?? "")
        self.busnissCard.delegate = self
        self.busnissCard.dataSource = self
        self.busnissCard.register(UINib(nibName: "BusnissCardTable", bundle: nil), forCellReuseIdentifier: "BusnissCardTable")
        busnissCard.register(UINib(nibName: "SectionNameView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "SectionNameView")
        search_bar.delegate = self
        //refreshControl
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        self.busnissCard.addSubview(refreshControl)
    }
    
    //    refresh action
    @objc func didPullToRefresh() {
        self.invAccount.removeAll()
//        self.busnissCard.reloadData()
        
    }
    
    
    
    @IBAction func currencyPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CurrencyPicker") as! CurrencyPicker
        vc.selectedNatDelegate = self
        self.present(vc, animated: true)
    }
    
    
    
    //    Tableview Configration
    
    
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        search_bar.text = ""
        dinarData?.removeAll()
        dolarData?.removeAll()
        searchStack.isHidden = true
        staticCellInfo.isHidden = true
        seatrching = false
        busnissCard.reloadData()
    }
    
    
    // jod usd option
    
    func getSelectdPicker(selectdTxt: String, flag: String) {
//        currencyBtn.setTitle(selectdTxt, for: .normal)
//        if flag == "1" {
//            totalValue.text = self.numFormat(value: totalDinar ?? 0.0)
//            self.currencyFlag = "1"
//        }
//        else if flag == "22"{
//            totalValue.text = self.numFormat(value: totalDolar ?? 0.0)
//            self.currencyFlag = "22"
//        }
//
//        DispatchQueue.main.async {
//            self.busnissCard.reloadData()
//
//
//        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !isSearching {
                if let dinarData {
                    let newData = dinarData.filter({!($0.array?.isEmpty ?? true)})
                    return newData.count
                }
           
        }
        
        else {
                if let filteredData {
                    let newData = filteredData.filter({!($0.array?.isEmpty ?? true)})
                    return newData.count
                
            }
        }
        
        return 0
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
                if let filteredData {
                    let newData = filteredData.filter({!($0.array?.isEmpty ?? true)})
                    return newData[section].array?.count ?? 0
                }
            
        }
       
        
        else {
                if let dinarData {
                    let newData = dinarData.filter({!($0.array?.isEmpty ?? true)})
                    return newData[section].array?.count ?? 0
                }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = busnissCard.dequeueReusableHeaderFooterView(withIdentifier: "SectionNameView") as! SectionNameView
        if !isSearching {
            
                if let dinarData {
                    let newData = dinarData.filter({!($0.array?.isEmpty ?? true)})
                    headerView.sectionName.text = newData[section].title ?? ""
                }
            
                if let dolarData {
                    let newData = dolarData.filter({!($0.array?.isEmpty ?? true)})
                    headerView.sectionName.text = newData[section].title ?? ""
                }
        }
        
        else {
                if let filteredData {
                    let newData = filteredData.filter({!($0.array?.isEmpty ?? true)})
                    headerView.sectionName.text = newData[section].title ?? ""
                }
            }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CardOneVC") as! CardOneVC
        vc.checkOnepaper = true
        vc.modalPresentationStyle = .fullScreen
        
        if !isSearching {
                if let dinarData {
                    let newData = dinarData.filter({!($0.array?.isEmpty ?? true)})
                    vc.securityOwnership = newData[indexPath.section].array?[indexPath.row]
                }
        }
        
        
        else {
            if let filteredData {
                    let newData = filteredData.filter({!($0.array?.isEmpty ?? true)})
                    vc.securityOwnership = newData[indexPath.section].array?[indexPath.row]
                }
        }
        self.present(vc, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = self.busnissCard.dequeueReusableCell(withIdentifier: "BusnissCardTable", for: indexPath) as? BusnissCardTable
        
        
        cell?.addtionalStack.isHidden = true
        cell?.firstLbl.text = "Corporation name".localized()
        cell?.secondLbl.text = "Corporation ID".localized()
        cell?.thirdLbl.text = "Action description".localized()
        
        
//            cell?.literalName.text = securityOwnership[indexPath.row].Security_Name
//        cell?.literalNum.text =  securityOwnership[indexPath.row].Security_Id ?? ""
//
//        cell?.sector.text =  securityOwnership[indexPath.row].Security_Sector_Desc ?? ""
//
//        cell?.balance.text = self.doubleToArabic(value: securityOwnership[indexPath.row].Security_Close_Price ?? "")
            
            
        cell?.mainCardView.layer.cornerRadius =  25
        
        if isSearching  {
            
                if let filteredData {
                    let newData = filteredData.filter({!($0.array?.isEmpty ?? true)})
                    cell?.literalName.text = newData[indexPath.section].array?[indexPath.row].Security_Reuter_Code ?? ""
                    cell?.literalNum.text =  newData[indexPath.section].array?[indexPath.row].Security_Isin  ?? ""
                    
                    cell?.sector.text = newData[indexPath.section].array?[indexPath.row].Security_Name ?? ""
                    
                    cell?.balance.text =  self.numStringFormat(value: newData[indexPath.section].array?[indexPath.row].Quantity_Owned ?? "")
                }
            
        }
        
        
        
        else {
                if let dinarData {
                    let newData = dinarData.filter({!($0.array?.isEmpty ?? true)})
                    cell?.literalName.text = newData[indexPath.section].array?[indexPath.row].Security_Reuter_Code ?? ""
                    cell?.literalNum.text =  newData[indexPath.section].array?[indexPath.row].Security_Isin  ?? ""
                    
                    cell?.sector.text = newData[indexPath.section].array?[indexPath.row].Security_Name ?? ""
                    
                    cell?.balance.text =  self.numStringFormat(value: newData[indexPath.section].array?[indexPath.row].Quantity_Owned ?? "")
                }
        }
        
        return cell!

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate && scrollView.contentOffset.y == 0 {
            
            // scrolling down
            if !headerViewIsHidden {
                
                headerViewIsHidden = true
                headerConstrianett.constant = 850
                
                
                UIView.animate(withDuration: 0.2) {
                    self.headerView.alpha = 0
                }
            }
        } else {
            // scrolling up
            if headerViewIsHidden {
                headerConstrianett.constant = 310
                
                headerViewIsHidden = false
                UIView.animate(withDuration: 0.2) {
                    self.headerView.alpha = 1
                    
                }
            }
        }
        
    }
    
    
    
    @IBAction func clearPressed(_ sender: Any) {
        securityNameLabel
        securityOwnership.removeAll()
//        self.busnissCard.reloadData()
        
    }
    
    
    @IBAction func withZeero(btn:UIButton){
//        self.securityOwnership.removeAll()
//        self.dinarData?.removeAll()
//        self.filteredData?.removeAll()
//        self.paperNameBtn.setTitle("-", for: .normal)
//        searchStack.isHidden = true
//        withZeroFlag = "2"
//        isZeroSelected = true
//        isWithoutSelected = false
//        highlightedButtons()
        
    }
    
    //function for change background selected background color for with and without zero btn
//
//    func highlightedButtons() {
////        busnissCard.reloadData()
//        if isZeroSelected  == true && isWithoutSelected == false {
//            DispatchQueue.main.async { [self] in
//                self.withZero.setTitleColor(.white, for: .normal)
//                self.withZero.backgroundColor  = UIColor(named: "AccentColor")
//                self.withoutZero.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
//                self.withoutZero.backgroundColor  = .white
////                self.withoutZero.cornerRadius = 12
//                self.withoutZero.borderColor =  UIColor(named: "AccentColor")
//                self.withoutZero.borderWidth = 1
//
//            }
//        }
//        else if isZeroSelected == false  && isWithoutSelected == true {
//            DispatchQueue.main.async {
//                self.withoutZero.setTitleColor(.white, for: .normal)
//                self.withoutZero.backgroundColor  = UIColor(named: "AccentColor")
//                self.withZero.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
//                self.withZero.backgroundColor  = .white
////                self.withZero.cornerRadius = 12
//                self.withZero.borderColor =  UIColor(named: "AccentColor")
//                self.withZero.borderWidth = 1
//
//            }
//        }
//
//    }
    
    
    @IBAction func withoutZeero(btn:UIButton){
//        self.securityOwnership.removeAll()
//        self.dinarData?.removeAll()
//        self.filteredData?.removeAll()
//        self.paperNameBtn.setTitle("-", for: .normal)
//        searchStack.isHidden = true
//        withZeroFlag = "1"
//        isWithoutSelected = true
//        isZeroSelected = false
//        highlightedButtons()

    }
    
    
    
    // set title for picker's buttons when is selected from picker vc
    
   
    
    func getSelectdPicker(selectdTxt: String, securtNumber: String, flag: String, securtyId: String, secMarket: String, secStatus: String, secISIN: String) {
        
        if flag == "0"{
            
            searchStack.isHidden = false
            staticCellInfo.isHidden = false
            
            selectedPaperName = selectdTxt
            self.securityNameLabel.setTitle(  "\(selectdTxt)/\(securtNumber)" , for: .normal)
           // ??
            
        }
        
        
        self.securtyIdToCallApi = securtyId
        searchStack.isHidden = false
        
        
        // set labels for static cell
        
        isinLabel.text = secISIN ?? ""
        reuterCode.text = securtNumber ?? ""
        secNameLabel.text = selectdTxt ?? ""
        secStatusLabel.text = secStatus ?? ""
        secMarketLabel.text = secMarket ?? ""
        
        
        print("Securty !!",securtyId)
        print("Securty !!",securtyId)
    }
    
    
    
    func getSelectdPicker(selectdTxt: String, securtNumber: String, flag: String, securtyId: String, secMarket: String, secStatus: String) {
        
        
        
    }
    
    
    // Security name Picker pressed
    
    @IBAction func securityNamePressed(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PickerVC") as! PickerVC
        
        vc.dataSelectedDelegate = self
        vc.checkFlag = "0"
        vc.secData = self.secData
        vc.checkAccountStatmnt = false
        self.present(vc, animated: true)
        
    }
    
    
    @IBAction func literalNumPressed(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PickerVC") as! PickerVC
        vc.dataSelectedDelegate = self
        
        vc.checkFlag = "1"
        vc.checkAccountStatmnt = false
        
        vc.secData = self.secData
        
        self.present(vc, animated: true)
    }
    
    
    @IBAction func searchPressed(_ sender: Any) {
        
        self.getSecurityOwnership(securtID: securtyIdToCallApi ?? "", withZero: withZeroFlag ?? "")
            
    }
    
    
    
    
    
    
    func getInvestoreInfo(withZero : String){
        //
        let hud = JGProgressHUD(style: .light)
        //        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        
        
        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang":  MOLHLanguage.isRTLLanguage() ? "ar" : "en" ,
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
                                
                                if let data = jsonObj!["data"] as? [[String: Any]]{

                                    for item in data {
                                        let model = InvestoreOwnerShape(data: item)
                                        self.invAccount.append(model)
                                        
                                    }
                                    
                                    
                                }
                                
                                // partialData
                                
                                if let partialData = jsonObj!["partialData"] as? [[String: Any]]{


                                    for item in partialData {
                                        let model = PartialDataModel(data: item)
                                        self.dataArray.append(model)

                                        self.secData.append(SecurityData(secName: model.Security_Name ?? "", secNum: model.Security_Reuter_Code ?? "" , securotyID: model.Security_Id ?? "" , secMarket: model.Market_Type_Desc ?? "" , secStatus: model.Security_Status_Desc ?? "" , secISIN: model.Security_Isin ?? ""))

                                    }

                                    DispatchQueue.main.async {
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
                                hud.dismiss(animated: true)
                                
                                
                                
                            }
                            
                            
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
    
    func getSecurityOwnership(securtID:String , withZero : String){
        
        self.securityOwnership.removeAll()
        
        
        let hud = JGProgressHUD(style: .light)
        
        hud.show(in: self.view)
        
        
        
        let param : [String:Any] = [
            "sessionId" : Helper.shared.getUserSeassion() ?? ""
            ,"lang": MOLHLanguage.isRTLLanguage() ? "ar" : "en",
            "securityId":self.securtyIdToCallApi ?? "" ,
            "with_zero" : withZeroFlag
        ]
        
        let link = URL(string: APIConfig.GetSecurityOwnership)
        
        AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    
                    if jsonObj != nil {
                        
                        if let status = jsonObj!["status"] as? Int {
                            if status == 200 {
                                
                                
                                if let data = jsonObj!["data"] as? [[String: Any]]{
                                    for item in data {
                                        let model = SecurityOwnership(data: item)
                                        self.securityOwnership.append(model)
                                        
                                    }
                                    
                                    self.dinarData = []
                                    
                                    self.dinarData?
                                        .append(SecurityOwnerShapeHolder(title: "Bank".localized(), array: self.securityOwnership.filter({($0 .Security_Sector) == "1"})))
                                    self.dinarData?
                                        .append(SecurityOwnerShapeHolder(title: "Insurance".localized(), array: self.securityOwnership.filter({($0 .Security_Sector) == "2"})))
                                    self.dinarData?
                                        .append(SecurityOwnerShapeHolder(title: "Services".localized(), array: self.securityOwnership.filter({($0 .Security_Sector) == "3"})))
                                        self.dinarData?
                                            .append(SecurityOwnerShapeHolder(title: "Industry".localized(), array: self.securityOwnership.filter({($0 .Security_Sector) == "4"})))
                                    
                                    
                                    DispatchQueue.main.async {
                                        self.busnissCard.reloadData()
                                        self.refreshControl?.endRefreshing()
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
                            else {  self.refreshControl.endRefreshing()
                                hud.dismiss(animated: true)      }
                        }
                        
                    }
                    
                } catch let err as NSError {
                    print("Error: \(err)")
                    self.serverError(hud: hud)
                    self.refreshControl.endRefreshing()
                }
            } else {
                print("Error")
                
                self.serverError(hud: hud)
                self.refreshControl.endRefreshing()
                
                
            }
        }
    }
    
    
    
    
}

struct SecurityData {
    var secName : String
    var secNum : String
    var securotyID : String
    var secMarket : String
    var secStatus : String
    var secISIN : String
    
}


//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let currentScrollViewYOffset = scrollView.contentOffset.y
//
//        if currentScrollViewYOffset > previousScrollViewYOffset {
//            // scrolling down
//            if !headerViewIsHidden {
//
//                headerViewIsHidden = true
//                headerConstrianett.constant = 850
//
//
//                UIView.animate(withDuration: 0.2) {
//                    self.headerView.alpha = 0
//                }
//            }
//        } else {
//            // scrolling up
//            if headerViewIsHidden {
//                headerConstrianett.constant = 310
//
//                headerViewIsHidden = false
//                UIView.animate(withDuration: 0.2) {
//                    self.headerView.alpha = 1
//
//                }
//            }
//        }
//
//        previousScrollViewYOffset = currentScrollViewYOffset
//    }
