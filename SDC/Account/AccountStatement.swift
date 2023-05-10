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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAccountList()
        self.getInvestoreInfo()

        // Do any additional setup after loading the view.
        
        self.cerateBellView(bellview: self.bellView, count: "12")
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
    
    // Api call
    
    func getInvestoreInfo(){
        
        let hud = JGProgressHUD(style: .light)
//        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)

    
     
        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": MOLHLanguage.isRTLLanguage() ? "ar": "en"
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
                                                self.numberCode.append(model.securityID!)
                                 
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
                                                
                                                self.accountName.append(model.Member_Name!)
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

