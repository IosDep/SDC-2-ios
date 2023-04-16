//
//  AccountInfoDetails.swift
//  SDC
//
//  Created by Blue Ray on 27/03/2023.
//

import UIKit
import MOLH
import Alamofire
import JGProgressHUD

class AccountInfoDetails: UIViewController {
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var bellView: UIView!
    
    
    
    @IBOutlet weak var mebmerNumber: UILabel!
    @IBOutlet weak var accountNumebr: UILabel!
    @IBOutlet weak var accountStatus: UILabel!
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var dateOfEntry: UILabel!
    @IBOutlet weak var documentType: UILabel!
    @IBOutlet weak var documentNumber: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var bankName: UILabel!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cerateBellView(bellview: self.bellView, count: "12")
        
        
//        self.getAccountInfo()
    }
    
    @IBAction func dimiss(sender:UIButton){self.dismiss(animated: true)}
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }
    
    
    
    func getAccountInfo() {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        
        
     
        let endpoint = URL(string:APIConfig.GetInvestorInfo)
        let param: [String: Any] = [
            "sessionId" : Helper.shared.getUserSeassion() ?? ""
        ]
        
        AF.request(endpoint!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    if jsonObj != nil {
                        
                        //    object status
                        
                            if let status = jsonObj!["status"] as? Int {
                                
                                
                                
                                
                                if status == 200 {
                                     let message = jsonObj!["msg"] as? String
                                    
                                    let data = jsonObj!["data"] as? [String:Any]
                                    
                                 
                                    let clientNo = data!["clientNo"] as? String
                                    self.mebmerNumber.text = clientNo ?? ""
                                    
                                    

                                    let refClientNo = data!["refClientNo"] as? String
                                    self.accountNumebr.text = refClientNo ?? ""

                                    
                                    
                                    

                                    let clientName = data!["clientName"] as? String
                                    self.memberName.text = clientName ?? ""


                                    let idDocNo = data!["idDocNo"] as? String
                                    self.documentNumber.text = idDocNo ?? ""
                                    
//                                    idDocType
                                    
                                    let idDocType = data!["idDocType"] as? String
                                    self.documentType.text = idDocNo ?? ""

                                    let postalCountry = data!["postalCountry"] as? String
                                    self.country.text = postalCountry ?? ""


                                    let statusDate = data!["statusDate"] as? String

                                    self.dateOfEntry.text = statusDate ?? ""
                



                                    
                                        
                                        
                                    DispatchQueue.main.async {
                                        hud.dismiss(afterDelay: 1.5, animated: true,completion: {
                      
                                        })
                                        
                                        
                                    }
                                    
                                }
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
