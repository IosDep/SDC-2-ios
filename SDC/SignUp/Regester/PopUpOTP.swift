//
//  PopUpOTP.swift
//  SDC
//
//  Created by Blue Ray on 14/04/2023.
//

import UIKit
import MOLH
import Alamofire
import JGProgressHUD
import OTPFieldView

class PopUpOTP: UIViewController,UITextFieldDelegate,OTPFieldViewDelegate {

    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var otpTxt: UITextField!
    var timer: Timer?

    
//    1 ==> Phone Number Otp 2==> Email Otp
    var checkEmailPhone:String?
    
    var userDataInput:String?
    
    var uniqueID:String?
    
    @IBOutlet weak var otpTextFieldView: OTPFieldView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        
    }
    

    func setupOtpView(){
        self.otpTextFieldView.fieldsCount = 4
        self.otpTextFieldView.fieldBorderWidth = 2
        
        self.otpTextFieldView.defaultBorderColor = UIColor.black
        self.otpTextFieldView.filledBorderColor = UIColor.lightGray
        self.otpTextFieldView.cursorColor = UIColor.black
        
        self.otpTextFieldView.displayType = .roundedCorner
        self.otpTextFieldView.fieldSize = 40
        self.otpTextFieldView.separatorSpace = 8
        self.otpTextFieldView.shouldAllowIntermediateEditing = false
        self.otpTextFieldView.delegate = self
        self.otpTextFieldView.errorBorderColor = UIColor.blue
        
        self.otpTextFieldView.otpInputType = .numeric
        
        self.otpTextFieldView.initializeUI()
        
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
        
    }
    
    func enteredOTP(otp: String) {
        
        

        
//        if oprationType == "1"{
//            self.sendOtp(otp: otp)
//
//        }else {
//            self.sendOtpforRegest(otp: otp)
//        }
//
        
        self.validateOTP(OTP: otp)
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        return false
        
    }
    
    
    

    func validateOTP(OTP : String) {
                let hud = JGProgressHUD(style: .light)
                hud.show(in: self.view)
            
            let urlString = "http://194.165.152.9/otp-service/api/sdc/otp-validate"
                
            let endpoint = URL(string: urlString)
                
                
                let param: [String: Any] = [
                    "uniqueId": uniqueID ?? "",
                    "otp": OTP

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
                                
                                if  let code = jsonObj!["code"] as? Int {
                                    
                                    if code == 200 {
                                        
                                        let type = jsonObj!["type"] as? String
                                        
                                       
                        DispatchQueue.main.async {
                        self.showSuccessHud(msg: message ?? "OTP Verified")
                            
                           
                            if self.checkEmailPhone == "1" {
                                let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)


                                      let vc = storyBoard.instantiateViewController(withIdentifier: "EmailVc") as! EmailVc
                                      vc.modalPresentationStyle = .fullScreen
                          //
                                      self.present(vc, animated: true)
                                
                                
                                
                                
                                
                            }else {
                    //            email gooing to Summary
                                
                                
                                
                                let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                
                                
                                let vc = storyBoard.instantiateViewController(withIdentifier: "AgrementVc") as! AgrementVc
                                vc.modalPresentationStyle = .fullScreen
                                
                                self.present(vc, animated: true)
                                
                                
                                
                                
                                
                            }
                            
                            
                            
                            
                            
                            
              
                                
                           
                                        }
                                        
                                    }
                                    
                                    // ,completion: {self.dismiss(animated: true)}
                                    
    //                                => invalid otp
                                    else if code == 400 {
                                        
                                        let resendId = jsonObj!["resendId"] as? String
                                        
                                        self.showErrorHud(msg: message ?? "",hud: hud)
                                    }
                                    
                                    
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
    
    @IBAction func Next(_ sender: Any) {
        

        if self.otpTxt.text?.count == 5 {
            
            
            
        }else {
            self.showErrorHud(msg: "يرجى تعبئة الرقم الصحيح")
        }

        
    }
    
    
    
    
    
    
}
