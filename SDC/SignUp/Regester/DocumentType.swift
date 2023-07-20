//
//  DocumentType.swift
//  SDC
//
//  Created by Blue Ray on 26/03/2023.
//


//picker  ==1 ==> Card Number ,2==> Passport
// if == 1  >> IdentfairVC.documentType == 1
//if == 2 >> IdentfairVC.documentType == 2
import UIKit
import JGProgressHUD
import  Alamofire
import MOLH

class DocumentType: UIViewController {
// 1 mean car 2 passeport
//    TODO picker View DocumentType ==> جواز سفر او بطاقة احوال
    @IBOutlet weak var DocumentType: DesignableTextFeild!   
    
    
    var idType:String = ""
    
//    رقم الوثيقة
    @IBOutlet weak var DocumentNumber : DesignableTextFeild!
    
//    تاريخ انتهاء الوثسقة
    @IBOutlet weak var expirDate: DesignableTextFeild!
    
    @IBOutlet weak var familyNumber: DesignableTextFeild!
    
    
    @IBOutlet weak var barthDay: DesignableTextFeild!
    @IBOutlet weak var name: DesignableTextFeild!
    
    

    
    @IBOutlet weak var scroll: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }
    @IBAction func nextBtn(_ sender: Any) {
        self.regesterApiCall(flag: self.idType)
        
        
        
    }
    
    
    
    
    func regesterApiCall(flag :String){
        //
        let hud = JGProgressHUD(style: .light)
        //        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        var param : [String:Any]
        
        //        1 ==> Card number 2 ==> Passport
        if flag == "1"{
            
            //        userName ==> ID Number
            param  = [
                "userName" : IdentfairVC.idNumber
                ,"cname": self.name.text ?? ""
                ,"birth_date": "1981-08-01"
                ,"famno": self.familyNumber.text ?? ""
                ,"card_no": self.DocumentNumber.text ?? ""
                ,"card_exp_dt": "2027-04-15"
                
                
            ]
        }else {
            //        userName ==> ID Number
            param  = [
                "userName" : IdentfairVC.idNumber
                ,"cname": self.name.text ?? ""
                ,"birth_date": "1981-08-01"
                ,"famno": self.familyNumber.text ?? ""
                ,"card_no": self.DocumentNumber.text ?? ""
                ,"card_exp_dt": "2027-04-15"
                
                
            ]
        }
        
        let link = URL(string: APIConfig.GetClintInf)
        
        AF.request(link!, method: .post, parameters: param).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    
                    if jsonObj != nil {
                        if let status = jsonObj!["status"] as? Int {
                            if status == 200 {
                                
                                 let message = jsonObj!["message"] as? String
                                self.showSuccessHud(msg: message ?? "", hud: hud)
                                
                                let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
//                                1 card 2 passport
                                
                                IdentfairVC.documentNumber =  self.DocumentNumber.text ?? ""
                                IdentfairVC.documentType =  self.idType

                                IdentfairVC.barithDay =  self.barthDay.text ?? ""
                                IdentfairVC.expirDate =  self.expirDate.text ?? ""
                                
                                
                                IdentfairVC.familRegester =  self.familyNumber.text ?? ""
                                
                              

                                IdentfairVC.name =  self.name.text ?? ""

                                    let vc = storyBoard.instantiateViewController(withIdentifier: "PhoneNumberVc") as! PhoneNumberVc

                                    vc.modalPresentationStyle = .fullScreen
                              
                                    self.present(vc, animated: true)
                                    
                                
                                
                                
                            }
                            //                             Session ID is Expired
                            else if status == 400{
                                let msg = jsonObj!["message"] as? String
                                                                self.showErrorHud(msg: msg ?? "",hud: hud)
//                                self.seassionExpired(msg: msg ?? "")
                            }
                            else if  status == 404{
                                    let msg = jsonObj!["message"] as? String
                                    self.showErrorHud(msg: msg ?? "",hud: hud)

                                
                                
                            }
                            
                            //                                other Wise Problem
                            else {
                                
                                let msg = jsonObj!["message"] as? String
                                                                self.showErrorHud(msg: msg ?? "",hud: hud)

                                
                                
                                
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
