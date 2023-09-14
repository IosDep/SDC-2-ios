//
//  EmailVc.swift
//  SDC
//
//  Created by Blue Ray on 26/03/2023.
//

import UIKit
import MOLH
import Alamofire
import JGProgressHUD
class EmailVc: UIViewController {
    @IBOutlet weak var emailTxt: DesignableTextFeild!

    @IBOutlet weak var scroll: UIScrollView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }

    @IBAction func nextBtn(_ sender: Any) {
        
        
        if emailTxt.text != "" {
                        
            self.requestOTPEmail(email: self.emailTxt.text ?? "")
            
            
            
        }else {
            self.showErrorHud(msg: "الرجاء ادخال ايميل صحيح")
        }
        
        
        
    }
    
    
    func requestOTPEmail(email : String) {
            
                let hud = JGProgressHUD(style: .light)
                hud.show(in: self.view)
            
            let urlString = "http://194.165.152.9/otp-service/api/sdc/otp-request"
                
            let endpoint = URL(string: urlString)
                
                let param: [String: Any] = [
                    "email": email ,
                    "client_req_id" : IdentfairVC.idNumber ,
                    "service_name" : "eportfolio" , "lang": MOLHLanguage.isRTLLanguage() ? "ar" : "en" 
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
                                        
                                        
                                        IdentfairVC.email = self.emailTxt.text ?? ""
                                        
//                                        self.dismiss(animated: true , completion: {
                                        hud.dismiss()

                                        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                        let vc = storyBoard.instantiateViewController(withIdentifier: "PopUpOTP") as! PopUpOTP
                                        
                                        vc.forgetCreate = false
                                        vc.uniqueID = uniqueId
                                        vc.checkEmailPhone = "2"
                                        
                                        
                                        vc.modalPresentationStyle = .overCurrentContext
                                        self.present(vc, animated: true)
                                        
                                                                    
                                    }
                                    
//                                    )}
                                }
                                
                                else if code == 400 {
                                    let resendId = jsonObj!["resendId"] as? String
                                    
                                    let msgg = "Invalid Otp".localized()
                                    self.showErrorHud(msg: msgg ?? "" , hud: hud)
                                    
                                        }
                      
                         
                                else if code == 404 {
                                    let resendId = jsonObj!["resendId"] as? String
                                    
                                    let msgg = "OTP expired".localized()
                                    self.showErrorHud(msg: msgg ?? "" , hud: hud)
                                    
                                        }
                                
                                else if code == 504 {
                                    let resendId = jsonObj!["resendId"] as? String
                                    
                                    let msgg = "Already active otp".localized()
                                    self.showErrorHud(msg: msgg ?? "" , hud: hud)
                                    
                                        }
                                
                                else if code == 503 {
                                                    let msgg = "Service unavailable".localized()
                                                    self.showErrorHud(msg: msgg ?? "" , hud: hud)
                                                        }
                                                
                                else if code == 413 {
                                                    let msgg = "You have exceeded the allowed number of attempts, you can request a new verification code".localized()
                                                                    self.showErrorHud(msg: msgg ?? "" , hud: hud)
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
