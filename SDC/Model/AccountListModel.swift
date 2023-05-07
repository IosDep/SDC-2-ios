//
//  AccountListModel.swift
//  SDC
//
//  Created by Blue Ray on 04/04/2023.
//

import Foundation
class AccountListModel{
    var Member_No, Member_Name, Member_Type , Account_No,Account_Status_Desc , accountTypeDesc: String?
    
    init(data: [String: Any]) {
        
        
        if let Member_No = data["Member_No"] as? String {
            self.Member_No = Member_No
        }
        
        if let accountTypeDesc = data["Account_Type_Desc"] as? String {
            self.accountTypeDesc = accountTypeDesc
        }
        
        
        if let Member_Name = data["Member_Name"] as? String {
            self.Member_Name = Member_Name
        }
        
        
        
        if let Member_Type = data["Member_Type"] as? String {
            self.Member_Type = Member_Type
        }
        
        
        
        if let Account_No = data["Account_No"] as? String {
            self.Account_No = Account_No
        }
        
        
        
        
        if let Account_Status_Desc = data["Account_Status_Desc"] as? String {
            self.Account_Status_Desc = Account_Status_Desc
        }
        
        
        
      
        
        
    }
    
    
    
    
}
