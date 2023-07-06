
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

class CompanyProcedureVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIScrollViewDelegate , SelectedNatDelegate {
    
    
    
    @IBOutlet weak var search_bar: UISearchBar!
    
    @IBOutlet weak var categoryBtn: DesignableButton!
    @IBOutlet weak var busnissCard: UITableView!
    
    var refreshControl: UIRefreshControl!
    var isZeroSelected : Bool?
    var isWithoutSelected : Bool?
    //    @IBOutlet weak var withoutZero: DesignableButton!
    //    @IBOutlet weak var withZero: DesignableButton!
    
    
    
    var seatrching = false
    var pickerData : [String] = []
    //    @IBOutlet weak var bellView: UIView!
    var invOwnership = [InvestoreOwnerShape]()
    var lastAction = [LastAction]()
    var arr_search = [LastAction]()
    var backColor = UIColor(red: 0.00, green: 0.78, blue: 0.42, alpha: 1.00)
    var checkSideMenu = false
    var withZeroFlag : String?
    var publicCompanies = [LastAction]()
    var financialCompanies = [LastAction]()
    var custodians = [LastAction]()
    var filteredData = [LastAction]()
    var counter : Int?
    var categoryFlag : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.withoutZero.cornerRadius = 12
        //        self.withZero.cornerRadius = 12
        //
        isZeroSelected = true
        isWithoutSelected = false
        withZeroFlag = "1"
        //        highlightedButtons()
        self.getLastactions(withZero: withZeroFlag ?? "")
        search_bar.delegate = self
        
        self.busnissCard.delegate = self
        self.busnissCard.dataSource = self
        self.busnissCard.register(UINib(nibName: "LastCoorporationActionCell", bundle: nil), forCellReuseIdentifier: "LastCoorporationActionCell")
        
        view.layer.zPosition = 999
        busnissCard.contentInsetAdjustmentBehavior = .never
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        self.busnissCard.addSubview(refreshControl)
        
        //        self.cerateBellView(bellview: self.bellView, count: "10")
        
    }
    
    
    
    @IBAction func categoryPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CurrencyPicker") as! CurrencyPicker
        vc.selectedNatDelegate = self
        vc.checkCompanyAction = true
        vc.categories = self.pickerData
//        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    func getSelectdPicker(selectdTxt: String, flag: String) {
        
        if selectdTxt == "Public ShareHolding Companies".localized(){
            categoryBtn.setTitle(selectdTxt, for: .normal)
            categoryFlag = 0
    }
        
        if selectdTxt == "Finincial Services Companies".localized(){
            categoryBtn.setTitle(selectdTxt, for: .normal)
            categoryFlag = 1
        }
        
        if selectdTxt == "Custodians".localized(){
            categoryBtn.setTitle(selectdTxt, for: .normal)
            categoryFlag = 2
        }
        
        busnissCard.reloadData()
        
     }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            self.present(vc, animated: true, completion: nil)
        })
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }
    
    
    //    refresh action
        @objc func didPullToRefresh() {
            self.lastAction.removeAll()
            self.busnissCard.reloadData()

        }
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        search_bar.text = ""
        seatrching = false
        
        
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if seatrching{
            return filteredData.count
            
        }
        
        else {
            
            if categoryFlag == 0 {
                return publicCompanies.count
            }
            
            else if categoryFlag == 1 {
                return financialCompanies.count
            }
            
            else  {
                return custodians.count

            }
        }
        return 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.busnissCard.dequeueReusableCell(withIdentifier: "LastCoorporationActionCell", for: indexPath) as? LastCoorporationActionCell
       
        cell?.mainView.layer.cornerRadius =  20

        if cell == nil {
            let nib: [Any] = Bundle.main.loadNibNamed("LastCoorporationActionCell", owner: self, options: nil)!
            cell = nib[0] as? LastCoorporationActionCell
        }
        
        if seatrching == true {
            
            let categoryData = filteredData[indexPath.row]
            cell?.company.text = categoryData.Member_Alias
            cell?.actionDate.text = categoryData.Action_Date
            cell?.transType.text = categoryData.Trans_Type_Desc
            cell?.actionType.text = categoryData.Action_Type_Desc
            cell?.beforeAction.text = categoryData.Value_Before
            cell?.afterAction.text  = categoryData.Value_After
            cell?.percentage.text = categoryData.percentageChange
            
        }
        
        else {
            
            if publicCompanies[indexPath.row].color == "arrow_green" {
                cell?.percentage.textColor = UIColor(named: "AccentColor")
                cell?.arrowBtn.setImage(UIImage(named: "up-arrow"), for: .normal)
               
            }
                
                else if  publicCompanies[indexPath.row].color == "arrow_red" {
                    
                    cell?.percentage.textColor = .red
                    cell?.arrowBtn.setImage(UIImage(named: "arrow-down"), for: .normal)
                    
            }
            
            else if publicCompanies[indexPath.row].color == "arrow_grey" {
                cell?.percentage.textColor = .systemGray3
                cell?.arrowBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
                cell?.arrowBtn.tintColor = .systemGray3
                
        }
            
            if categoryFlag == 0 {
                let categoryData = publicCompanies[indexPath.row]
                cell?.company.text = categoryData.Member_Alias
                cell?.actionDate.text =  categoryData.Action_Date
                cell?.transType.text = categoryData.Trans_Type_Desc
                cell?.actionType.text = categoryData.Action_Type_Desc
                cell?.beforeAction.text = categoryData.Value_Before
                cell?.afterAction.text  = categoryData.Value_After
                cell?.percentage.text = categoryData.percentageChange
            }
            else if categoryFlag == 1 {
                let categoryData = financialCompanies[indexPath.row]
                cell?.company.text = categoryData.Member_Alias
                cell?.actionDate.text = categoryData.Action_Date
                cell?.transType.text = categoryData.Trans_Type_Desc
                cell?.actionType.text = categoryData.Action_Type_Desc
                cell?.beforeAction.text = categoryData.Value_Before
                cell?.afterAction.text  = categoryData.Value_After
                cell?.percentage.text = categoryData.percentageChange

            }
            else {
                let categoryData = custodians[indexPath.row]
                cell?.company.text = categoryData.Member_Alias
                cell?.actionDate.text = categoryData.Action_Date
                cell?.transType.text = categoryData.Trans_Type_Desc
                cell?.actionType.text = categoryData.Action_Type_Desc
                cell?.beforeAction.text = categoryData.Value_Before
                cell?.afterAction.text  = categoryData.Value_After
                cell?.percentage.text = categoryData.percentageChange
            }
        }
        
        
        return cell!
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 180
//    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            seatrching = false
            filteredData = []
            self.busnissCard.reloadData()
            return
        }
        
        
        filteredData = []
        
        if categoryFlag == 0 {
            for item in publicCompanies{
                if item.Member_Alias?.lowercased().contains(searchText.lowercased()) ?? false {
                    filteredData.append(item)
                }
            }
            
        }
        else if categoryFlag == 1 {
            for item in financialCompanies{
                if item.Member_Alias?.lowercased().contains(searchText.lowercased()) ?? false {
                    filteredData.append(item)
                }
            }
        }
            else if categoryFlag == 2 {
                for item in custodians{
                    if item.Member_Alias?.lowercased().contains(searchText.lowercased()) ?? false {
                        filteredData.append(item)
                    }
            }
        }
        
        
        
//        if MOLHLanguage.isArabic(){
//            self.arr_search = self.lastAction.filter({($0.Member_Name?.prefix(searchText.count))! == searchText})
//        self.seatrching = true
//            self.busnissCard.reloadData()
//
//        } else {
//            self.arr_search = self.lastAction.filter({($0.Member_Name?.prefix(searchText.count))! == searchText})
//            self.seatrching = true
//                self.busnissCard.reloadData()
//
//        }
        
        self.seatrching = true
        self.busnissCard.reloadData()
    
    }
    
//    search
    func cancelbtn (search:UISearchBar){
        self.seatrching = false
        search_bar.text = ""
        view.endEditing(true)
        busnissCard.reloadData()
    }
    
    //function for change background selected background color for with and without zero btn
    
//    func highlightedButtons() {
//        if isZeroSelected == true && isWithoutSelected == false {
//            DispatchQueue.main.async{
//
//            self.withZero.setTitleColor(.white, for: .normal)
//
//            self.withZero.backgroundColor  =
//                UIColor(named: "AccentColor")
//            self.withoutZero.titleLabel?.textColor = UIColor(named: "AccentColor")
//            self.withoutZero.backgroundColor  = .systemGray6
//            self.withoutZero.cornerRadius = 12
//            self.withoutZero.borderColor =  UIColor(named: "AccentColor")
//            self.withoutZero.borderWidth = 1
//                self.getLastactions(withZero: self.withZeroFlag ?? "")
//        }
//
//        }
//        else if isZeroSelected == false && isWithoutSelected == true {
//            DispatchQueue.main.async {
//                self.withoutZero.setTitleColor(.white, for: .normal)
//                self.withoutZero.backgroundColor = UIColor(named: "AccentColor")
//
//                self.withZero.titleLabel?.textColor = UIColor(named: "AccentColor")
//                self.withZero.backgroundColor  = .systemGray6
//                self.withZero.cornerRadius = 12
//                self.withZero.borderColor =  UIColor(named: "AccentColor")
//                self.withZero.borderWidth = 1
//                self.getLastactions(withZero: self.withZeroFlag ?? "")
//            }
//        }
//
//
//    }
    
    
//    @IBAction func withZeero(btn:UIButton){
//        invOwnership.removeAll()
//           withZeroFlag = "1"
//            isZeroSelected = true
//            isWithoutSelected = false
//            highlightedButtons()
//    }
//
//
//    @IBAction func withoutZeero(btn:UIButton){
//        invOwnership.removeAll()
//        withZeroFlag = "0"
//        isWithoutSelected = true
//        isZeroSelected = false
//        highlightedButtons()
//    }
    
    
    
   
    
//    API Call
    
    
    
    
    func getLastactions(withZero : String){
//
        let hud = JGProgressHUD(style: .light)
//        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)

        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": MOLHLanguage.isRTLLanguage() ? "ar": "en"
 ]
     
        let link = URL(string: APIConfig.GetLastAction)

        AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                   

                    if jsonObj != nil {
                        if let status = jsonObj!["status"] as? Int {
                            if status == 200 {
                                if let data = jsonObj!["data"] as? [String: Any]{
                                    
                                    // public_shareholding_companies
                                    
                                    if let public_shareholding_companies = data["public_shareholding_companies"] as? [[String: Any]]{
                                        
                                        
                                    for item in public_shareholding_companies  {
                                        let model = LastAction(data: item)
                                    self.publicCompanies.append(model)
                                        
    
                                                }
                                        
                                    }
                                    
                                    if self.publicCompanies.isEmpty == false{
                                        self.counter = (self.counter ?? 0) + 1
                                        self.pickerData.append("Public ShareHolding Companies".localized())
                                        
                                    }
                                    
                                    
                                    
                                    
                                    if let financial_services_companies = data["financial_services_companies"] as? [[String: Any]]{
                                        
                                        for item in financial_services_companies  {
                                            let model = LastAction(data: item)
                                        self.financialCompanies.append(model)
        
                                                    }
                                        
                                    }
                                    
                                    if self.financialCompanies.isEmpty == false{
                                        self.counter = (self.counter ?? 0) + 1
                                        
                                        self.pickerData.append("Finincial Services Companies".localized())
                                    }
                                    
                                    if let custodians = data["custodians"] as? [[String: Any]]{
                                        
                                        for item in custodians  {
                                            let model = LastAction(data: item)
                                        self.custodians.append(model)
        
                                      }
                                        
                                        if self.custodians.isEmpty == false{
                                            self.counter = (self.counter ?? 0) + 1
                                            
                                            self.pickerData.append("Custodians".localized())
                                        }
                                        
                                        
                                        
                                    }
                                    
                                    DispatchQueue.main.async {
//                                        self.busnissCard.reloadData()
                                        self.refreshControl?.endRefreshing()
                                        hud.dismiss()
                                    }
                                    
                                    
//                                            for item in data {
//                                                let model = LastAction(data: item)
//                                                self.lastAction.append(model)
//
//                                            }
//
//                                            DispatchQueue.main.async {
//                                                self.busnissCard.reloadData()
//                                                self.refreshControl?.endRefreshing()
//                                                hud.dismiss()
//                                                self.showSuccessHud(msg: message ?? "", hud: hud)
                                                
//                                                if self.car_arr.count == 0{
//
//
//                                                    self.noDataImage.isHidden = false
//                                                }else{
//
//                                                    self.noDataImage.isHidden = true
//                                                }

//                                            }
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
    
    @IBOutlet weak var HeaderContraint: NSLayoutConstraint!
    
    var viewHeight: CGFloat = 180
    private var isAnimationInProgress = false

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isAnimationInProgress {
            
            // Check if an animation is required
            if scrollView.contentOffset.y > .zero &&
                HeaderContraint.constant > .zero {
                
                HeaderContraint.constant = .zero
                headerView.isHidden = true
                animateTopViewHeight()
            }
            else if scrollView.contentOffset.y <= .zero
                        && HeaderContraint.constant <= .zero {
                
                HeaderContraint.constant = viewHeight
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


struct CoorporationActionHolder {
    var title: String?
    var array: [LastAction]?
}
