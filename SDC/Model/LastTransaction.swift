//
//  LastTransaction.swift
//  SDC
//
//  Created by Blue Ray on 05/04/2023.
//

import Foundation
class LastTransaction {
    
    
    var Trans_No, Trans_Date, Trade_Time , Effictive_Date,Settlement_Date ,Security_Id,Member_No,Member_Name,Account_No,Market_Value,Price,Quantity : String?
    
    init(data: [String: Any]) {
        
        
        if let Trans_No = data["Trans_No"] as? String {
            self.Trans_No = Trans_No
        }
        
        
        
        if let Trans_Date = data["Trans_Date"] as? String {
            self.Trans_Date = Trans_Date
        }
        
        if let Trade_Time = data["Trade_Time"] as? String {
            self.Trade_Time = Trade_Time
        }
        
        if let Effictive_Date = data["Effictive_Date"] as? String {
            self.Effictive_Date = Effictive_Date
        }
        
        if let Settlement_Date = data["Settlement_Date"] as? String {
            self.Settlement_Date = Settlement_Date
        }
        
        if let Security_Id = data["Security_Id"] as? String {
            self.Security_Id = Security_Id
        }
        
        if let Member_No = data["Member_No"] as? String {
            self.Member_No = Member_No
        }
        
        if let Member_Name = data["Member_Name"] as? String {
            self.Member_Name = Member_Name
        }
        
        if let Account_No = data["Account_No"] as? String {
            self.Account_No = Account_No
        }
        
        if let Market_Value = data["Market_Value"] as? String {
            self.Market_Value = Market_Value
        }
        
        if let Price = data["Price"] as? String {
            self.Price = Price
        }
        
        
        
        
        if let Quantity = data["Quantity"] as? String {
            self.Quantity = Quantity
        }
        
        
        
        
        
        
        
    }
    
  
    
    
}
