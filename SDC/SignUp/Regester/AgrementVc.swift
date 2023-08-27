//
//  AgrementVc.swift
//  SDC
//
//  Created by Blue Ray on 14/04/2023.
//

import UIKit
import MOLH
import Alamofire
import JGProgressHUD
class AgrementVc: UIViewController {

    @IBOutlet weak var nameTxt: DesignableLabel!
    @IBOutlet weak var centerPhoneTxt: DesignableLabel!
    @IBOutlet weak var phoneNumberTxt: DesignableLabel!
    @IBOutlet weak var btnAgree: DesignableButton!
    @IBOutlet weak var emailTxt: DesignableLabel!
    
    var flagAgree = 1
    
    var access_token  = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTxt.text = IdentfairVC.name 

        self.emailTxt.text = IdentfairVC.email
        
        self.phoneNumberTxt.text = IdentfairVC.phoneNum
        self.nameTxt.text = IdentfairVC.name

        self.getLoginToken()
    }
    
    
    
    func getLoginToken(){
      
//        let hud = JGProgressHUD(style: .light)
//        //        hud.textLabel.text = "Please Wait".localized()
//        hud.show(in: self.view)
        
        let param : [String:Any] = ["username" :"sdc","password": "sdc@2022"
        ]
        
        let link = URL(string: APIConfig.GetLoginToken)
        
        AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    
                    if jsonObj != nil {
                        if let success = jsonObj!["success"] as? Bool {
                            if success == true {
                                if let data = jsonObj!["data"] as? [String: Any]{
                                    
                                    
                                    let access_token = data["access_token"] as? String
                                    self.access_token = access_token ?? ""
//                                    hud.dismiss()
                                    
                                    
                                }
                                
                            }
                            //                             Session ID is Expired
                            else if success == false{
                                let msg = jsonObj!["message"] as? String
//                                self.showErrorHud(msg: msg ?? "" , hud: hud)
                                //                                self.seassionExpired(msg: msg ?? "")
                            }
                            
               
                        }
                        
                    }
                    
                } catch let err as NSError {
                    print("Error: \(err)")
//                    self.serverError(hud: hud)
                    
                }
            } else {
                print("Error")
//                self.serverError(hud: hud)
                
            }
        }
        
        
        
    }
    
    func regesterCall(){
        //
        let hud = JGProgressHUD(style: .light)
        //        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        

        
        let param : [String:Any] = [
            "operationtype" : 1,
            "cno": IdentfairVC.idNumber,
            "id_doc_type" :IdentfairVC.documentType,
            "id_doc_no" : IdentfairVC.documentNumber,
            "id_doc_date" :  "",
            "id_doc_reference" : "",
            "id_doc_exp_date" : IdentfairVC.expirDate,
            "id_family_book_no" : IdentfairVC.familRegester,
            "id_birth_date" : IdentfairVC.barithDay,
            "mobile":IdentfairVC.phoneNum,
            "email" : IdentfairVC.email,
            "lang": MOLHLanguage.isRTLLanguage() ? "ar": "en"

                
        ]
        
//        var headers = HTTPHeaders()
//
//        headers.add(name: "Authorization", value: "Bearer \(self.access_token)")
//
//        headers.add(name: "Accept", value: "application/json")
//        headers.add(name: "content-type", value: "application/json")
        
       
        
        let headers = HTTPHeaders(["Authorization": "Bearer \(self.access_token)"])
        

        let link = URL(string: APIConfig.createUssr)
        
        AF.request(link!, method: .post, parameters: param, headers: headers).response { (response) in
            
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    
                    if jsonObj != nil {
                        if let status = jsonObj!["success"] as? Bool {
                            
                            if status == true {
                                
                                let data = jsonObj!["data"] as? String
                                self.showSuccessHud(msg: data ?? "" , hud: hud)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                    
                                    self.createAccount()
                                }
                            }
                     
                            
                            //                                other Wise Problem
                            else {
                                
                                let message = jsonObj!["message"] as? String
                                self.showErrorHud(msg: message ?? "" , hud: hud)
                                
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
    
    
    
    @IBAction func agree(_ sender: Any) {
        
        // not agreed
        
        if flagAgree == 1 {
            let image = UIImage(named: "filled")
//            user Agree
            btnAgree.setImage(image, for: .normal)
            flagAgree = 2
            
           // agreed
            
        }else {
//            user DisAgree
            let image =
            UIImage(systemName: "square")?.withTintColor(UIColor(named: "AccentColor") ?? .green)
            
            btnAgree.setImage(image, for: .normal)
            flagAgree = 1
        }
    }
    @IBAction func next(_ sender: Any) {
        
        if flagAgree == 1 {
//            user agere call Api
        }else {
            
            self.regesterCall()

//            user should agree
        }
        
 
    }
    

    func createAccount(){
        
        self.dismiss(animated: true , completion: {
            
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            
            let vc = storyBoard.instantiateViewController(withIdentifier: "PopUpAccountCreated") as! PopUpAccountCreated
            
            vc.modalPresentationStyle = .overCurrentContext
        
            self.present(vc, animated: true,completion: nil)
            
        })
            
        
        // {self.dismiss(animated: true)}
    }
    
}


//test
//change design pop in two ways
