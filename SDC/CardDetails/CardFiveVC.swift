//
//  CardFiveVC.swift
//  SDC
//
//  Created by Razan Barq on 17/04/2023.
//

import UIKit
import Alamofire
import MOLH
import JGProgressHUD

class CardFiveVC: UIViewController {

    @IBOutlet weak var bellView: UIButton!
    
    
    
    @IBOutlet weak var nickname: UILabel!
    
    
    @IBOutlet weak var name: UILabel!
    
   
    
    @IBOutlet weak var nationality: UILabel!
    
    @IBOutlet weak var motherName: UILabel!
    
    @IBOutlet weak var jobTitle: UILabel!
    
    @IBOutlet weak var investorClassification: UILabel!
    
    
    @IBOutlet weak var investorType: UILabel!
    
    
    @IBOutlet weak var investorStatus: UILabel!
    
    
    @IBOutlet weak var language: UILabel!
    
    @IBOutlet weak var birthDate: UILabel!
    
    
    @IBOutlet weak var gender: UILabel!
    
    
    @IBOutlet weak var taxNumber: UILabel!
    
    @IBOutlet weak var statusDate: UILabel!
    
    @IBOutlet weak var educationDegree: UILabel!
    
    @IBOutlet weak var documentType: UILabel!
    
    @IBOutlet weak var documentNumber: UILabel!
    
    @IBOutlet weak var identificationNumber: UILabel!
    
    
    @IBOutlet weak var documentReference: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var expiryDate: UILabel!
    
    
    @IBOutlet weak var city: UILabel!
    
    @IBOutlet weak var postalBox: UILabel!
    
    @IBOutlet weak var postalCode: UILabel!
    
    @IBOutlet weak var country: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cerateBellView(bellview: bellView, count: "12")
        self.getAccountInfo()

        
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
                                    
                                    let title = data!["title"] as? String
                                    self.nickname.text = title ?? ""
                                    
                                    
                                    let clientName = data!["clientName"] as? String
                                
                                    self .name.text = clientName ?? ""
                                    
                                    
                                    let motherName = data!["motherName"] as? String
                                    self.motherName.text = motherName ?? ""
                                    
                                    let occupation = data!["occupation"] as? String
                                    self.jobTitle.text = occupation ?? ""
                                    
                                    
                                    let clientCatDesc = data!["clientCatDesc"] as? String
                                    self.investorClassification.text = clientCatDesc ?? ""
                                    
                                    
                                    let clientTypeDesc = data!["clientTypeDesc"] as? String
                                    self.investorType.text = clientTypeDesc ?? ""
                                    
                                    
                                    let clientStatusDesc = data!["clientStatusDesc"] as? String
                                    self.investorType.text = clientStatusDesc ?? ""
                                    
                                    let languageDesc = data!["languageDesc"] as? String
                                    self.language.text = languageDesc ?? ""
                                    
                                    let birthDate = data!["birthDate"] as? String
                                    self.birthDate.text = birthDate ?? ""
                                    
                                    let sexDesc = data!["sexDesc"] as? String
                                    self.gender.text = sexDesc ?? ""
                                    
                                    let scientificQualificationDesc = data!["scientificQualificationDesc"] as? String
                                    self.educationDegree.text = scientificQualificationDesc ?? ""
                                    
                                    let taxNo = data!["taxNo"] as? String
                                    self.taxNumber.text = taxNo ?? ""
                                    
                                    
                                    let statusDate = data!["statusDate"] as? String
                                    self.statusDate.text = statusDate ?? ""
                                    
                                    
                                    let pobox = data!["pobox"] as? String
                                    self.postalBox.text = pobox ?? ""
                                    
                                    
                                    let
                                    postalCde = data!["postalCode"] as? String
                                    self.postalBox.text = postalCde ?? ""
                                    
                                    
                                    let postalCountry = data!["postalCountry"] as? String
                                    self.country.text = postalCountry ?? ""
                                    
                                    
                                    let postalCity = data!["postalCity"] as? String
                                    self.city.text = postalCity ?? ""
                                    
                                    let idDocTypeDesc = data!["idDocTypeDesc"] as? String
                                    self.documentType.text = idDocTypeDesc ?? ""
                                    
                                    let idDocNo = data!["idDocNo"] as? String
                                    self.documentNumber.text = idDocNo ?? ""
                                    
                                    let idDocReference = data!["idDocReference"] as? String
                                    self.documentReference.text = idDocReference ?? ""
                                    
                                    let idDocDate = data!["idDocDate"] as? String
                                    self.releaseDate.text = idDocDate ?? ""
                                    
                                    let identificationNo = data!["identificationNo"] as? String
                                    self.identificationNumber.text = identificationNo ?? ""
                                    
                                    let idDocExpDate = data!["idDocExpDate"] as? String
                                    self.expiryDate.text = idDocExpDate ?? ""


                                        
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