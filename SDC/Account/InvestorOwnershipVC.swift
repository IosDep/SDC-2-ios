//
//  InvestorOwnershipVC.swift
//  SDC
//
//  Created by Blue Ray on 19/03/2023.
//

import UIKit
import Alamofire
import JGProgressHUD
import MOLH

class InvestorOwnershipVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIScrollViewDelegate , InvestorOwnershipDelegate , SelectedNatDelegate {
   
    @IBOutlet weak var totalValueStack: UIStackView!
    @IBOutlet weak var currencyBtn: UIButton!
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var busnissCard: UITableView!
    @IBOutlet weak var search_bar: UISearchBar!
    @IBOutlet weak var bellView: UIView!
    @IBOutlet weak var withZero: DesignableButton!
    @IBOutlet weak var withoutZero: DesignableButton!
    
    var refreshControl: UIRefreshControl!
    var isZeroSelected : Bool?
    var isWithoutSelected : Bool?
    var withZeroFlag : String?
    var isSearching = false
    var data, filteredData , dolarData , dolarFilteredData: [InvestoreOwnerShapeHolder]?
    var invOwnership = [InvestoreOwnerShape]()
    var invAccount = [InvestoreOwnerShape]()
    var arr_search = [InvestoreOwnerShape]()
    var dinarArray = [InvestoreOwnerShape]()
    var dolarArray = [InvestoreOwnerShape]()
    var bankArray = [InvestoreOwnerShape]()
    var servicesArray = [InvestoreOwnerShape]()
    var insuaranceArray = [InvestoreOwnerShape]()
    var industryArray = [InvestoreOwnerShape]()
    
    var filterdBankArray = [InvestoreOwnerShape]()
    var filteredServicesArray = [InvestoreOwnerShape]()
    var filteredInsuaranceArray = [InvestoreOwnerShape]()
    var filteredIndustryArray = [InvestoreOwnerShape]()
    var options : [String] = []
    var backColor = UIColor(red: 0.00, green: 0.78, blue: 0.42, alpha: 1.00)
    var checkSideMenu = false
    var totalDolar : Double?
    var totalDinar : Double?
    var currencyFlag : String?
    // 3 services  4 industry
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currencyBtn.setTitle("JOD".localized(), for: .normal)
        self.currencyFlag = "1"
        self.makeShadow(mainView: totalValueStack)
        
        self.withoutZero.cornerRadius = 12
        self.withZero.cornerRadius = 12
        
        if checkSideMenu == true {
            sideMenuBtn.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
            bellView.isHidden = true
        }
        
        else if checkSideMenu == false {
            sideMenuBtn.setImage(UIImage(named: "menus"), for: .normal)
            bellView.isHidden = false

        }
        
        isWithoutSelected = true
        isZeroSelected = false
        withZeroFlag = "1"
        currencyFlag = "1"
        highlightedButtons()
        search_bar.delegate = self
        self.busnissCard.delegate = self
        self.busnissCard.dataSource = self
        self.busnissCard.register(UINib(nibName: "BusnissCardTable", bundle: nil), forCellReuseIdentifier: "BusnissCardTable")
        busnissCard.register(UINib(nibName: "SectionNameView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "SectionNameView")
        
        view.layer.zPosition = 999
        busnissCard.contentInsetAdjustmentBehavior = .never
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        self.busnissCard.addSubview(refreshControl)
        
        let notcount = "\(Helper.shared.getNotificationCount()!)"
        self.cerateBellView(bellview: self.bellView, count: notcount)
        
//        DispatchQueue.main.async {
//            if self.isZeroSelected == true && self.isWithoutSelected == false {
//                self.withZero.setTitleColor(.white, for: .normal)
//                self.withZero.backgroundColor  =
//                UIColor(named: "AccentColor")
//                self.withoutZero.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
//            }
//            else if self.isZeroSelected == false && self.isWithoutSelected == true {
//                self.withoutZero.setTitleColor(.white, for: .normal)
//                self.withoutZero.backgroundColor = UIColor(named: "AccentColor")
//                self.withZero.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
//
//            }
//        }
    }
    
    @IBAction func setupMenu(_ sender: Any) {
        
        if self.checkSideMenu == true {
            self.dismiss(animated: true)
        }
        
        else if checkSideMenu == false {
            self.side_menu()
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    @IBAction func backPressed(_ sender: Any) {
        if checkSideMenu == true {
            self.dismiss(animated: true, completion: {
                let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.present(vc, animated: true, completion: nil)
            })
        }
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        self.isSearching = true
        isSearching = false
        didPullToRefresh()
        busnissCard.reloadData()
    }
    
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        search_bar.text = ""
        isSearching = false
        filteredData?.removeAll()
        dolarFilteredData?.removeAll()
        self.busnissCard.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()
    }
    
    
    //    refresh action
    @objc func didPullToRefresh() {
        self.invAccount.removeAll()
        self.busnissCard.reloadData()
        if isZeroSelected == true && isWithoutSelected == false {
            self.getInvestoreInfo(withZero: self.withZeroFlag ?? "")
            self.busnissCard.reloadData()
            
        }
        
        else if isZeroSelected == false && isWithoutSelected == true {
            self.getInvestoreInfo(withZero: self.withZeroFlag ?? "")
            self.busnissCard.reloadData()
        }
      
    }
    
    
    @IBAction func currencyPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CurrencyPicker") as! CurrencyPicker
        vc.selectedNatDelegate = self
        self.present(vc, animated: true)
        
    }
    
    func getSelectdPicker(selectdTxt: String, flag: String) {
        currencyBtn.setTitle(selectdTxt, for: .normal)
        if flag == "1" {
            totalValue.text = self.numFormat(value: totalDinar ?? 0.0)
            self.currencyFlag = "1"
        }
        else if flag == "22"{
            totalValue.text = self.numFormat(value: totalDolar ?? 0.0)
            self.currencyFlag = "22"
        }
        
        DispatchQueue.main.async {
            self.busnissCard.reloadData()

        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        if !isSearching {
            if currencyFlag == "1" {
                if let data {
                    let newData = data.filter({!($0.array?.isEmpty ?? true)})
                    return newData.count
                }
            }
            else if currencyFlag == "22" {
                if let dolarData {
                    let newData = dolarData.filter({!($0.array?.isEmpty ?? true)})
                    return newData.count
                }
                
            }
            
        }
        
        
        
        else {
            
            if currencyFlag == "1" {
                if let filteredData {
                    let newData = filteredData.filter({!($0.array?.isEmpty ?? true)})
                    return newData.count
                }
                
                
            }
            
            else if currencyFlag == "22" {
                if let dolarFilteredData {
                    let newData = dolarFilteredData.filter({!($0.array?.isEmpty ?? true)})
                    return newData.count
                }
            }
        
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            if currencyFlag == "1" {
                if let filteredData {
                    let newData = filteredData.filter({!($0.array?.isEmpty ?? true)})
                    return newData[section].array?.count ?? 0
                }
            }
            
            else if currencyFlag == "22" {
                if let dolarFilteredData {
                    let newData = dolarFilteredData.filter({!($0.array?.isEmpty ?? true)})
                    return newData[section].array?.count ?? 0
                }
            }
        }
       
        
        else {
            if currencyFlag == "1" {
                if let data {
                    let newData = data.filter({!($0.array?.isEmpty ?? true)})
                    return newData[section].array?.count ?? 0
                }
            }
            
            else if currencyFlag == "22"{
                if let dolarData {
                    let newData = dolarData.filter({!($0.array?.isEmpty ?? true)})
                    return newData[section].array?.count ?? 0
                }
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = busnissCard.dequeueReusableHeaderFooterView(withIdentifier: "SectionNameView") as! SectionNameView
        if !isSearching {
            
            if currencyFlag == "1" {
                if let data {
                    let newData = data.filter({!($0.array?.isEmpty ?? true)})
                    headerView.sectionName.text = newData[section].title ?? ""
                }
            }
            
            else {
                if let dolarData {
                    let newData = dolarData.filter({!($0.array?.isEmpty ?? true)})
                    headerView.sectionName.text = newData[section].title ?? ""
                }
            }
            
        }
        
        else {
            if currencyFlag == "1" {
                if let filteredData {
                    let newData = filteredData.filter({!($0.array?.isEmpty ?? true)})
                    headerView.sectionName.text = newData[section].title ?? ""
                }
            }
            
            else if currencyFlag == "22" {
                if let dolarFilteredData {
                    let newData = dolarFilteredData.filter({!($0.array?.isEmpty ?? true)})
                    headerView.sectionName.text = newData[section].title ?? ""
                }
            }
            
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CardTwoVc") as! CardTwoVc
        vc.modalPresentationStyle = .fullScreen
        
        if !isSearching {
            if currencyFlag == "1" {
                vc.currency = currencyFlag
                if let data {
                    let newData = data.filter({!($0.array?.isEmpty ?? true)})
                    vc.invOwnership = newData[indexPath.section].array?[indexPath.row]
                }
            }
            
            else {
                if let dolarData {
                    vc.currency = currencyFlag
                    let newData = dolarData.filter({!($0.array?.isEmpty ?? true)})
                    vc.invOwnership = newData[indexPath.section].array?[indexPath.row]
                }
            }
        }
        
        
        else {
            
            if currencyFlag == "1" {
                if let filteredData {
                    let newData = filteredData.filter({!($0.array?.isEmpty ?? true)})
                    vc.invOwnership = newData[indexPath.section].array?[indexPath.row]
                }
                
            }
            
            
            else if currencyFlag == "22" {
                if let dolarFilteredData {
                    let newData = dolarFilteredData.filter({!($0.array?.isEmpty ?? true)})
                    vc.invOwnership = newData[indexPath.section].array?[indexPath.row]
                }
                
            }
           
        }
        self.present(vc, animated: true)
        
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.busnissCard.dequeueReusableCell(withIdentifier: "BusnissCardTable", for: indexPath) as? BusnissCardTable
        
        cell?.addtionalStack.isHidden = false
        cell?.mainCardView.layer.cornerRadius =  25
        
        if isSearching  {
            
            if currencyFlag == "1" {
                if let filteredData {
                    let newData = filteredData.filter({!($0.array?.isEmpty ?? true)})
                    cell?.literalName.text = newData[indexPath.section].array?[indexPath.row].Security_Reuter_Code ?? ""
                    cell?.literalNum.text =  newData[indexPath.section].array?[indexPath.row].securityIsin  ?? ""
                    
                    cell?.sector.text = newData[indexPath.section].array?[indexPath.row].Security_Name ?? ""
                    
                    cell?.balance.text =  self.numStringFormat(value: newData[indexPath.section].array?[indexPath.row].Quantity_Owned ?? "")
                }
            }
            
            else if currencyFlag == "22" {
                if let dolarFilteredData {
                    let newData = dolarFilteredData.filter({!($0.array?.isEmpty ?? true)})
                    cell?.literalName.text = newData[indexPath.section].array?[indexPath.row].Security_Reuter_Code ?? ""
                    cell?.literalNum.text =  newData[indexPath.section].array?[indexPath.row].securityIsin  ?? ""
                    
                    cell?.sector.text = newData[indexPath.section].array?[indexPath.row].Security_Name ?? ""
                    
                    cell?.balance.text =  self.numStringFormat(value: newData[indexPath.section].array?[indexPath.row].Quantity_Owned ?? "")
                }
            }
            
        }
        
        else {
            if currencyFlag == "1" {
                if let data {
                    let newData = data.filter({!($0.array?.isEmpty ?? true)})
                    cell?.literalName.text = newData[indexPath.section].array?[indexPath.row].Security_Reuter_Code ?? ""
                    cell?.literalNum.text =  newData[indexPath.section].array?[indexPath.row].securityIsin  ?? ""
                    
                    cell?.sector.text = newData[indexPath.section].array?[indexPath.row].Security_Name ?? ""
                    
                    cell?.balance.text =  self.numStringFormat(value: newData[indexPath.section].array?[indexPath.row].Quantity_Owned ?? "")
                }

            }
            
            else if currencyFlag == "22" {
                
                if let dolarData {
                    let newData = dolarData.filter({!($0.array?.isEmpty ?? true)})
                    cell?.literalName.text = newData[indexPath.section].array?[indexPath.row].Security_Reuter_Code ?? ""
                    cell?.literalNum.text =  newData[indexPath.section].array?[indexPath.row].securityIsin  ?? ""
                    
                    cell?.sector.text = newData[indexPath.section].array?[indexPath.row].Security_Name ?? ""
                    
                    cell?.balance.text =  self.numStringFormat(value: newData[indexPath.section].array?[indexPath.row].Quantity_Owned ?? "")
                }
        }
            
        }
        return cell!
    }
    
    
    // delegate when pressed on card inside cell
    
    func cardSelected(invAccount: InvestoreOwnerShape) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CardTwoVc") as! CardTwoVc
        vc.modalPresentationStyle = .fullScreen
        vc.invOwnership = invAccount
        self.present(vc, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            isSearching = false
            filteredData = []
            dolarFilteredData = []
            self.busnissCard.reloadData()
            return
        }
//        if MOLHLanguage.isArabic(){
            
            //            self.arr_search = self.invAccount.filter({($0.Security_Name?.prefix(searchText.count))! == searchText})
            filteredData = []
            dolarFilteredData = []
        if currencyFlag == "1" {
            
            if let data {
                let newData = data.filter({!($0.array?.isEmpty ?? true)})
                for item in newData {
                    var itemsArray: [InvestoreOwnerShape]? = []
                    if let itemArray = item.array {
                        for innerItem in itemArray{
                            if innerItem.Security_Name?.lowercased().contains(searchText.lowercased()) ?? false {
                                itemsArray?.append(innerItem)
                            }
                        }
                    }
                    filteredData?.append(InvestoreOwnerShapeHolder(title: item.title, array: itemsArray))
                }
            }

            
        }
        
        else if currencyFlag == "22" {
            if let dolarData {
                let newData = dolarData.filter({!($0.array?.isEmpty ?? true)})
                for item in newData {
                    var itemsArray: [InvestoreOwnerShape]? = []
                    if let itemArray = item.array {
                        for innerItem in itemArray{
                            if innerItem.Security_Name?.lowercased().contains(searchText.lowercased()) ?? false {
                                itemsArray?.append(innerItem)
                            }
                        }
                    }
                    dolarFilteredData?.append(InvestoreOwnerShapeHolder(title: item.title, array: itemsArray))
                }
            }

        }
        
            
        
            self.isSearching = true
            self.busnissCard.reloadData()
        
        
        
        
            
            
//        } else {
//            self.arr_search = self.invAccount.filter({($0.Security_Name?.prefix(searchText.count))! == searchText})
//            self.isSearching = true
//
//            self.filteredIndustryArray = self.arr_search.filter({($0 .Security_Sector)! == "4"})
//
//            self.filteredServicesArray = self.arr_search.filter({($0 .Security_Sector)! == "3"})
//
//            self.filteredInsuaranceArray = self.arr_search.filter({($0 .Security_Sector)! == "2"})
//
//            self.filterdBankArray = self.arr_search.filter({($0 .Security_Sector)! == "1"})
//
//
//            self.busnissCard.reloadData()
//
//        }
    }

    
//    search
    func cancelbtn (search:UISearchBar){
        self.isSearching = false
        filteredData = []
        dolarFilteredData = []
        search_bar.text = ""
        view.endEditing(true)
        busnissCard.reloadData()
    }
    
    //function for change background selected background color for with and without zero btn
    
    func highlightedButtons() {
        
        // with zeros
        
        if isZeroSelected == true && isWithoutSelected == false {
            self.withZeroFlag = "2"
            DispatchQueue.main.async{
         
            self.withZero.setTitleColor(.white, for: .normal)
                
            self.withZero.backgroundColor  =
                UIColor(named: "AccentColor")
                self.withoutZero.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
            self.withoutZero.backgroundColor  = .white
//            self.withoutZero.cornerRadius = 12
            self.withoutZero.borderColor =  UIColor(named: "AccentColor")
            self.withoutZero.borderWidth = 1
                
                
                self.getInvestoreInfo(withZero: self.withZeroFlag ?? "")

        }
        
        }
        
        // without zeros
        
        else if isZeroSelected == false && isWithoutSelected == true {
            self.withZeroFlag = "1"

            DispatchQueue.main.async {
                self.withoutZero.setTitleColor(.white, for: .normal)
                self.withoutZero.backgroundColor = UIColor(named: "AccentColor")
                
                self.withZero.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
                self.withZero.backgroundColor  = .white
//                self.withZero.cornerRadius = 12
                self.withZero.borderColor =  UIColor(named: "AccentColor")
                self.withZero.borderWidth = 1
                self.getInvestoreInfo(withZero: self.withZeroFlag ?? "")

            }
        }
        
    }
    
    
    @IBAction func withZeero(btn:UIButton){
        invAccount.removeAll()
        data?.removeAll()
        dolarData?.removeAll()
        dinarArray.removeAll()
        dolarArray.removeAll()
        currencyFlag = "1"
        currencyBtn.setTitle("JOD", for: .normal)
        withZeroFlag = "2"
        isZeroSelected = true
        isWithoutSelected = false
        highlightedButtons()
    }
    
    
    @IBAction func withoutZeero(btn:UIButton){
        invAccount.removeAll()
        data?.removeAll()
        dolarData?.removeAll()
        dolarArray.removeAll()
        dinarArray.removeAll()
        currencyBtn.setTitle("JOD", for: .normal)
        withZeroFlag = "1"
        isWithoutSelected = true
        isZeroSelected = false
        highlightedButtons()
    }
    
    
    
   
    
//    API Call
    
    
    
    
    func getInvestoreInfo(withZero : String){
//
        let hud = JGProgressHUD(style: .light)
//        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)

    
     
        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": MOLHLanguage.isRTLLanguage() ? "ar" : "en" ,
                                    "with_zero" : withZero
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
                                    
                                    self.dinarArray += self.invAccount.filter({ $0.Trade_Currency == "1" })

                                    self.dolarArray += self.invAccount.filter({ $0.Trade_Currency == "22" })
                                    
                                    // Security_Sector_Desc
                                    
                                    //                                    for inv in self.invAccount {
                                    //                                        if inv.Security_Sector == "3" {
                                    //                                            self.industryArray.append(inv)
                                    //                                        }
                                    //
                                    //                                        else if inv.Security_Sector == "4" {
                                    //                                            self.servicesArray.append(inv)
                                    //                                        }
                                    //
                                    //                                        else if inv.Security_Sector == "1" {
                                    //                                            self.bankArray.append(inv)
                                    //                                        }
                                    //
                                    //
                                    //                                        else if inv.Security_Sector == "2" {
                                    //                                            self.insuaranceArray.append(inv)
                                    //                                        }
                                    //
                                    //
                                    //
                                    //                                    }
                                    
                                    self.data = []
                                    self.dolarData = []
                                    
                                    self.data?
                                        .append(InvestoreOwnerShapeHolder(title: "Bank".localized(), array: self.dinarArray.filter({($0 .Security_Sector) == "1"})))
                                    self.data?
                                        .append(InvestoreOwnerShapeHolder(title: "Insurance".localized(), array: self.dinarArray.filter({($0 .Security_Sector) == "2"})))
                                    self.data?
                                        .append(InvestoreOwnerShapeHolder(title: "Services".localized(), array: self.dinarArray.filter({($0 .Security_Sector) == "3"})))
                                        self.data?
                                            .append(InvestoreOwnerShapeHolder(title: "Industry".localized(), array: self.dinarArray.filter({($0 .Security_Sector) == "4"})))
                                    
                                    
                                    
                                    self.dolarData?
                                        .append(InvestoreOwnerShapeHolder(title: "Bank".localized(), array: self.dolarArray.filter({($0 .Security_Sector) == "1"})))
                                    self.dolarData?
                                        .append(InvestoreOwnerShapeHolder(title: "Insurance".localized(), array: self.dolarArray.filter({($0 .Security_Sector) == "2"})))
                                    self.dolarData?
                                        .append(InvestoreOwnerShapeHolder(title: "Services".localized(), array: self.dolarArray.filter({($0 .Security_Sector) == "3"})))
                                        self.dolarData?
                                            .append(InvestoreOwnerShapeHolder(title: "Industry".localized(), array: self.dolarArray.filter({($0 .Security_Sector) == "4"})))
                                    
                                    
                    DispatchQueue.main.async {
                                       
                    self.busnissCard.reloadData()
                    self.refreshControl?.endRefreshing()
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
                                
                                // market_value
                                
                                if let total = jsonObj!["total"] as? [String: Any]{
                                    if let dinar = total["1"] as? [String: Any]{
                                        
                                        let market_value = dinar["market_value"] as? Double
                                        
                                        self.totalDinar = market_value
                                        self.totalValue.text = self.numFormat(value: market_value ?? 0.0)
                                        
                                    }
                                    
                                    if let dolar = total["22"] as? [String: Any]{
                                        
                                        let market_value = dolar["market_value"] as? Double
                                        self.totalDolar = market_value
                                        
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
    
//
    @IBOutlet weak var headerView: UIView!
    var previousScrollViewYOffset: CGFloat = 0
    var headerViewIsHidden = false

    @IBOutlet weak var headerConstrianett: NSLayoutConstraint!
    
    var viewHeight: CGFloat = 180
    private var isAnimationInProgress = false

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isAnimationInProgress {
            
            // Check if an animation is required
            if scrollView.contentOffset.y > .zero &&
                headerConstrianett.constant > .zero {
                
                headerConstrianett.constant = .zero
                headerView.isHidden = true
                animateTopViewHeight()
            }
            else if scrollView.contentOffset.y <= .zero
                        && headerConstrianett.constant <= .zero {
                
                headerConstrianett.constant = viewHeight
                headerView.isHidden = false
                animateTopViewHeight()
            }
        }
    }
    
    private func animateTopViewHeight() {
        
        // Lock the animation functionality
        isAnimationInProgress = true
        
        UIView.animate(withDuration: 0.2) {
            
            self.view.layoutIfNeeded()
            
        } completion: { [weak self] (_) in
            
            // Unlock the animation functionality
            self?.isAnimationInProgress = false
        }
    }
}



//        if seatrching == true {
//
//                    switch  indexPath.section {
//                    case 0:
//                        cell?.invAccount = filterdBankArray
//                    case 1:
//                        cell?.invAccount = insuaranceArray
//                    case 2:
//                        cell?.invAccount = servicesArray
//                    case 3:
//                        cell?.invAccount = industryArray
//                    default:
//                        print("defaulttt")
//                    }
//
//                }
//
//                else {
//
//                    switch indexPath.section {
//
//                    case 0:                            cell?.invAccount = bankArray
//
//                    case 1:                            cell?.invAccount = insuaranceArray
//
//                    case 2:                            cell?.invAccount = servicesArray
//
//                    case 3 :
//                        cell?.invAccount = industryArray
//
//                    default:
//                        print("defaulttt")
//                    }
//
//                }
//        cell?.investorOwnershipDelegate = self
