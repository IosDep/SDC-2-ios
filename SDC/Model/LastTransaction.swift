//
//  LastTransaction.swift
//  SDC
//
//  Created by Blue Ray on 05/04/2023.
//

import Foundation
class LastTransaction {
    
    
    var Trans_No, Trans_Date, Trade_Time , Effictive_Date,Settlement_Date ,Security_Id,Member_No,Member_Name,Account_No,Price,Quantity,Post_Date,Security_Name , Account_Type , Client_No , Trans_Maj_Code_Desc , Trans_Min_Code_Desc , Rel_Trans_No , Security_Reuter_Code , Min_Code , Trade_Currency : String?
    
    var Market_Value : String?
    
    init(data: [String: Any]) {
        
        
        if let Trans_No = data["Trans_No"] as? String {
            self.Trans_No = Trans_No
        }
        
        if let Trade_Currency = data["Trade_Currency"] as? String {
            self.Trade_Currency = Trade_Currency
        }
        
        
        if let Min_Code = data["Min_Code"] as? String {
            self.Min_Code = Min_Code
        }
        
        if let Post_Date = data["Post_Date"] as? String {
            self.Post_Date = Post_Date
        }
        
        if let Security_Name = data["Security_Name"] as? String {
            self.Security_Name = Security_Name
        }
        
        if let Account_Type = data["Account_Type"] as? String {
            self.Account_Type = Account_Type
        }
        
        if let Client_No = data["Client_No"] as? String {
            self.Client_No = Client_No
        }
        
        if let Trans_Maj_Code_Desc = data["Trans_Maj_Code_Desc"] as? String {
            self.Trans_Maj_Code_Desc = Trans_Maj_Code_Desc
        }
        
        if let Trans_Min_Code_Desc = data["Trans_Min_Code_Desc"] as? String {
            self.Trans_Min_Code_Desc = Trans_Min_Code_Desc
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
        
        if let Rel_Trans_No = data["Rel_Trans_No"] as? String {
            self.Rel_Trans_No = Rel_Trans_No
        }
        
        if let Quantity = data["Quantity"] as? String {
            self.Quantity = Quantity
        }
        
        if let Security_Reuter_Code = data["Security_Reuter_Code"] as? String {
            self.Security_Reuter_Code = Security_Reuter_Code
        }
        
        
        
    }
    
  
    
    
}
