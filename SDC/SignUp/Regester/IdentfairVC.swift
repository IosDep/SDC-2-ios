//
//  IdentfairVC.swift
//  SDC
//
//  Created by Blue Ray on 26/03/2023.
//

import UIKit
import JGProgressHUD
import  Alamofire
import MOLH

class IdentfairVC: UIViewController {
    
    @IBOutlet weak var idTxt: DesignableTextFeild!
    @IBOutlet weak var scroll: UIScrollView!
    
//    var accountDetails : AccountDetails?
    
    
    
   static var name : String = ""
    static var  phoneNum : String = ""
    static var  email : String = ""
    static var idNumber :String = ""
    static  var documentType:String =  ""
    static  var documentNumber :String = ""
    static  var  expirDate:String = ""
    static var familRegester:String = ""
    static var barithDay:String = ""
    

    static var sessionId:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }

    @IBAction func nextBtn(_ sender: Any) {
        
        if self.idTxt.text?.count == 10
             
        {
            self.regesterApiCall()
            
        }else {
            self.showErrorHud(msg: "Invalid ID Num".localized())
        }
        
        
    }
    
    func regesterApiCall(){
        //
        let hud = JGProgressHUD(style: .light)
        //        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        let param : [String:Any] = ["userName" : self.idTxt.text ?? ""
        ]
        
        let link = URL(string: APIConfig.RegesterInfo)
        
        AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    
                    if jsonObj != nil {
                        
                        
                        let success = jsonObj!["success"] as? Bool
                        
                        if success == true {
                            
                            if let status = jsonObj!["status"] as? Int {
                            
                            if status == 200 {
                                
                                let message = jsonObj!["message"] as? String
                                
                                
                                let cname = jsonObj!["cname"] as? String
                                IdentfairVC.name = cname ?? ""
                                
                                self.showSuccessHud(msg: message ?? "" , hud: hud )
                                //                                hud.dismiss()
                                
                                let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                
                                IdentfairVC.idNumber = self.idTxt.text ?? ""
                                
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                    
                                    
                                    //                                self.dismiss(animated: true , completion: {
                                    
                                    let vc = storyBoard.instantiateViewController(withIdentifier: "DocumentType") as! DocumentType
                                    
                                    
                                    
                                    vc.modalPresentationStyle = .fullScreen
                                    
                                    self.present(vc, animated: true)
                                    
                                    //                                })
                                    
                                }
                                
                            }
                            //                             Session ID is Expired
                            else if status == 400{
                                let message = jsonObj!["message"] as? String
                                self.showErrorHud(msg: message ?? "" , hud: hud)
                                //                                self.seassionExpired(msg: msg ?? "")
                            }else if status == 404
                            {
                                let message = jsonObj!["message"] as? String
                                self.showErrorHud(msg: message ?? "" , hud: hud )
                                
                                
                            }
                            
                            
                            //                                other Wise Problem
                            else {
                                hud.dismiss(animated: true)      }
                        }
                    }
                        
                        else {
                            let message = jsonObj!["message"] as? String
                            self.showErrorHud(msg: message ?? "" , hud: hud )

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


