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

class CardFourVC: UIViewController {
    

    @IBOutlet weak var backgroundStack: UIStackView!
    @IBOutlet weak var bellView : UIView!

    
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
    
    var invAccount : AccountOwnerShape?
    var invInfo :  AccountInfo?
    
    var memberId:String = ""
    var accountNo:String = ""

    var balanceType:String = ""
    var securityId:String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAccountInfo()
//        memberNumber.text = invInfo?.memberId ?? ""
//        name.text = invInfo?.memberName ?? ""
//        accountID.text = invInfo?.accountNo ?? ""
//        accountType.text = invInfo?.accountType ?? ""
//        documentType.text = invInfo?.idDocTypeDesc ?? ""
//        documentNumber.text = invInfo?.idDocNo ?? ""
//        releaseDate.text = invInfo?.idDocDate ?? ""
//        expiryDate.text = invInfo?.idDocExpDate ?? ""
//        documentRefernce.text = invInfo?.idDocReference ?? ""
//        identificationNumber.text = invInfo?.identificationNo ?? ""
//        postalBox.text = invInfo?.pobox ?? ""
//        postalCode.text = invInfo?.postalCode ?? ""
//        country.text = invInfo?.resCountry ?? ""
//        city.text = invInfo?.resCity ?? ""
//        bankName.text = invInfo?.bankName ?? ""
//        bankID.text = invInfo?.bankId ?? ""
//        bankType.text = invInfo?.bankTypeDesc ?? ""

        self.cerateBellView(bellview: bellView, count: "12")
        
    }
    
    
    
    
    
    func getAccountInfo() {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)

        let endpoint = URL(string:APIConfig.GetAccountInvInfo)
        let param: [String: Any] = [
            "sessionId" : Helper.shared.getUserSeassion() ?? "" ,
            "memberId" : self.memberId,
            "accountNo" :  self.accountNo
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
                                    self.memberNumber.text = memberId ?? ""
                                    let memberName = data!["memberName"] as? String
                                    self.name.text = memberName ?? ""
                                    
                                    let memberTypeDesc = data!["memberTypeDesc"] as? String
                                    self.documentType.text = memberTypeDesc ?? ""
                                    
                                    let idDocNo = data!["idDocNo"] as? String
                                    self.documentNumber.text = idDocNo ?? ""
                                    
                                    let accountNo = data!["accountNo"] as? String
                                    self.accountID.text = accountNo ?? ""

                                    let accountTypeDesc = data!["accountTypeDesc"] as? String
                                    self.accountType.text = accountTypeDesc ?? ""
                                   
                                    let idDocDate = data!["idDocDate"] as? String
                                    self.releaseDate.text = idDocDate ?? ""

                                    
                                    
                                    let idDocExpDate = data!["idDocExpDate"] as? String
                                    self.expiryDate.text = idDocExpDate ?? ""
                                    
                                    let idDocReference = data!["idDocReference"] as? String
                                    self.documentRefernce.text = idDocReference ?? ""
                                    
                                    let identificationNo = data!["identificationNo"] as? String
                                    self.identificationNumber.text = identificationNo ?? ""
                                    
                                    let pobox = data!["pobox"] as? String
                                    self.postalBox.text = pobox ?? ""

                                    let postalCode = data!["postalCode"] as? String
                                    self.postalCode.text = postalCode ?? ""
                                    
                                    let postalCountry = data!["postalCountry"] as? String
                                    self.country.text = postalCountry ?? ""
                                    
                                    let postalCity = data!["postalCity"] as? String
                                    self.city.text = postalCity ?? ""
                                    
                                    let bankName = data!["bankName"] as? String
                                    self.bankName.text = bankName ?? ""
                                    
                                    let bankId = data!["bankId"] as? String
                                    self.bankID.text = bankId ?? ""
                                    
                                    let bankTypeDesc = data!["bankTypeDesc"] as? String
                                    self.bankType.text = bankTypeDesc ?? ""


                                    DispatchQueue.main.async {
                                        hud.dismiss(afterDelay: 1.5, animated: true,completion: {

                                        })


                                    }

                                }
//                                if status == 200 {
//
//
//
//                                    if let data = jsonObj!["data"] as? [[String: Any]]{
//                                                for item in data {
//                                                    let model = AccountInfo(data: item)
//                                                    self.invInfo = model
//                                                }
//
//                                                DispatchQueue.main.async {
//
//                                                    hud.dismiss()
//    //                                                self.showSuccessHud(msg: message ?? "", hud: hud)
//
//    //                                                if self.car_arr.count == 0{
//    //
//    //
//    //                                                    self.noDataImage.isHidden = false
//    //                                                }else{
//    //
//    //                                                    self.noDataImage.isHidden = true
//    //                                                }
//
//                                                }
//                                            }
//
//                                        }



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
