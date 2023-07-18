//
//  PopUpOTP.swift
//  SDC
//
//  Created by Blue Ray on 14/04/2023.
//

import UIKit
import JGProgressHUD
import Alamofire

class PopUpOTP: UIViewController {

    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var otpTxt: UITextField!
    
    
    @IBOutlet weak var verificationMessage: DesignableLabel!
    @IBOutlet weak var recoveryInput: UILabel!
    
    @IBOutlet weak var resendCodeLabel: DesignableLabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var otp : String?
    var uniqueID : String?
    var recoveryField : String?
    var flag : String?

    
    var remainingTime = 60
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if flag == "1" {
            verificationMessage.text = "A message containing OTP code were sent to the Email"
        }

        else if flag == "2" {
            verificationMessage.text = "A message containing OTP code were sent to the Mobile"
        }
        
        recoveryInput.text = recoveryField
        resendCodeLabel.textColor = .lightGray

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
                self?.updateTimer()
            })
        
    }
    
    
    @IBAction func resendCodePressed(_ sender: Any) {
        
        self.updateTimer()
    }
    


    @IBAction func Next(_ sender: Any) {
        
        if otpTxt.text != "" {
            self.validateOTP(OTP: otpTxt.text ?? "")
        }
        
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
                        
                       
                        hud.dismiss()
                        
                    self.dismiss(animated: true , completion: {
                                let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                                    
                                let vc = storyBoard.instantiateViewController(withIdentifier: "CreatePassword") as! CreatePassword
                                vc.modalPresentationStyle = .overCurrentContext
                                                    
                                self.present(vc, animated: true , completion: nil)
                                
                            })
                            
                       
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
    
    func updateTimer() {
        if remainingTime > 0 {
            remainingTime -= 1
            timerLabel.text = "\(remainingTime) seconds remaining"
        } else {
            
            resendCodeLabel.textColor = .black
            timer?.invalidate()
            timer = nil
        }
    }
   
}
