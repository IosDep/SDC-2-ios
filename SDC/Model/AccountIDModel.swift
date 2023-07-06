


//
//  InvestoreOwnerShape.swift
//  SDC
//
//  Created by Blue Ray on 03/04/2023.
//

import Foundation
class AccountIDModel {
    
    var   Member_No , Account_No , Account_Type_Desc , Account_Status_Desc : String?

    
    init(data: [String: Any]) {
        
        if let Member_No = data["Member_No"] as? String {
            self.Member_No = Member_No
        }
        
        if let Account_No = data["Account_No"] as? String {
            self.Account_No = Account_No
        }
        
        if let Account_Type_Desc = data["Account_Type_Desc"] as? String {
            self.Account_Type_Desc = Account_Type_Desc
        }
        
        if let Account_Status_Desc = data["Account_Status_Desc"] as? String {
            self.Account_Status_Desc = Account_Status_Desc
        }
        
        
        
    }
    
    
}
