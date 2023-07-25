//
//  AccountStatement.swift
//  SDC
//
//  Created by Blue Ray on 15/04/2023.
//

import UIKit
import MOLH
import JGProgressHUD
import Alamofire


class AccountStatement: UIViewController,DataSelectedDelegate{
    
    @IBOutlet weak var datePicker2: UIDatePicker!
    @IBOutlet weak var nameStack: UIStackView!
    @IBOutlet weak var searchBtn: DesignableButton!
    
    // set title for picker's buttons when is selected from picker vc
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var accountIDStack: UIStackView!
    
    @IBOutlet weak var fromDate: DesignableLabel2!
    @IBOutlet weak var toDate: DesignableLabel2!
    //    @IBOutlet weak var bellView: UIView!
    @IBOutlet weak var membername: UIButton!
    @IBOutlet weak var accountNumberBtn: UIButton!
    @IBOutlet weak var literalnumber: UIButton!
    @IBOutlet weak var secutrtyNameBtn: UIButton!
    @IBOutlet weak var mebemrCodeBtn: UIButton!
    
    
    var accountList =  [AccountListModel]()
    var invAccount = [InvestoreOwnerShape]()
    var accountName = [String]()
    var numberCode = [String]()
    var securityName = [String]()
    var securityIDs = [String]()
    var accounNumber = [String]()
    var memberNum = [String]()
    var accountID = [AccountIDModel]()
    //    var isZeroSelected : Bool?
    //    var isWithoutSelected : Bool?
    var withZeroFlag : String?
    var dataArray = [PartialDataModel]()
    var fromDateString : String?
    var toDateString : String?
    var memberID : String?
    var accountNo : String?
    var securityID : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        nameStack.isHidden = true
//        accountIDStack.isHidden = true
        //        searchBtn.isHidden = true
//        datePicker.isHidden = true
//        datePicker2.isHidden = true
//        fromDate.isHidden = true
//        toDate.isHidden = true
        self.getAccountList()
        self.getInvestoreInfo(withZero: withZeroFlag ?? "" )
        
     
        datePicker.datePickerMode = .date
        datePicker.date = Date() // Set an initial date if needed
        
        // Set the minimum and maximum dates
        let calendar = Calendar.current
        let currentDate = Date()
        
        // Calculate the date one month ago
        guard let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: currentDate) else {
            return
        }
        
        datePicker.minimumDate = oneMonthAgo
        datePicker.maximumDate = currentDate
        
        
        
    }
    
    
    
    //function for change background selected background color for with and without zero btn
    
    //    func highlightedButtons() {
    //        invAccount.removeAll()
    //        securityName.removeAll()
    //        numberCode.removeAll()
    //
    //        self.secutrtyNameBtn.setTitle("-", for: .normal)
    //        self.mebemrCodeBtn.setTitle("-", for: .normal)
    //        self.membername.setTitle("-", for: .normal)
    //        self.accountNumberBtn.setTitle("-", for: .normal)
    //
    //
    //        if isZeroSelected  == true && isWithoutSelected == false {
    //            DispatchQueue.main.async {
    //                self.withZero.setTitleColor(.white, for: .normal)
    //                self.withZero.backgroundColor  = UIColor(named: "AccentColor")
    //                self.withoutZero.titleLabel?.textColor = UIColor(named: "AccentColor")
    //                self.withoutZero.backgroundColor  = .systemGray6
    ////                self.withoutZero.cornerRadius = 12
    //                self.withoutZero.borderColor =  UIColor(named: "AccentColor")
    //                self.withoutZero.borderWidth = 1
    //                self.getInvestoreInfo(withZero: self.withZeroFlag ?? "")
    //            }
    //        }
    //        else if isZeroSelected == false  && isWithoutSelected == true {
    //            DispatchQueue.main.async {
    //                self.withoutZero.setTitleColor(.white, for: .normal)
    //                self.withoutZero.backgroundColor  = UIColor(named: "AccentColor")
    //                self.withZero.titleLabel?.textColor = UIColor(named: "AccentColor")
    //                self.withZero.backgroundColor  = .systemGray6
    ////                self.withZero.cornerRadius = 12
    //                self.withZero.borderColor =  UIColor(named: "AccentColor")
    //                self.withZero.borderWidth = 1
    //                self.getInvestoreInfo(withZero: self.withZeroFlag ?? "")
    //            }
    //        }
    //
    //    }
    
    
    //    @IBAction func withoutZeero(btn:UIButton){
    //
    //        withZeroFlag = "0"
    //        isWithoutSelected = true
    //        isZeroSelected = false
    //        highlightedButtons()
    //    }
    
    
    
    
    
    func getSelectdPicker(selectdTxt: String, securtNumber: String, flag: String, securtyId: String, secMarket: String, secStatus: String, secISIN: String) {
        
        
        if flag == "0"{
//            accountIDStack.isHidden = false
            self.membername.setTitle(selectdTxt, for: .normal)
            self.getMemberID(memberID: securtNumber)
            self.accountNumberBtn.setTitle("choose".localized(), for: .normal)
            self.memberID = securtNumber
            self.securityID = securtyId
            
        } else if flag == "1" {
            self.accountNumberBtn.setTitle(selectdTxt, for: .normal)
            self.accountNo = selectdTxt
        }
        
        else if flag == "2" {
            self.secutrtyNameBtn.setTitle(selectdTxt, for: .normal)
            
        }else {
            
        }
    }
    
    
    @IBAction func downloadButtonPressed(_ sender: UIButton) {
        
        if membername.titleLabel?.text != "" && accountNumberBtn.titleLabel?.text != "" && secutrtyNameBtn .titleLabel?.text != "" && fromDateString != "" && toDateString != "" {
            self.getPDF()

        }
        
        else {
            self.showErrorHud(msg: "Please fill all required fields".localized())
        }
        
        
    }
    
    
    // When pressed one of the three pickers
    
    @IBAction func gooingToPicker(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PickerVC") as! PickerVC
        
        vc.dataSelectedDelegate = self
        vc.checkAccountStatmnt = true
        
        switch sender.tag {
        case 0:
            vc.dataFilterd = accountName
            vc.memberNum = memberNum
            vc.securityIDs = self.securityIDs
            vc.checkFlag = "0"
        case 1:
            vc.dataFilterd = accounNumber
            vc.checkFlag = "1"
            
        case 2:
            vc.dataFilterd = securityName
            vc.reuterCode = numberCode
            vc.checkFlag = "2"
            
            
        case 3:
            vc.dataFilterd = numberCode
            vc.checkFlag = "3"
            
            
        default:
            return
            print("default Value")
            
        }
        
        self.present(vc, animated: true)
        
    }
    
    
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
        let selectedDate = sender.date
        
        // Handle the selected date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: selectedDate)
        fromDateString = dateFormatter.string(from: selectedDate)
        
//        datePicker2.isHidden = false
//        toDate.isHidden = false
        
        datePicker2.datePickerMode = .date
        datePicker2.date = Date() // Set an initial date if needed
        
        // Set the minimum and maximum dates
        let calendar = Calendar.current
        let currentDate = Date()
        
        // Calculate the date one month later
        guard let oneMonthLater = calendar.date(byAdding: .month, value: 1, to: currentDate) else {
            return
        }
        
        datePicker2.minimumDate = selectedDate
        datePicker2.maximumDate = currentDate
        
        
        
    }
    
    
    @IBAction func datePicker2Changed(_ sender: UIDatePicker) {
        
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        toDateString = dateFormatter.string(from: selectedDate)
        self.toDateString = dateFormatter.string(from: selectedDate)
        //        searchBtn.isHidden = false
        
    }
    
    
    
    // Api call for ````Picker data
    
    func getInvestoreInfo(withZero : String){
        
        let hud = JGProgressHUD(style: .light)
        //        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": MOLHLanguage.isRTLLanguage() ? "ar": "en" ,
                                    "with_zero" : "1"]
        
        let link = URL(string: APIConfig.GetInvOwnership)
        
        AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    if jsonObj != nil {
                       
                        
                        if let status = jsonObj!["status"] as? Int {
                            if status == 200 {
                                
                                
                                if let partialData = jsonObj!["partialData"] as? [[String: Any]]{
                                    
                                    for item in partialData {
                                        let model = PartialDataModel(data: item)
                                        self.dataArray.append(model)
                                        
                                        self.securityName.append(model.Security_Name ?? "")
                                        self.numberCode.append(model.Security_Reuter_Code ?? "")
                                        self.securityIDs.append(model.Security_Id ?? "")
                                        
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
    
    
    
    func getAccountList(){
        
        //
        let hud = JGProgressHUD(style: .light)
        //        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        
        
        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": MOLHLanguage.isRTLLanguage() ? "ar": "en" ,
                                    "with_zero" : "1"
                                    
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
                                        
                                        self.accountName.append(model.Member_Name ?? "")
                                        
                                        self.memberNum.append(model.Member_No ?? "")
                                        
                                        
                                        
                                        //                                                self.accounNumber.append(model.Account_No!)
                                        
                                    }
                                    DispatchQueue.main.async {
                                        
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
    
    
    func getMemberID(memberID : String){
        
        accounNumber.removeAll()
        
        let hud = JGProgressHUD(style: .light)
        //        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        
        
        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": MOLHLanguage.isRTLLanguage() ? "ar": "en" ,
                                    "memberId" : memberID
                                    
        ]
        
        let link = URL(string: APIConfig.getMemberId)
        
        AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    
                    if jsonObj != nil {
                        
                        if let status = jsonObj!["status"] as? Int {
                            if status == 200 {
                                
                                if let data = jsonObj!["data"] as? [[String: Any]]{
                                    for item in data {
                                        let model = AccountIDModel(data: item)
                                        self.accounNumber.append(model.Account_No ?? "")
                                        
                                        
                                    }
                                    DispatchQueue.main.async {
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
    
    func getPDF(){
        
        let hud = JGProgressHUD(style: .light)
//        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        
        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": MOLHLanguage.isRTLLanguage() ? "ar": "en" ,
                                    "memberId" : memberID ?? "" ,
                                    "accountNo" : accountNo  ?? "",
                                    "fromDate" : fromDateString  ?? "",
                                    "toDate" : toDateString  ?? "",
                                    "securityId" : securityID ?? ""
        ]
        
        let link = URL(string: APIConfig.GetAccountStatementPDF)
        
        AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    print(response.data)
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    if jsonObj != nil {
                        
                        
                        if let status = jsonObj!["status"] as? Int {
                            if response.response?.statusCode == 200 {
                                if let data = jsonObj!["data"] as? [String: Any]{
                                    let urlString = data["file"] as? String
                                    
                                    DispatchQueue.main.async {
                                        hud.dismiss()
                                        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                        let vc = storyBoard.instantiateViewController(withIdentifier: "PDFViewerVC") as! PDFViewerVC
                                        vc.flag = 1
                                        vc.url = urlString
                                        vc.modalPresentationStyle = .fullScreen
                                        self.present(vc, animated: true)
                                        
                                    }
                                }
                                
                            }
                            
                            else {
                                let msg = jsonObj!["message"] as? String
                                
                                self.showErrorHud(msg: msg ?? "", hud: hud)
                                
                            }
                        }
                    }
                    
                } catch let err as NSError {
                    print("Error: \(err)")
                }
            } else {
                print("Error")
              
                
            }
        }
        
    }
    
}
