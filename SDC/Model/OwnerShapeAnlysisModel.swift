//
//  OwnerShapeAnlysisModel.swift
//  SDC
//
//  Created by Blue Ray on 05/04/2023.
//

import Foundation

class OwnerShapeAnlysisModel{
    
    var Report_Type, Trade_Date, Month , Year,Client_No ,No_Order_Sell,Quantity_Sell,Market_Value_Sell,No_Order_Buy,Quantity_Buy,Market_Value_Buy,Main_Security_Cat,Trade_Currency,Main_Security_Cat_Desc : String?
    
    init(data: [String: Any]) {
        
        
        if let Report_Type = data["Report_Type"] as? String {
            self.Report_Type = Report_Type
        }
        
        
        
        
        if let Trade_Date = data["Trade_Date"] as? String {
            self.Trade_Date = Trade_Date
        }
        
        
        if let Month = data["Month"] as? String {
            self.Month = Month
        }
        
        
        if let Year = data["Year"] as? String {
            self.Year = Year
        }
        
        
        if let Client_No = data["Client_No"] as? String {
            self.Client_No = Client_No
        }
        
        
        if let No_Order_Sell = data["No_Order_Sell"] as? String {
            self.No_Order_Sell = No_Order_Sell
        }
        
        
        if let Quantity_Sell = data["Quantity_Sell"] as? String {
            self.Quantity_Sell = Quantity_Sell
        }
        
        
        if let Market_Value_Sell = data["Market_Value_Sell"] as? String {
            self.Market_Value_Sell = Market_Value_Sell
        }
        
        
        if let Market_Value_Sell = data["Market_Value_Sell"] as? String {
            self.Market_Value_Sell = Market_Value_Sell
        }
        
        
        if let Quantity_Buy = data["Quantity_Buy"] as? String {
            self.Quantity_Buy = Quantity_Buy
        }
        
        
        if let Market_Value_Buy = data["Market_Value_Buy"] as? String {
            self.Market_Value_Buy = Market_Value_Buy
        }
        
        
        
        if let Main_Security_Cat = data["Main_Security_Cat"] as? String {
            self.Main_Security_Cat = Main_Security_Cat
        }
        
        
        if let Main_Security_Cat_Desc = data["Main_Security_Cat_Desc"] as? String {
            self.Main_Security_Cat_Desc = Main_Security_Cat_Desc
        }
        
        
        if let Trade_Currency = data["Trade_Currency"] as? String {
            self.Trade_Currency = Trade_Currency
        }
        
        
        
        
        
        
    }
    
}
