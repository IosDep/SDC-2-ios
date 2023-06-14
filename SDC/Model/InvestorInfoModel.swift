


//
//  InvestoreOwnerShape.swift
//  SDC
//
//  Created by Blue Ray on 03/04/2023.
//

import Foundation
class InvestorInfoModel{
    
    var  clientName , clientNo , Isin , Action_Type_Desc , Action_Date , Reuter_Code , Trans_Type_Desc , Value_Before , Value_After: String?

    init(data: [String: Any]) {
        
        
        
        if let clientName = data["clientName"] as? String {
            self.clientName = clientName
        }
        
        
        if let clientNo = data["clientNo"] as? String {
            self.clientNo = clientNo
        }
        
        
        if let Isin = data["Isin"] as? String {
            self.Isin = Isin
        }
        
       
        if let Action_Type_Desc = data["Action_Type_Desc"] as? String {
            self.Action_Type_Desc = Action_Type_Desc
        }
        
        if let Action_Date = data["Action_Date"] as? String {
            self.Action_Date = Action_Date
        }
        
        if let Reuter_Code = data["Reuter_Code"] as? String {
            self.Reuter_Code = Reuter_Code
        }
        
        
        if let Trans_Type_Desc = data["Trans_Type_Desc"] as? String {
            self.Trans_Type_Desc = Trans_Type_Desc
        }
        
        if let Value_Before = data["Value_Before"] as? String {
            self.Value_Before = Value_Before
        }
        
        if let Value_After = data["Value_After"] as? String {
            self.Value_After = Value_After
        }
        
        
        
    }
    
    
}
