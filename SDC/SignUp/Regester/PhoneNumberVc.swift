//
//  PhoneNumberVc.swift
//  SDC
//
//  Created by Blue Ray on 26/03/2023.
//


import UIKit
import MOLH
import Alamofire
import JGProgressHUD
import CountryPickerView



class PhoneNumberVc: UIViewController {
    
    
   
 
    
    @IBOutlet weak var phoneTxt: DesignableTextFeild!

    @IBOutlet weak var scroll: UIScrollView!
    
    
    @IBOutlet weak var countryPickerView: CountryPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countryPickerView.font = UIFont.systemFont(ofSize: 14.0)
        
//        countryPickerView.delegate = self
//        countryPickerView.dataSource = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }
    @IBAction func nextBtn(_ sender: Any) {
        
//        if self.phoneTxt.text?.count == 9 {
        
        if self.phoneTxt.text != "" {
            self.requestOTPMobile(mobile: self.removeLeadingZero(from: self.phoneTxt.text ?? ""))
        }
        
           
//        }else {
//            self.showErrorHud(msg: "Please fill Correct Phone Number")
//        }
        
    }
    
    
    func removeLeadingZero(from string: String) -> String {
        if string.hasPrefix("0") {
            return String(string.dropFirst())
        }
        return string
    }
    
       func requestOTPMobile(mobile : String) {
           
               let hud = JGProgressHUD(style: .light)
               hud.show(in: self.view)
               
           let urlString = "http://194.165.152.9/otp-service/api/sdc/otp-request"
           
           let endpoint = URL(string: urlString)
               
               let param: [String: Any] = [
                   "mobile": mobile ,
                   "client_req_id" : IdentfairVC.idNumber ,
                   "service_name" : "eportfolio"
               ]
           
           let username = "sdc"
           let password = "sdc@2022"
               
           let credentialData = "\(username):\(password)".data(using: .utf8)!
               let base64Credentials = credentialData.base64EncodedString()
               let headers = HTTPHeaders(["Authorization": "Basic \(base64Credentials)"])
               
               
               AF.request(endpoint!, method: .post, parameters: param , headers: headers).response { (response) in
                   if response.error == nil {
                       do {
                           let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                           
                           if jsonObj != nil {
                               
                               let message = jsonObj!["message"] as? String
                               
                               
                               let code = jsonObj!["code"] as? Int
                               
                               if code == 201 {
                                   
                                   let uniqueId = jsonObj!["uniqueId"] as? String
                                   
                                   let type = jsonObj!["type"] as? String
                                   
                                   
                                   DispatchQueue.main.async {
                                       
                                       IdentfairVC.phoneNum =    "00962\( self.removeLeadingZero(from: self.phoneTxt.text ?? "") ?? "")"
                                       
//                                       self.dismiss(animated: true , completion: {
                                           
                                           
                                           let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                           let vc = storyBoard.instantiateViewController(withIdentifier: "PopUpOTP") as! PopUpOTP
                                           
                                           vc.forgetCreate = false
                                           vc.uniqueID = uniqueId ?? "NO UNIaqyeID"
                                           vc.checkEmailPhone = "1"
                                           
                                           self.present(vc, animated: true)
                                           
                                           hud.dismiss()
                                           
//                                       })
                                       
                                   }
                               }
                               
                              
                               else {
                                   self.showErrorHud(msg: message ?? "" , hud: hud)
                               }
                               
                           }
                       } catch let err as NSError {
                           print("Error: \(err)")
                           self.serverError(hud: hud)
                           //                        self.refreshControl?.endRefreshing()
                       }
                   } else {
                       print("Error")
                       self.internetError(hud: hud)
                       //                    self.refreshControl?.endRefreshing()
                   }
               }
           }
    

}
