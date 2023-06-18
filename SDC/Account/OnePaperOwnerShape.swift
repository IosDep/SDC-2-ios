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


class OnePaperOwnerShape: UIViewController ,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UISearchBarDelegate , DataSelectedDelegate{
    
    
    
    
    @IBOutlet weak var withZero: DesignableButton!
    @IBOutlet weak var withoutZero: DesignableButton!
    @IBOutlet weak var paperNameBtn: UIButton!
    @IBOutlet weak var search_bar: UISearchBar!
    @IBOutlet weak var literalNumBtn: UIButton!
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var busnissCard: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerConstrianett: NSLayoutConstraint!
    @IBOutlet weak var bellView: UIView!
    
    
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
        self.withoutZero.cornerRadius = 12
        self.withZero.cornerRadius = 12
        isZeroSelected = true
        isWithoutSelected = false
        withZeroFlag = "1"
        
        if checkSideMenu == true {
            sideMenuBtn.setImage(UIImage(named: ""), for: .normal)
        }
        
        self.cerateBellView(bellview: bellView, count: "12")
        self.getInvestoreInfo(withZero: withZeroFlag ?? "")
        self.busnissCard.delegate = self
        self.busnissCard.dataSource = self
        self.busnissCard.register(UINib(nibName: "BusnissCardTable", bundle: nil), forCellReuseIdentifier: "BusnissCardTable")
        
        
        search_bar.delegate = self
        
        
        
        //refreshControl
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        self.busnissCard.addSubview(refreshControl)
    }
    
    //    refresh action
    @objc func didPullToRefresh() {
        self.invAccount.removeAll()
        self.busnissCard.reloadData()
        
        
    }
    
    
    
    //    Tableview Configration
    
    
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        search_bar.text = ""
        seatrching = false
        self.arr_search.removeAll()
        busnissCard.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return securityOwnership.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CardOneVC") as! CardOneVC
        vc.modalPresentationStyle = .fullScreen
        vc.checkOnepaper = true
        vc.securityOwnership = self.securityOwnership[indexPath.row]
        self.present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = self.busnissCard.dequeueReusableCell(withIdentifier: "BusnissCardTable", for: indexPath) as? BusnissCardTable
        
//        if isCleared == true {
//            cell?.literalName.text = clearedSecData[indexPath.row].Security_Name
//            cell?.literalNum.text = clearedSecData[indexPath.row].Security_Id
//            cell?.balance.text =
//            clearedSecData[indexPath.row].Nominal_Value
//        }
//
//        else {
            cell?.literalName.text = securityOwnership[indexPath.row].Security_Name
        cell?.literalNum.text = self.convertIntToArabicNumbers(intString: securityOwnership[indexPath.row].Security_Id ?? "")
        
        cell?.sector.text =  securityOwnership[indexPath.row].Security_Sector_Desc ?? ""
        
        cell?.balance.text = self.doubleToArabic(value: securityOwnership[indexPath.row].Security_Close_Price ?? "")
            
            
//        }
        
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
        self.paperNameBtn.setTitle("-", for: .normal)
        self.literalNumBtn.setTitle("-", for: .normal)
        securityOwnership.removeAll()
        self.busnissCard.reloadData()
        
    }
    
    
    @IBAction func withZeero(btn:UIButton){
        DispatchQueue.main.async {
            self.securityOwnership.removeAll()
            self.busnissCard.reloadData()
        }
        secData.removeAll()
        self.paperNameBtn.setTitle("-", for: .normal)
        self.literalNumBtn.setTitle("-", for: .normal)
        withZeroFlag = "1"
        isZeroSelected = true
        isWithoutSelected = false
        highlightedButtons()
        
    }
    
    //function for change background selected background color for with and without zero btn
    
    func highlightedButtons() {
        
        if isZeroSelected  == true && isWithoutSelected == false {
            DispatchQueue.main.async {
                self.withZero.setTitleColor(.white, for: .normal)
                self.withZero.backgroundColor  = UIColor(named: "AccentColor")
                self.withoutZero.titleLabel?.textColor = UIColor(named: "AccentColor")
                self.withoutZero.backgroundColor  = .systemGray6
//                self.withoutZero.cornerRadius = 12
                self.withoutZero.borderColor =  UIColor(named: "AccentColor")
                self.withoutZero.borderWidth = 1
                self.getInvestoreInfo(withZero: self.withZeroFlag ?? "")
            }
        }
        else if isZeroSelected == false  && isWithoutSelected == true {
            DispatchQueue.main.async {
                self.withoutZero.setTitleColor(.white, for: .normal)
                self.withoutZero.backgroundColor  = UIColor(named: "AccentColor")
                self.withZero.titleLabel?.textColor = UIColor(named: "AccentColor")
                self.withZero.backgroundColor  = .systemGray6
//                self.withZero.cornerRadius = 12
                self.withZero.borderColor =  UIColor(named: "AccentColor")
                self.withZero.borderWidth = 1
                self.getInvestoreInfo(withZero: self.withZeroFlag ?? "")
            }
        }
        
    }
    
    
    @IBAction func withoutZeero(btn:UIButton){
        DispatchQueue.main.async {
            self.securityOwnership.removeAll()
            self.busnissCard.reloadData()
        }
        
        secData.removeAll()
        self.paperNameBtn.setTitle("-", for: .normal)
        self.literalNumBtn.setTitle("-", for: .normal)
        withZeroFlag = "0"
        isWithoutSelected = true
        isZeroSelected = false
        highlightedButtons()

    }
    
    
    
    // set title for picker's buttons when is selected from picker vc
    
    func getSelectdPicker(selectdTxt: String,securtNumber:String ,flag: String,securtyId:String) {
        
        if flag == "0"{
            selectedPaperName = selectdTxt
            self.paperNameBtn.setTitle(selectdTxt, for: .normal)
            
        } else  if flag == "1"{
            selectedLiteralNum = selectdTxt
            self.literalNumBtn.setTitle(securtNumber, for: .normal)
            
        }
        
        self.securtyIdToCallApi = securtyId
        
        print("Securty !!",securtyId)
        print("Securty !!",securtyId)
        
        
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
        //
        //    if self.securtyIdToCallApi?.isEmpty == true{
        //        self.showErrorHud(msg: "")
        //    }else {
        self.getSecurityOwnership(securtID: self.securtyIdToCallApi ?? "")
        //    }
    }
    
    
    func getInvestoreInfo(withZero : String){
        //
        let hud = JGProgressHUD(style: .light)
        //        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        
        
        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang":  "en" ,
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
                                        
                                        self.secData.append(SecurityData(secName: model.Security_Name ?? "", secNum: model.Security_Reuter_Code ?? "" , securotyID: model.securityID ?? "" ))
                                        
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
    
    func getSecurityOwnership(securtID:String){
        
        self.securityOwnership.removeAll()
        
        
        let hud = JGProgressHUD(style: .light)
        
        hud.show(in: self.view)
        
        
        
        let param : [String:Any] = [
            "sessionId" : Helper.shared.getUserSeassion() ?? ""
            ,"lang": "en",
            "securityId":self.securtyIdToCallApi ?? "" ,
            "with_zero" : "0"
        ]
        
        print("APIIII PRAMMM",param)
        
        
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
