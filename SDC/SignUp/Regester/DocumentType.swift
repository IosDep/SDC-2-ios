//
//  DocumentType.swift
//  SDC
//
//  Created by Blue Ray on 26/03/2023.
//


//picker  ==1 ==> Card Number ,2==> Passport
// if == 1  >> IdentfairVC.documentType == 1
//if == 2 >> IdentfairVC.documentType == 2
import UIKit
import JGProgressHUD
import  Alamofire
import MOLH

class DocumentType: UIViewController , UIPickerViewDataSource , UIPickerViewDelegate{
    
    
   
    
   
// 1 mean car 2 passeport
//    TODO picker View DocumentType ==> جواز سفر او بطاقة احوال
    @IBOutlet weak var DocumentType: DesignableTextFeild!
    
    @IBOutlet weak var expiryDate: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    @IBOutlet weak var birthDate: DesignableLabel!
    //    رقم الوثيقة
    @IBOutlet weak var DocumentNumber : DesignableTextFeild!
    
//    تاريخ انتهاء الوثسقة
    
    @IBOutlet weak var familyNumber: DesignableTextFeild!
    
    
    
    
    var idType:String = "1"
    var expDate : String = ""
    var birthdayDate:String = ""

    
    @IBOutlet weak var scroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DocumentNumber.placeholder = "Identity Card".localized()
        pickerView.delegate = self
        pickerView.dataSource = self

        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }
    
    @IBAction func nextBtn(_ sender: Any) {
        self.regesterApiCall(flag: self.idType)
        
        
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "Identity Card".localized()
            
        }
        else if row == 1 {
            return "Passport".localized()
            }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            idType = "1"
            DocumentNumber.placeholder = "Identity Card".localized()

        }
        
        else if row == 1 {
            idType = "2"
            DocumentNumber.placeholder = "Passport".localized()
        }
        
    }
    
    @IBAction func expDateChanged(_ sender: UIDatePicker) {
        
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.expDate = dateFormatter.string(from: selectedDate)
        
    }
    
    @IBAction func birthDateChanged(_ sender: UIDatePicker) {
        
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.birthdayDate = dateFormatter.string(from: selectedDate)
        
    }
    
    
    
    func regesterApiCall(flag :String){
        //
        let hud = JGProgressHUD(style: .light)
        //        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        var param : [String:Any]
        
        //        1 ==> Card number 2 ==> Passport
        if flag == "1"{
            
            //        userName ==> ID Number
            param  = [
                "userName" : IdentfairVC.idNumber
                ,"birth_date": birthdayDate ?? ""
                ,"famno": self.familyNumber.text ?? ""
                ,"card_no": self.DocumentNumber.text ?? ""
                ,"card_exp_dt": expDate ?? ""
                
                
            ]
        }else {
            //        userName ==> ID Number
            param  = [
                "userName" : IdentfairVC.idNumber
                ,"birth_date": birthdayDate ?? ""
                ,"famno": self.familyNumber.text ?? ""
                ,"passno": self.DocumentNumber.text ?? ""
                ,"pass_exp_dt": expDate ?? ""
                
                
            ]
        }
        
        let link = URL(string: APIConfig.GetClintInf)
        
        AF.request(link!, method: .post, parameters: param).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    
                    if jsonObj != nil {
                        if let status = jsonObj!["status"] as? Int {
                            if status == 200 {
                                
                                 let message = jsonObj!["message"] as? String
                                
                                self.showSuccessHud(msg: message ?? "", hud: hud)
//                                
                                
                                
                                self.dismiss(animated: true , completion: {
                                    
                                    let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
    //                                1 card 2 passport
                                    
                                    IdentfairVC.documentNumber =  self.DocumentNumber.text ?? ""
                                    
                                    
                                    
                                    IdentfairVC.documentType =  self.idType ?? ""

                                    IdentfairVC.barithDay =  self.birthdayDate ?? ""
                                    
                                    IdentfairVC.expirDate =  self.expDate ?? ""
                                    
                                    
                                    IdentfairVC.familRegester =  self.familyNumber.text ?? ""
                                    

                                        let vc = storyBoard.instantiateViewController(withIdentifier: "PhoneNumberVc") as! PhoneNumberVc

                                        vc.modalPresentationStyle = .fullScreen
                                  
                                        self.present(vc, animated: true)
                                            
                                            
                                        })

                            }
                            //                             Session ID is Expired
                            else if status == 400{
                                let msg = jsonObj!["message"] as? String
                                                                self.showErrorHud(msg: msg ?? "",hud: hud)
//                                self.seassionExpired(msg: msg ?? "")
                            }
                            else if  status == 404{
                                    let msg = jsonObj!["message"] as? String
                                    self.showErrorHud(msg: msg ?? "",hud: hud)

                            }
                            
                            //                                other Wise Problem
                            else {
                                
                                let msg = jsonObj!["message"] as? String
                                                                self.showErrorHud(msg: msg ?? "",hud: hud)

                            }
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
