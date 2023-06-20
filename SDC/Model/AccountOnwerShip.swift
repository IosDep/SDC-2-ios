//
//  AccountOnwerShip.swift
//  SDC
//
//  Created by Razan Barq on 27/04/2023.
//

import Foundation

class AccountOwnerShape{
    
    
    

    var clientNo, securityID, securityIsin, securityReuterCode,Security_Name , Pending_In, Pending_Out, Security_Close_Price, Quantity_Owned ,Quantity_Avilable, Quantity_Pledge , Quantity_Freezed, Quantity_Unlisted , Nominal_Value, Security_Sector_Desc,Client_No,Trade_Currency  , closePrice , Security_Reuter_Code: String?
    
    var MarketValue : Double?

    init(data: [String: Any]) {
        
        if let Pending_In = data["Pending_In"] as? String {
            self.Pending_In = Pending_In
        }
        if let Pending_Out = data["Pending_Out"] as? String {
            self.Pending_Out = Pending_Out
        }
        
        if let Trade_Currency = data["Trade_Currency"] as? String {
            self.Trade_Currency = Trade_Currency
        }
        
        if let Client_No = data["Client_No"] as? String {
            self.Client_No = Client_No
        }
        
        if let Nominal_Value = data["Nominal_Value"] as? String {
            self.Nominal_Value = Nominal_Value
        }
        
        if let Security_Sector_Desc = data["Security_Sector"] as? String {
            self.Security_Sector_Desc = Security_Sector_Desc
        }
        
        
        if let Security_Close_Price = data["Security_Close_Price"] as? String {
            self.Security_Close_Price = Security_Close_Price
        }
        
        if let closePrice = data["closePrice"] as? String {
            self.closePrice = closePrice
        }
        
        if let Quantity_Avilable = data["Quantity_Avilable"] as? String {
            self.Quantity_Avilable = Quantity_Avilable
        }
        
        if let Quantity_Owned = data["Quantity_Owned"] as? String {
            self.Quantity_Owned = Quantity_Owned
        }
        
        
        if let Quantity_Pledge = data["Quantity_Pledge"] as? String {
            self.Quantity_Pledge = Quantity_Pledge
        }
        
        if let Quantity_Freezed = data["Quantity_Freezed"] as? String {
            self.Quantity_Freezed = Quantity_Freezed
        }
        
        if let Quantity_Unlisted = data["Quantity_Unlisted"] as? String {
            self.Quantity_Unlisted = Quantity_Unlisted
        }
        
        
        if let clientNo = data["Client_No"] as? String {
            self.clientNo = clientNo
        }
        
        if let securityID = data["Security_Id"] as? String {
            self.securityID = securityID
        }
        
        if let securityIsin = data["Security_Isin"] as? String {
            self.securityIsin = securityIsin
        }
        
        if let securityReuterCode = data["Security_Reuter_Code"] as? String {
            self.securityReuterCode = securityReuterCode
        }
        
        // Security_Reuter_Code
        
        if let Security_Reuter_Code = data["Security_Reuter_Code"] as? String {
            self.Security_Reuter_Code = Security_Reuter_Code
        }
        
        if let Security_Name = data["Security_Name"] as? String {
            self.Security_Name = Security_Name
        }
        
        if let MarketValue = data["MarketValue"] as? Double {
            self.MarketValue = MarketValue
        }
        
        
        
    }
    
    
}
