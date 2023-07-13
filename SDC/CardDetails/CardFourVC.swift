//
//  CardFourVC.swift
//  SDC
//
//  Created by Blue Ray on 14/04/2023.
//

import UIKit
import Alamofire
import MOLH
import JGProgressHUD

// Account info

class CardFourVC: UIViewController {
    

    @IBOutlet weak var pCity: UILabel!
    @IBOutlet weak var pCountry: UILabel!
    @IBOutlet weak var backgroundStack: UIStackView!
//    @IBOutlet weak var bellView : UIView!
    @IBOutlet weak var memberNumber: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var documentType: UILabel!
    @IBOutlet weak var documentNumber: UILabel!
    @IBOutlet weak var accountID: UILabel!
    @IBOutlet weak var accountType: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var expiryDate: UILabel!
    @IBOutlet weak var documentRefernce: UILabel!
    @IBOutlet weak var identificationNumber: UILabel!
    @IBOutlet weak var bankType: UILabel!
    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var bankID: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var postalCode: UILabel!
    @IBOutlet weak var postalBox: UILabel!
    @IBOutlet weak var bankBranch: UILabel!
    @IBOutlet weak var branchSwiftCode: UILabel!
    @IBOutlet weak var curreny: UILabel!
    @IBOutlet weak var accountStack: UIStackView!
    @IBOutlet weak var addressStack: UIStackView!
    @IBOutlet weak var statusDate: UILabel!
    @IBOutlet weak var accountStatus: UILabel!
    @IBOutlet weak var nationality: UILabel!
    @IBOutlet weak var investorNo: UILabel!
    @IBOutlet weak var guardianType: UILabel!
    @IBOutlet weak var guardianName: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var fax: UILabel!
    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var buildingNo: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var mobile: UILabel!
    
    var invAccount : AccountOwnerShape?
    var invInfo :  AccountInfo?
    var memberId:String = ""
    var accountNo:String = ""
    var balanceType:String = ""
    var securityId:String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAccountInfo()
//        self.cerateBellView(bellview: bellView, count: "12")
        
    }
    override func viewDidLayoutSubviews() {
        accountStack.roundCorners([.topLeft, .topRight], radius: 12)
        addressStack.roundCorners([.topLeft, .topRight], radius: 12)
    }
    
    // Api call
    
    func getAccountInfo() {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)

        let endpoint = URL(string:APIConfig.GetAccountInvInfo)
        let param: [String: Any] = [
            "sessionId" : Helper.shared.getUserSeassion() ?? "" ,
            "memberId" : self.memberId,
            "accountNo" :  self.accountNo ,
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


                                    let memberId = data!["memberId"] as? String
                                    self.memberNumber.text =  memberId ?? ""
                                    
                                    let memberName = data!["memberName"] as? String
                                    self.name.text = memberName ?? ""
                                    
                                    let idDocTypeDesc = data!["idDocTypeDesc"] as? String
                                    self.documentType.text = idDocTypeDesc ?? ""
                                    
                                    let idDocNo = data!["idDocNo"] as? String
                                    self.documentNumber.text =  idDocNo ?? ""
                                    
                                    let accountNo = data!["accountNo"] as? String
                                    self.accountID.text =  accountNo ?? ""

                                    let accountTypeDesc = data!["accountTypeDesc"] as? String
                                    self.accountType.text = accountTypeDesc ?? ""
                                   
                                    let idDocDate = data!["idDocDate"] as? String
                                    self.releaseDate.text = self.convertDate(dateString: idDocDate ?? "")

                                    
                                    
                                    let idDocExpDate = data!["idDocExpDate"] as? String
                                    self.expiryDate.text = self.convertDate(dateString: idDocExpDate ?? "")
                                    
                                    let idDocReference = data!["idDocReference"] as? String
                                    self.documentRefernce.text = idDocReference ?? ""
                                    
                                    let identificationNo = data!["identificationNo"] as? String
                                    self.identificationNumber.text = identificationNo ?? ""
                                    
                                    let pobox = data!["pobox"] as? String
                                    self.postalBox.text =  pobox ?? ""

                                    let postalCode = data!["postalCode"] as? String
                                    self.postalCode.text =  postalCode ?? ""
                                    
                                    let postalCountry = data!["postalCountry"] as? String
                                    self.country.text = postalCountry ?? ""
                                    
                                    let postalCity = data!["postalCity"] as? String
                                    self.city.text = postalCity ?? ""
                                    
                                    let country = data!["resCountry"] as? String
                                    self.pCountry.text = postalCountry ?? ""
                                    
                                    let city = data!["resCity"] as? String
                                    self.pCity.text = city ?? ""
                                    
                                    
                                    
                                    let bankName = data!["bankName"] as? String
                                    self.bankName.text = bankName ?? ""
                                    
                                    let bankId = data!["bankId"] as? String
                                    self.bankID.text = bankId ?? ""
                                    
                                    let bankTypeDesc = data!["bankTypeDesc"] as? String
                                    self.bankType.text = bankTypeDesc ?? ""
                                    
                                    let clientStatusDesc = data!["clientStatusDesc"] as? String
                                    self.accountStatus.text = clientStatusDesc ?? ""
                                    
                                    
                                    let statusDate = data!["statusDate"] as? String
                                    self.statusDate.text = self.convertDate(dateString: statusDate ?? "")
                                    
                                    
                                    let branchName = data!["branchName"] as? String
                                    self.bankBranch.text = branchName ?? ""
                                    
                                    
                                    let branchSwiftCode = data!["branchSwiftCode"] as? String
                                    self.branchSwiftCode.text = branchSwiftCode ?? ""
                                    
                                    
                                    let bankAccCurrDesc = data!["bankAccCurrDesc"] as? String
                                    self.curreny.text = bankAccCurrDesc ?? ""
                                    
                                    
                                    
                                    let resAddress1 = data!["resAddress1"] as? String
                                    self.address.text = resAddress1 ?? ""
                                    
                                    let resBuildingNo = data!["resBuildingNo"] as? String
                                    self.buildingNo.text = resBuildingNo ?? ""
                                    
                                    let resStreet = data!["resStreet"] as? String
                                    self.street.text = resStreet ?? ""
                                    
                                    let resArea = data!["resArea"] as? String
                                    self.area.text = resArea ?? ""
                                    
                                    
                                    let phone = data!["phone"] as? String
                                    self.phone.text =  phone ?? ""
                                    
                                    let fax = data!["fax"] as? String
                                    self.fax.text = fax ?? ""
                                    
                                    let mobile = data!["mobile"] as? String
                                    self.mobile.text =  mobile ?? ""
                                    
                                    let email = data!["email"] as? String
                                    self.email.text = email ?? ""
                                    
                                    
                                    let guardianName = data!["guardianName"] as? String
                                    self.guardianName.text = guardianName ?? ""
                                    
                                    let guardianNat = data!["guardianNat"] as? String
                                    self.nationality.text = guardianNat ?? ""
                                    
                                    let guardianTypeDesc = data!["guardianTypeDesc"] as? String
                                    self.guardianType.text = guardianTypeDesc ?? ""
                                    
                                    // inv No ??
                                    
                                    let custNo = data!["custNo"] as? String
                                    self.investorNo.text = custNo ?? ""
                                    
                                    
                                    DispatchQueue.main.async {
                                        hud.dismiss(afterDelay: 1.5, animated: true,completion: {

                                        })


                                    }

                                }




                                else if status == 400{
                                    let msg = jsonObj!["message"] as? String
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
                self.internetError(hud: hud)
               
            }
        }
    }
}
