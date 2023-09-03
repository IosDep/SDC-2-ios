//
//  PickerVC.swift
//  SDC
//
//  Created by Razan Barq on 02/05/2023.
//

import UIKit
import MOLH
import JGProgressHUD
import Alamofire

protocol DataSelectedDelegate{
    func getSelectdPicker(selectdTxt:String,securtNumber:String,flag:String,securtyId:String , secMarket:String , secStatus: String , secISIN:String)
}



class PickerVC: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    var dataSelectedDelegate:DataSelectedDelegate?
    @IBOutlet weak var tableView: UITableView!
    
    var dataFilterd = [String]()
    var accountNoByMember = [AccountIDModel]()
    var categories = [String]()
    var reuterCode = [String]()
    var accounNumber = [String]()
    var memberNum = [String]()
    var checkFlag:String?
    var securtyID = [String]()
    var securityIDs = [String]()
    var secData =  [SecurityData]()
    var checkAccountStatmnt = false
    var accountNoFlag : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "PickerCell", bundle: nil), forCellReuseIdentifier: "PickerCell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // one paper picker
        
        if self.checkAccountStatmnt == false {
            if checkFlag == "4" {
                categories.count
            }
            else {
                return secData.count

            }

        }
        
        
        // account statement 3 pickers
        
        else{
            
            // if the picker is account no
            
            if accountNoFlag == true {
                return accountNoByMember.count
            }
            
            // if the picker is name or reuter code

            else {
                return dataFilterd.count

            }
            
        }
        
        return 0
        
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         var cell = self.tableView.dequeueReusableCell(withIdentifier: "PickerCell", for: indexPath) as? PickerCell
        
                if cell == nil {
                    let nib: [Any] = Bundle.main.loadNibNamed("PickerCell", owner: self, options: nil)!
                    cell = nib[0] as? PickerCell
                }
        else {
            
            
//            in case user comming form one paper Owner Shap Will display info of Struct Class With Name SecurtyDATA
            
            
            if self.checkAccountStatmnt == false{
                
                if checkFlag == "0"{
                    cell?.title.text = secData[indexPath.row].secName ?? ""
                    
                    cell?.reuterCode.text = "\(secData[indexPath.row].secNum)"
                }
                
                else if checkFlag == "4" {
                    cell?.title.text = categories[indexPath.row]
                }
                
                else {
                    
                    cell?.title.text = secData[indexPath.row].secNum ?? ""

                }
                
            }
            
            // Account STatement
            
            
            else {
                
                // security name third picker
                
                if checkFlag ==  "2" {
                    cell?.title.text = dataFilterd[indexPath.row]
                    cell?.reuterCode.text = "\(reuterCode[indexPath.row])"
                }
                
               // account no second picker 
            
                else if checkFlag == "1"{
                    
                    cell?.title.text = "\(accountNoByMember[indexPath.row].Account_No ?? "") - \(accountNoByMember[indexPath.row].Account_Status_Desc ?? "") - \(accountNoByMember[indexPath.row].Account_Type_Desc ?? "")"
                    
                    cell?.reuterCode.isHidden = true

                }
                
                // first picker
                
                else {
                    cell?.title.text = dataFilterd[indexPath.row]
                    cell?.reuterCode.isHidden = true
                }
                
                
                
                
            }
            
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.checkAccountStatmnt == false {
            
            let data  =  self.secData[indexPath.row]
            self.dataSelectedDelegate?.getSelectdPicker(selectdTxt : data.secName , securtNumber: data.secNum ,flag: checkFlag ?? "" , securtyId: data.securotyID , secMarket: data.secMarket , secStatus: data.secStatus , secISIN: data.secISIN)
        }
        
        else {
            
//            in account statmnet we provide empty securtyId and Securty Number
            
            if checkFlag == "0" {
                self.dataSelectedDelegate?.getSelectdPicker(selectdTxt: self.dataFilterd[indexPath.row],securtNumber:memberNum[indexPath.row], flag: checkFlag ?? "",securtyId: securityIDs[indexPath.row] , secMarket: "" , secStatus: "" , secISIN: "")
            }
            
//            else if checkFlag == "1" {
//                self.dataSelectedDelegate?.getSelectdPicker(selectdTxt: self.dataFilterd[indexPath.row],securtNumber:"", flag: checkFlag ?? "",securtyId: reuterCode[indexPath.row] , secMarket: "" , secStatus: "" , secISIN: "")
//            }
//
            // third picker isin and reuter code
            
            else if checkFlag == "2"{
                self.dataSelectedDelegate?.getSelectdPicker(selectdTxt: self.dataFilterd[indexPath.row],securtNumber:"", flag: checkFlag ?? "",securtyId: reuterCode[indexPath.row] , secMarket: "" , secStatus: "" , secISIN: "")
            }
            
            
            // second picker account no
            
            else if checkFlag == "1" {
                
                self.dataSelectedDelegate?.getSelectdPicker(selectdTxt: self.accountNoByMember[indexPath.row].Account_No ?? "" ,securtNumber: self.accountNoByMember[indexPath.row].Account_Status_Desc ?? "" , flag: checkFlag ?? "", securtyId: self.accountNoByMember[indexPath.row].Account_Type_Desc ?? "" , secMarket: "" , secStatus: "" , secISIN: "")
                
                
            }
            
            // first picker security name
            
            else {
                
                self.dataSelectedDelegate?.getSelectdPicker(selectdTxt: self.dataFilterd[indexPath.row],securtNumber:"", flag: checkFlag ?? "",securtyId: "" , secMarket: "" , secStatus: "" , secISIN: "")
            }
        }
        
        self.dismiss(animated:  true)
        
    }
}

