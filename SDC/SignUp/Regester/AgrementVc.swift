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

        self.emailTxt.text = IdentfairVC.email
        
        self.phoneNumberTxt.text = IdentfairVC.phoneNum
        self.nameTxt.text = IdentfairVC.name

        self.getLoginToken()
    }
    
    
    
    func getLoginToken(){
        //
        let hud = JGProgressHUD(style: .light)
        //        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        let param : [String:Any] = ["username" :"Sdc","password": "sdc@2022"
        ]
        
        let link = URL(string: APIConfig.GetNotfication)
        
        AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    
                    if jsonObj != nil {
                        if let status = jsonObj!["success"] as? Bool {
                            if status == true {
                                if let data = jsonObj!["data"] as? [String: Any]{
                                    
                                    
                                    let access_token = data["access_token"] as? String
                                    self.access_token = access_token ?? ""
                                    
                                }
                                
                            }
                            //                             Session ID is Expired
                            else if status == false{
                                let msg = jsonObj!["message"] as? String
                                self.showErrorHud(msg: msg ?? "")
                                //                                self.seassionExpired(msg: msg ?? "")
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
    func regesterCall(){
        //
        let hud = JGProgressHUD(style: .light)
        //        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        
//        {
//
//            "operationtype" : 1,
//            "cno": "9811024746" ,
//            "id_doc_type": "2",
//            "id_doc_no": "ف375019",
//            "id_doc_date": null,
//            "id_doc_reference": null,
//            "id_doc_exp_date": "2025-11-22",
//            "id_family_book_no": "G416445",
//            "id_birth_date": "1981-08-01",
//            "mobile": "00962785756979",
//            "email": "aihamhammad09@gmail.com",
//            "lang":"en"
//        id_doc_type
         
        
        let param : [String:Any] = [
            "operationtype" : 1,
            "cno": IdentfairVC.idNumber,
            "id_doc_type" :IdentfairVC.documentType,
            "id_doc_date" :  "",
            "id_doc_reference" : "",
            "id_doc_exp_date" : IdentfairVC.expirDate,
            "id_family_book_no" : IdentfairVC.familRegester,
            "id_birth_date" : IdentfairVC.barithDay,
            "mobile":IdentfairVC.phoneNum,
            "email" : IdentfairVC.email,
            "lang": MOLHLanguage.isRTLLanguage() ? "ar": "en"

                
        ]
        let headers = HTTPHeaders(["Authorization": "Bearer \(self.access_token)"])

        
        let link = URL(string: APIConfig.createUssr)
        
        AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    
                    if jsonObj != nil {
                        if let status = jsonObj!["success"] as? Bool {
                            if status == true {
                                
                                let message = jsonObj!["message"] as? String
                                self.showErrorHud(msg: message ?? "")
                                self.createAccount()
                            }
                     
                            
                            //                                other Wise Problem
                            else {
                                hud.dismiss(animated: true)
                                
                                let message = jsonObj!["message"] as? String
                                self.showErrorHud(msg: message ?? "")
                                
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
        if flagAgree == 1 {
//            user Agree
            btnAgree.setImage(UIImage(systemName: "square.fill"), for: .normal)
            flagAgree = 2
            
        }else {
//            user DisAgree
            btnAgree.setImage(UIImage(systemName: "square"), for: .normal)
            flagAgree = 1
        }
        
        
        
    }
    @IBAction func next(_ sender: Any) {
        
        if flagAgree == 1 {
//            user agere call Api
        }else {
//            user should agree
            
        }
        
 
    }
    

    func createAccount(){
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)


            let vc = storyBoard.instantiateViewController(withIdentifier: "PopUpAccountCreated") as! PopUpAccountCreated
            vc.modalPresentationStyle = .overCurrentContext

        self.present(vc, animated: true,completion: {self.dismiss(animated: true)})
        
    }
    
}


//test
//change design pop in two ways
