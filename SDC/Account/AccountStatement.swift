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
    
    // set title for picker's buttons when is selected from picker vc
    
  
    
    @IBOutlet weak var withoutZero: DesignableButton!
    @IBOutlet weak var withZero: DesignableButton!
    @IBOutlet weak var bellView: UIView!
    @IBOutlet weak var membername: UIButton!
    @IBOutlet weak var accountNumberBtn: UIButton!
    @IBOutlet weak var literalnumber: UIButton!
    @IBOutlet weak var secutrtyNameBtn: UIButton!
    @IBOutlet weak var mebemrCodeBtn: UIButton!
    @IBOutlet weak var fromDate: UIButton!
    @IBOutlet weak var toDate: UIButton!
    
    var accountList =  [AccountListModel]()
    var invAccount = [InvestoreOwnerShape]()
    var accountName = [String]()
    var numberCode = [String]()
    var securityName = [String]()
    var accounNumber = [String]()
    var isZeroSelected : Bool?
    var isWithoutSelected : Bool?
    var withZeroFlag : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.withoutZero.cornerRadius = 12
        self.withZero.cornerRadius = 12
        isZeroSelected = true
        isWithoutSelected = false
        withZeroFlag = "1"
        self.getAccountList()
        self.getInvestoreInfo(withZero: withZeroFlag ?? "" )

        // Do any additional setup after loading the view.
        
        self.cerateBellView(bellview: self.bellView, count: "12")
    }
    
    
    
    @IBAction func withZeero(btn:UIButton){
        invAccount.removeAll()
        securityName.removeAll()
        self.secutrtyNameBtn.setTitle("-", for: .normal)
        self.mebemrCodeBtn.setTitle("-", for: .normal)
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
        invAccount.removeAll()
        securityName.removeAll()
        self.secutrtyNameBtn.setTitle("-", for: .normal)
        self.mebemrCodeBtn.setTitle("-", for: .normal)
        withZeroFlag = "0"
        isWithoutSelected = true
        isZeroSelected = false
        highlightedButtons()
    }
    
    func getSelectdPicker(selectdTxt: String,securtNumber:String,flag: String,securtyId:String) {
        if flag == "0"{
            self.membername.setTitle(selectdTxt, for: .normal)

        }else if flag == "1" {
            self.accountNumberBtn.setTitle(selectdTxt, for: .normal)

        }
        else if flag == "2" {
            self.secutrtyNameBtn.setTitle(selectdTxt, for: .normal)

        }else {
            self.mebemrCodeBtn.setTitle(selectdTxt, for: .normal)

        }
    }
    
    

    @IBAction func nextBtn(_ sender: Any) {
        
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
            vc.checkFlag = "0"
        case 1:
            vc.dataFilterd = accounNumber
            vc.checkFlag = "1"

        case 2:
            vc.dataFilterd = securityName
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
    
    // Api call for ````Picker data
    
    func getInvestoreInfo(withZero : String){
        
        let hud = JGProgressHUD(style: .light)
//        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)

    
     
        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": MOLHLanguage.isRTLLanguage() ? "ar": "en" ,
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
                                                self.securityName.append(model.Security_Name!)
                                                self.numberCode.append(model.Security_Reuter_Code!)
                                 
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
                                    "with_zero" : withZero
                                    
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
                                                
                                                self.accountName.append(model.Member_Name!)
                                                self.accounNumber.append(model.Account_No!)
                                                self.accounNumber.append(model.Account_No!)
                                 
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
    
    
}

