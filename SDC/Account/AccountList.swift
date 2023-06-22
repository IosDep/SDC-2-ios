//
//  AccountList.swift
//  SDC
//
//  Created by Blue Ray on 04/04/2023.
//

import UIKit
import Alamofire
import MOLH
import JGProgressHUD

class AccountList: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableVIew: UITableView!
    @IBOutlet weak var roundview: UIView!
    @IBOutlet weak var bellView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var sideMenuBtn: UIButton!
    
    var accountList =  [AccountListModel]()
    var invAccount = [AccountOwnerShape]()
    var invInfo =  [AccountInfo]()
    var memberId:String = ""
    var accountNo:String = ""
    var checkSideMenu = false
    var refreshControl: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if checkSideMenu == true {
            backBtn.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
            sideMenuBtn.setImage(UIImage(named: ""), for: .normal)
        }
        tableVIew.dataSource = self
        tableVIew.delegate = self
        self.getAccountList()
        cerateBellView(bellview: self.bellView, count: "12")
        
        tableVIew.register(UINib(nibName: "AccountListXib", bundle: nil), forCellReuseIdentifier: "AccountListXib")
        
        //refreshControl
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        self.tableVIew.addSubview(refreshControl)
        
        // Do any additional setup after loading the view.
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
    
    @objc func didPullToRefresh() {
        self.accountList.removeAll()
        self.tableVIew.reloadData()
        self.getAccountList()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell = self.tableVIew.dequeueReusableCell(withIdentifier: "AccountListXib", for: indexPath) as? AccountListXib
        
        
        
        if cell == nil {
            let nib: [Any] = Bundle.main.loadNibNamed("AccountListXib", owner: self, options: nil)!
            cell = nib[0] as? AccountListXib
        }
        
        let data = accountList[indexPath.row]
        cell?.memberName.text = data.Member_Name
        cell?.memberNum.text =  data.Member_No ?? ""
        cell?.accountNum.text =  data.Account_No ?? ""
        cell?.accountName.text = data.accountTypeDesc
        
        
        cell?.accountOwnerShape.tag =  indexPath.row
        cell?.accountOwnerShape.addTarget(self, action: #selector(accountOwnerShape), for:.touchUpInside)
        
        cell?.profileInfo.tag =  indexPath.row
        
        cell?.profileInfo.addTarget(self, action: #selector(accountInfo), for:.touchUpInside)
        
        return cell!
        
    }
    
    // Action when Account ownership button pressed
    
    @objc func accountOwnerShape(sender: UIButton){
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "InvestorAccountOwnerShape") as! InvestorAccountOwnerShape
        vc.modalPresentationStyle = .fullScreen
        vc.memberId = self.accountList[sender.tag].Member_No ?? ""
        vc.accountNo =  self.accountList [sender.tag].Account_No ?? ""
        self.present(vc, animated: true)
        
    }
    
    // Action when Account info button pressed
    
    @objc func accountInfo(sender: UIButton){
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "CardFourVC") as! CardFourVC
        vc.memberId = self.accountList[sender.tag].Member_No ?? ""
        vc.accountNo =  self.accountList [sender.tag].Account_No ?? ""
        //        self.getAccountInfo()
        //        vc.invInfo = self.invInfo[sender.tag]
        
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true)
        
    }
    
    
    
    
    //    API Call
    
    func getAccountList(){
        
        //
        let hud = JGProgressHUD(style: .light)
        //        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        
        
        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": MOLHLanguage.isRTLLanguage() ? "ar": "en"
        ]
        
        let link = URL(string: APIConfig.GetAccountInfo)
        
        AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    
                    if jsonObj != nil {
                        
                        
                        
                        
                        if let status = jsonObj!["status"] as? Int {
                            if status == 200 {
                                if let data = jsonObj!["data"] as? [[String: Any]]{
                                    for item in data {
                                        let model = AccountListModel(data: item)
                                        self.accountList.append(model)
                                        
                                    }
                                    
                                    DispatchQueue.main.async {
                                        self.tableVIew.reloadData()
                                        self.refreshControl?.endRefreshing()
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
    
    //    func getAccountInfo() {
    //        let hud = JGProgressHUD(style: .light)
    //        hud.textLabel.text = "Please Wait".localized()
    //        hud.show(in: self.view)
    //
    //
    //
    //
    //        let endpoint = URL(string:APIConfig.GetAccountInfo)
    //        let param: [String: Any] = [
    //            "sessionId" : Helper.shared.getUserSeassion() ?? "" ,
    //            "memberId" : self.memberId,
    //            "accountNo" :  self.accountNo
    //        ]
    //
    //        AF.request(endpoint!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
    //            if response.error == nil {
    //                do {
    //                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
    //
    //                    if jsonObj != nil {
    //
    //                        //    object status
    //
    //                            if let status = jsonObj!["status"] as? Int {
    //
    //
    //
    //
    ////                                if status == 200 {
    ////                                     let message = jsonObj!["msg"] as? String
    ////
    ////                                    let data = jsonObj!["data"] as? [String:Any]
    ////
    ////
    ////                                    let clientNo = data!["clientNo"] as? String
    ////                                    self.memberNumber.text = clientNo ?? ""
    ////
    ////
    ////
    ////                                    let refClientNo = data!["refClientNo"] as? String
    ////                                    self.accountID.text = refClientNo ?? ""
    ////
    ////
    ////
    ////
    ////
    ////                                    let clientName = data!["clientName"] as? String
    ////                                    self.memberNumber.text = clientName ?? ""
    ////
    ////
    ////                                    let idDocNo = data!["idDocNo"] as? String
    ////                                    self.documentNumber.text = idDocNo ?? ""
    ////
    //////                                    idDocType
    ////
    ////                                    let idDocType = data!["idDocType"] as? String
    ////                                    self.documentType.text = idDocNo ?? ""
    ////
    ////                                    let postalCountry = data!["postalCountry"] as? String
    ////                                    self.country.text = postalCountry ?? ""
    ////
    ////
    ////                                    let statusDate = data!["statusDate"] as? String
    ////
    ////                                    self.releaseDate.text = statusDate ?? ""
    ////
    ////
    ////
    ////
    ////
    ////
    ////
    ////                                    DispatchQueue.main.async {
    ////                                        hud.dismiss(afterDelay: 1.5, animated: true,completion: {
    ////
    ////                                        })
    ////
    ////
    ////                                    }
    ////
    ////                                }
    //                                if status == 200 {
    //
    //
    //
    //                                    if let data = jsonObj!["data"] as? [[String: Any]]{
    //                                                for item in data {
    //
    //                                                    let model = AccountInfo(data: item)
    //                                                    self.invInfo.append(model)
    //
    //
    //                                                }
    //
    //                                                DispatchQueue.main.async {
    //
    //                                                    hud.dismiss()
    //    //                                                self.showSuccessHud(msg: message ?? "", hud: hud)
    //
    //    //                                                if self.car_arr.count == 0{
    //    //
    //    //
    //    //                                                    self.noDataImage.isHidden = false
    //    //                                                }else{
    //    //
    //    //                                                    self.noDataImage.isHidden = true
    //    //                                                }
    //
    //                                                }
    //                                            }
    //
    //                                        }
    //
    //
    //
    //                                else if status == 400{
    //                                    let msg = jsonObj!["message"] as? String
    //    //                                self.showErrorHud(msg: msg ?? "")
    //                                    self.seassionExpired(msg: msg ?? "")
    //                                }
    //
    //
    //
    //
    //    //                                other Wise Problem
    //                                else {
    //                                                    hud.dismiss(animated: true)      }
    //
    //
    //
    //
    //
    //                            }
    //
    //                    }
    //
    //                } catch let err as NSError {
    //                    print("Error: \(err)")
    //                    self.serverError(hud: hud)
    //                    //                        self.refreshControl?.endRefreshing()
    //                }
    //            } else {
    //                print("Error")
    //                self.internetError(hud: hud)
    //                //                    self.refreshControl?.endRefreshing()
    //            }
    //        }
    //    }
    func getAccountInfo() {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)

        let endpoint = URL(string:APIConfig.GetAccountInvInfo)
        let param: [String: Any] = [
            "sessionId" : Helper.shared.getUserSeassion() ?? "" ,
            "memberId" : self.memberId,
            "accountNo" :  self.accountNo ,
            "lang": MOLHLanguage.isRTLLanguage() ? "ar": "en"
        ]

        AF.request(endpoint!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]

                    if jsonObj != nil {

                        //    object status

                            if let status = jsonObj!["status"] as? Int {




                                if status == 200 {
                                     let message = jsonObj!["msg"] as? String

                                    let data = jsonObj!["data"] as? [String:Any]


                                    let memberId = data!["memberId"] as? String
                                    let memberName = data!["memberName"] as? String
                                    
                                    let idDocTypeDesc = data!["idDocTypeDesc"] as? String
                                    
                                    let idDocNo = data!["idDocNo"] as? String
                                    
                                    let accountNo = data!["accountNo"] as? String

                                    let accountTypeDesc = data!["accountTypeDesc"] as? String
                                   
                                    let idDocDate = data!["idDocDate"] as? String

                                    
                                    
                                    let idDocExpDate = data!["idDocExpDate"] as? String
                                    
                                    let idDocReference = data!["idDocReference"] as? String
                                    
                                    let identificationNo = data!["identificationNo"] as? String
                                    
                                    let pobox = data!["pobox"] as? String

                                    let postalCode = data!["postalCode"] as? String
                                    
                                    let postalCountry = data!["postalCountry"] as? String
                                    
                                    let postalCity = data!["postalCity"] as? String
                                    
                                    let bankName = data!["bankName"] as? String
                                    
                                    let bankId = data!["bankId"] as? String
                                    
                                    let bankTypeDesc = data!["bankTypeDesc"] as? String
                                    
                                    let clientStatusDesc = data!["clientStatusDesc"] as? String
                                    
                                    
                                    let statusDate = data!["statusDate"] as? String
                                    
                                    
                                    let branchName = data!["branchName"] as? String
                                    
                                    
                                    let branchSwiftCode = data!["branchSwiftCode"] as? String
                                    
                                    
                                    let bankAccCurrDesc = data!["bankAccCurrDesc"] as? String
                                    
                                    
                                    
                                    let resAddress1 = data!["resAddress1"] as? String
                                    
                                    let resBuildingNo = data!["resBuildingNo"] as? String
                                    
                                    let resStreet = data!["resStreet"] as? String
                                    
                                    let resArea = data!["resArea"] as? String
                                    
                                    
                                    let phone = data!["phone"] as? String
                                    
                                    let fax = data!["fax"] as? String
                                    
                                    let mobile = data!["mobile"] as? String
                                    
                                    let email = data!["email"] as? String
                                    
                                    
                                    let guardianName = data!["guardianName"] as? String
                                    
                                    let guardianNat = data!["guardianNat"] as? String
                                    
                                    let guardianTypeDesc = data!["guardianTypeDesc"] as? String
                                    
                                    // inv No ??
                                    
                                    let custNo = data!["custNo"] as? String
                                    
                                    
                                    DispatchQueue.main.async {
                                        hud.dismiss(afterDelay: 1.5, animated: true,completion: {

                                        })


                                    }

                                }




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
                self.internetError(hud: hud)
               
            }
        }
    }
    
    
}
