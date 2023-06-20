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

class InvestorOwnershipVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIScrollViewDelegate , InvestorOwnershipDelegate {
    
    
    
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
    var seatrching = false
    var invOwnership = [InvestoreOwnerShape]()
    var invAccount = [InvestoreOwnerShape]()
    var arr_search = [InvestoreOwnerShape]()
    
    var bankArray = [InvestoreOwnerShape]()
    var servicesArray = [InvestoreOwnerShape]()
    var insuaranceArray = [InvestoreOwnerShape]()
    var industryArray = [InvestoreOwnerShape]()
    
    var filterdBankArray = [InvestoreOwnerShape]()
    var filteredServicesArray = [InvestoreOwnerShape]()
    var filteredInsuaranceArray = [InvestoreOwnerShape]()
    var filteredIndustryArray = [InvestoreOwnerShape]()
    
    var backColor = UIColor(red: 0.00, green: 0.78, blue: 0.42, alpha: 1.00)
    var checkSideMenu = false
    
    
    // 3 services  4 industry
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.withoutZero.cornerRadius = 12
        self.withZero.cornerRadius = 12
        if checkSideMenu == true {
            backBtn.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
            sideMenuBtn.setImage(UIImage(named: ""), for: .normal)
            sideMenuBtn.isEnabled = false
        }
        
        isZeroSelected = true
        isWithoutSelected = false
        withZeroFlag = "1"
        highlightedButtons()
        self.getInvestoreInfo(withZero: withZeroFlag ?? "")
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
        self.cerateBellView(bellview: self.bellView, count: "10")
        withZeroFlag = "1"
        DispatchQueue.main.async {
            if self.isZeroSelected == true && self.isWithoutSelected == false {
                self.withZero.setTitleColor(.white, for: .normal)
                self.withZero.backgroundColor  =
                UIColor(named: "AccentColor")
                self.withoutZero.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
            }
            else if self.isZeroSelected == false && self.isWithoutSelected == true {
                self.withoutZero.setTitleColor(.white, for: .normal)
                self.withoutZero.backgroundColor = UIColor(named: "AccentColor")
                self.withZero.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
                
            }
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
        self.seatrching = true
        seatrching = false
        didPullToRefresh()
        busnissCard.reloadData()
    }
    
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        search_bar.text = ""
        seatrching = false
        self.arr_search.removeAll()
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
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if seatrching == true {
            switch section {
            case 0:
                return filterdBankArray.count
            case 1:
                return filteredInsuaranceArray.count
            case 2:
                return filteredServicesArray.count
            case 3:
                return filteredIndustryArray.count
            default:
                print("default")
                return 0
            }
        }
        
        else {
            switch section {
            case 0:
                return bankArray.count
            case 1:
                return insuaranceArray.count
            case 2:
                return servicesArray.count
            case 3:
                return industryArray.count
            default:
                print("default")
                return 0
            }
        }
       
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = busnissCard.dequeueReusableHeaderFooterView(withIdentifier: "SectionNameView") as! SectionNameView
        switch section{
        case 0:
            headerView.sectionName.text = "Banks".localized()
        case 1:
            headerView.sectionName.text = "Insuarance".localized()
        case 2:
            headerView.sectionName.text = "Services".localized()
        case 3:
            headerView.sectionName.text = "Industry".localized()
            
        default:
            print("default")
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
        
        if indexPath.section == 0 {
            vc.invOwnership = self.bankArray[indexPath.row]
        }
        
        else if indexPath.section == 1 {
            vc.invOwnership = self.insuaranceArray[indexPath.row]
        }
        
        else if indexPath.section == 2 {
            vc.invOwnership = self.servicesArray[indexPath.row]
        }
        
        else if indexPath.section == 3 {
            vc.invOwnership = self.industryArray[indexPath.row]
        }
            self.present(vc, animated: true)
        
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 500
    //
    //    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.busnissCard.dequeueReusableCell(withIdentifier: "BusnissCardTable", for: indexPath) as? BusnissCardTable
        cell?.addtionalStack.isHidden = false
        cell?.mainCardView.layer.cornerRadius =  25
        if seatrching == true {
            if indexPath.section == 0 {
                cell?.literalName.text = filterdBankArray[indexPath.row].Security_Name ?? ""
                
                cell?.literalNum.text = self.convertIntToArabicNumbers(intString: filterdBankArray[indexPath.row].securityID  ?? "")
                
                cell?.sector.text = filterdBankArray[indexPath.row].Security_Sector_Desc ?? ""
                
                cell?.balance.text = self.doubleToArabic(value: filterdBankArray[indexPath.row].Security_Close_Price ?? "")
            }
            
            else if indexPath.section == 1 {
                cell?.literalName.text = filteredInsuaranceArray[indexPath.row].Security_Name ?? ""
                cell?.literalNum.text = self.convertIntToArabicNumbers(intString: filteredInsuaranceArray[indexPath.row].securityID  ?? "")
                
                cell?.sector.text = filteredInsuaranceArray[indexPath.row].Security_Sector_Desc ?? ""
                
                cell?.balance.text = self.doubleToArabic(value: filteredInsuaranceArray[indexPath.row].Security_Close_Price ?? "")
            }
            
            else if indexPath.section == 2 {
                cell?.literalName.text = filteredServicesArray[indexPath.row].Security_Name ?? ""
                
                cell?.literalNum.text = self.convertIntToArabicNumbers(intString: filteredServicesArray[indexPath.row].securityID  ?? "")
                
                cell?.sector.text = filteredServicesArray[indexPath.row].Security_Sector_Desc ?? ""
                
                cell?.balance.text = self.doubleToArabic(value: filteredServicesArray[indexPath.row].Security_Close_Price ?? "")
                
            }
            else if indexPath.section == 3 {
                cell?.literalName.text = filteredIndustryArray[indexPath.row].Security_Name ?? ""
                cell?.literalNum.text = self.convertIntToArabicNumbers(intString: filteredIndustryArray[indexPath.row].securityID  ?? "")
                
                cell?.sector.text = filteredIndustryArray[indexPath.row].Security_Sector_Desc ?? ""
                cell?.balance.text = self.doubleToArabic(value: filteredIndustryArray[indexPath.row].Security_Close_Price ?? "")
            }
            
            
            
        }
        
        else {
            
            if indexPath.section == 0 {
                cell?.literalName.text = bankArray[indexPath.row].Security_Name ?? ""
                cell?.literalNum.text = self.convertIntToArabicNumbers(intString: bankArray[indexPath.row].securityID  ?? "")
                
                cell?.sector.text = bankArray[indexPath.row].Security_Sector_Desc ?? ""
                
                cell?.balance.text = self.doubleToArabic(value: bankArray[indexPath.row].Security_Close_Price ?? "")
            }
            
            else if indexPath.section == 1 {
                cell?.literalName.text = insuaranceArray[indexPath.row].Security_Name ?? ""
                cell?.literalNum.text = self.convertIntToArabicNumbers(intString: insuaranceArray[indexPath.row].securityID  ?? "")
                
                cell?.sector.text = insuaranceArray[indexPath.row].Security_Sector_Desc ?? ""
                cell?.balance.text = self.doubleToArabic(value: insuaranceArray[indexPath.row].Security_Close_Price ?? "")
                
            }
            
            else if indexPath.section == 2 {
                cell?.literalName.text = servicesArray[indexPath.row].Security_Name ?? ""
                cell?.literalNum.text = self.convertIntToArabicNumbers(intString: servicesArray[indexPath.row].securityID  ?? "")
                
                cell?.sector.text = servicesArray[indexPath.row].Security_Sector_Desc ?? ""
                
                cell?.balance.text = self.doubleToArabic(value: servicesArray[indexPath.row].Security_Close_Price ?? "")
            }
            
            else if indexPath.section == 3 {
                cell?.literalName.text = industryArray[indexPath.row].Security_Name ?? ""
                
                cell?.literalNum.text = self.convertIntToArabicNumbers(intString: industryArray[indexPath.row].securityID  ?? "")
                
                cell?.sector.text = industryArray[indexPath.row].Security_Sector_Desc ?? ""
                
                cell?.balance.text = self.doubleToArabic(value: industryArray[indexPath.row].Security_Close_Price ?? "")
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
        if MOLHLanguage.isArabic(){
            
//            self.arr_search = self.invAccount.filter({($0.Security_Name?.prefix(searchText.count))! == searchText})
            
            self.filterdBankArray = self.bankArray.filter({($0.Security_Name?.prefix(searchText.count))! == searchText})
            
            self.filteredInsuaranceArray = self.insuaranceArray.filter({($0.Security_Name?.prefix(searchText.count))! == searchText})
            
            self.filteredServicesArray = self.servicesArray.filter({($0.Security_Name?.prefix(searchText.count))! == searchText})
            
            self.filteredIndustryArray = self.industryArray.filter({($0.Security_Name?.prefix(searchText.count))! == searchText})
            
            
            self.seatrching = true
            
//             self.filteredIndustryArray = self.arr_search.filter({($0 .Security_Sector)! == "4"})
//
//             self.filteredServicesArray = self.arr_search.filter({($0 .Security_Sector)! == "3"})
//
//            self.filteredInsuaranceArray = self.invAccount.filter({($0 .Security_Sector)! == "2"})
//
//             self.filterdBankArray = self.arr_search.filter({($0 .Security_Sector)! == "1"})
            
            self.busnissCard.reloadData()
            
            
        } else {
            self.arr_search = self.invAccount.filter({($0.Security_Name?.prefix(searchText.count))! == searchText})
            self.seatrching = true
            
            self.filteredIndustryArray = self.arr_search.filter({($0 .Security_Sector)! == "4"})
            
            self.filteredServicesArray = self.arr_search.filter({($0 .Security_Sector)! == "3"})
            
            self.filteredInsuaranceArray = self.arr_search.filter({($0 .Security_Sector)! == "2"})
            
            self.filterdBankArray = self.arr_search.filter({($0 .Security_Sector)! == "1"})
            
            
            self.busnissCard.reloadData()
            
        }
    }

    
//    search
    func cancelbtn (search:UISearchBar){
        self.seatrching = false
        search_bar.text = ""
        view.endEditing(true)
        busnissCard.reloadData()
    }
    
    //function for change background selected background color for with and without zero btn
    
    func highlightedButtons() {
        
        // with zeros
        
        if isZeroSelected == true && isWithoutSelected == false {
            self.withZeroFlag = "1"
            DispatchQueue.main.async{
         
            self.withZero.setTitleColor(.white, for: .normal)
                
            self.withZero.backgroundColor  =
                UIColor(named: "AccentColor")
                self.withoutZero.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
            self.withoutZero.backgroundColor  = .systemGray6
//            self.withoutZero.cornerRadius = 12
            self.withoutZero.borderColor =  UIColor(named: "AccentColor")
            self.withoutZero.borderWidth = 1
                self.getInvestoreInfo(withZero: self.withZeroFlag ?? "")

        }
            

        
        }
        
        // without zeros
        
        else if isZeroSelected == false && isWithoutSelected == true {
            DispatchQueue.main.async {
                self.withoutZero.setTitleColor(.white, for: .normal)
                self.withoutZero.backgroundColor = UIColor(named: "AccentColor")
                
                self.withZero.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
                self.withZero.backgroundColor  = .systemGray6
//                self.withZero.cornerRadius = 12
                self.withZero.borderColor =  UIColor(named: "AccentColor")
                self.withZero.borderWidth = 1
                self.getInvestoreInfo(withZero: self.withZeroFlag ?? "")

            }
        }
        
    }
    
    
    @IBAction func withZeero(btn:UIButton){
        invAccount.removeAll()
        bankArray.removeAll()
        insuaranceArray.removeAll()
        servicesArray.removeAll()
        industryArray.removeAll()
        busnissCard.reloadData()
            withZeroFlag = "1"
            isZeroSelected = true
            isWithoutSelected = false
            highlightedButtons()
    }
    
    
    @IBAction func withoutZeero(btn:UIButton){
        invAccount.removeAll()
        bankArray.removeAll()
        insuaranceArray.removeAll()
        servicesArray.removeAll()
        industryArray.removeAll()
        busnissCard.reloadData()
        withZeroFlag = "0"
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

    
     
        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": "en" ,
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
                                    
                                   
                                    self.industryArray = self.invAccount.filter({($0 .Security_Sector)! == "4"})
                                    
                                    self.servicesArray = self.invAccount.filter({($0 .Security_Sector)! == "3"})
                                    
                                    
                                    self.bankArray = self.invAccount.filter({($0 .Security_Sector)! == "1"})
                                    
                                    
                                    self.insuaranceArray = self.invAccount.filter({($0 .Security_Sector)! == "2"})
                                    
                                    
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
    
    
    @IBOutlet weak var headerView: UIView!
    var previousScrollViewYOffset: CGFloat = 0
    var headerViewIsHidden = false

    @IBOutlet weak var headerConstrianett: NSLayoutConstraint!
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentScrollViewYOffset = scrollView.contentOffset.y
        
        if currentScrollViewYOffset <= 0 {
              // User is at the top of the table view
            headerView.isHidden = false
          } else {
              // User has scrolled down
              headerView.isHidden = true
          }
        if currentScrollViewYOffset > previousScrollViewYOffset {
            // scrolling down
            if !headerViewIsHidden {
                headerViewIsHidden = true
                headerConstrianett.constant = 600

                
                UIView.animate(withDuration: 0.2) {
                    self.headerView.alpha = 0
                }
            }
        } else {
            // scrolling up
            if headerViewIsHidden {
                headerConstrianett.constant = 494

                headerViewIsHidden = false
                UIView.animate(withDuration: 0.2) {
                    self.headerView.alpha = 1
                    
                }
            }
        }
        
        previousScrollViewYOffset = currentScrollViewYOffset
    }

}
