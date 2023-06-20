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

// investor info

class CardFiveVC: UIViewController {

    @IBOutlet weak var natStack: UIStackView!
    @IBOutlet weak var invNationality: UILabel!
    @IBOutlet weak var bellView: UIButton!
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var investorNat: UILabel!
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
    @IBOutlet weak var nationalityBtn: UIButton!
    @IBOutlet weak var documentReference: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var expiryDate: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var postalBox: UILabel!
    @IBOutlet weak var postalCode: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var documentationStack: UIStackView!
    @IBOutlet weak var securityStack: UIStackView!
    @IBOutlet weak var placeOfBirth: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var buldingNo: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var fax: UILabel!
    @IBOutlet weak var email: UILabel!
    
    
    @IBOutlet weak var investorNo: UILabel!
    
    @IBOutlet weak var guardianNat: UILabel!
    @IBOutlet weak var inestorType: UILabel!
    @IBOutlet weak var inestorNo: UILabel!
    @IBOutlet weak var guardianName: UILabel!
    var clientNum : String?
    var checkSideMenu = false
    var nationalities = [Nationality]()
    var NatStatus : String?
    
    @IBAction func backPressed(_ sender: Any) {
        if checkSideMenu == true {
            self.dismiss(animated: true, completion: {
                let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.present(vc, animated: true, completion: nil)
            })
        }
    }
    
    override func viewDidLayoutSubviews() {
        securityStack.roundCorners([.topLeft, .topRight], radius: 12)
        documentationStack.roundCorners([.topLeft, .topRight], radius: 12)
    }
    
    @IBAction func nationalityPressed(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "NatPickerVC") as! NatPickerVC
        vc.nationalities = self.nationalities
        self.present(vc, animated: true)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if checkSideMenu == true {
            backBtn.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
            sideMenuBtn.setImage(UIImage(named: ""), for: .normal)
        }
        
        self.cerateBellView(bellview: bellView, count: "12")
        self.getAccountInfo()

        
    }
    
    // Api call when Account info button pressed
    
    func getAccountInfo() {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        
        
     
        let endpoint = URL(string:APIConfig.GetInvestorInfo)
        let param: [String: Any] = [
            "sessionId" : Helper.shared.getUserSeassion() ?? "" ,
            "lang": MOLHLanguage.isRTLLanguage() ? "ar": "en"
            
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
                                    self.clientNum = clientNo
                                    self.investorNo.text = clientNo ?? ""
                                    
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
                                    self.investorStatus.text = clientStatusDesc ?? ""
                                    
                                    let languageDesc = data!["languageDesc"] as? String
                                    self.language.text = languageDesc ?? ""
                                    
                                    let birthDate = data!["birthDate"] as? String
                                    self.birthDate.text = self.convertDateToArabicNumbers(dateString: birthDate ?? "")
                                    
                                    let sexDesc = data!["sexDesc"] as? String
                                    self.gender.text = sexDesc ?? ""
                                    
                                    let scientificQualificationDesc = data!["scientificQualification"] as? String
                                    self.educationDegree.text = scientificQualificationDesc ?? ""
                                    
                                    let taxNo = data!["taxNo"] as? String
                                    self.taxNumber.text = taxNo ?? ""
                                    
                                    
                                    let statusDate = data!["statusDate"] as? String
                                    self.statusDate.text = self.convertDateToArabicNumbers(dateString: statusDate ?? "")
                                    
                                    
                                    let pobox = data!["pobox"] as? String
                                    self.postalBox.text = self.convertIntToArabicNumbers(intString: pobox ?? "")
                                    
                                    
                                    let
                                    postalCde = data!["postalCode"] as? String
                                    self.postalCode.text = self.convertIntToArabicNumbers(intString: postalCde ?? "")
                                    
                                    
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
                                    self.releaseDate.text = self.convertDateToArabicNumbers(dateString: idDocDate ?? "")
                                    
                                    let identificationNo = data!["identificationNo"] as? String
                                    self.identificationNumber.text = identificationNo
                                    
                                    let idDocExpDate = data!["idDocExpDate"] as? String
                                    self.expiryDate.text = self.convertDateToArabicNumbers(dateString: idDocExpDate ?? "")
                                    
                                    
                                    // resAddress1
                                    
                                    let resAddress1 = data!["resAddress1"] as? String
                                    self.address.text = resAddress1 ?? ""
                                    
                                    let resBuildingNo = data!["resBuildingNo"] as? String
                                    self.buldingNo.text = resBuildingNo ?? ""
                                    
                                    let resStreet = data!["resStreet"] as? String
                                    self.street.text = resStreet ?? ""
                                    
                                    let resArea = data!["resArea"] as? String
                                    self.area.text = resArea ?? ""
                                    
                                    
                                    let phone = data!["phone"] as? String
                                    self.phone.text = self.convertIntToArabicNumbers(intString: phone ?? "")
                                    
                                    let fax = data!["fax"] as? String
                                    self.fax.text = fax ?? ""
                                    
                                    let mobile = data!["mobile"] as? String
                                    self.mobile.text = self.doubleToArabic(value: mobile ?? "")
                                    
                                    let birthPlace = data!["birthPlace"] as? String
                                    self.placeOfBirth                                   .text = birthPlace ?? ""
                                    
                                    let email = data!["email"] as? String
                                    self.email.text = email ?? ""
                                    
                                    
                                    // nationality
                                    let nationality = data!["nationality"] as? String
                                    self.email.text = nationality ?? ""
                                    self.invNationality.text = nationality
                                    
                                    // other_nationality_status
                                    let other_nationality_status = data!["other_nationality_status"] as? String
                                    
                                    self.NatStatus = other_nationality_status ?? ""
                                    
                                    
                                    
                                    
                                    self.getNationalities()
 
                                    DispatchQueue.main.async {
                                        hud.dismiss(afterDelay: 1.5, animated: true,completion: {
                      
                                        // hide and show stack
                                            
                                            if self.NatStatus == "1" {
                                                self.natStack.isHidden = true
                                            }
                                            
                                            else {
                                                self.natStack.isHidden = false
                                            }
                                            
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
    
    // Api call when Nationality button pressed
    
    func getNationalities(){
//
        let hud = JGProgressHUD(style: .light)
//        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)

    
     
        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "",
                                    "client_No" : self.clientNum!
                                     ,"lang": MOLHLanguage.isRTLLanguage() ? "ar": "en" ,

 ]
        let link = URL(string: APIConfig.GetNationality)

        AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                   

                    if jsonObj != nil {
                        if let status = jsonObj!["status"] as? Int {
                            if status == 200 {
                                if let data = jsonObj!["data"] as? [[String: Any]]{
                                            for item in data {
                                let model = Nationality(data: item)
                                self.nationalities.append(model)
                            print(self.nationalities)
                                 
                                            }
                                            
                        DispatchQueue.main.async {
                                                
                            hud.dismiss()
//                            self.nationalityBtn.setTitle(self.nationalities[0].Nationality ?? "" , for: .normal)

                            
                            self.invNationality.text = self.nationalities[0].Nationality ?? ""


                                            }
                                        }
                                
                                    }
//                             Session ID is Expired
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
              }
            } else {
                print("Error")

                self.serverError(hud: hud)


            }
        }
    }
   
}
