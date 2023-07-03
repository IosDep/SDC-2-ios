


//
//  InvestoreOwnerShape.swift
//  SDC
//
//  Created by Blue Ray on 03/04/2023.
//

import Foundation
class PartialDataModel{
    
    var  Security_Id , Security_Reuter_Code , Security_Name , Security_Status_Desc , Market_Type_Desc , Security_Isin: String?

    init(data: [String: Any]) {
        
        
        if let Security_Id = data["Security_Id"] as? String {
            self.Security_Id = Security_Id
        }
        
        if let Security_Reuter_Code = data["Security_Reuter_Code"] as? String {
            self.Security_Reuter_Code = Security_Reuter_Code
        }
        
        if let Security_Name = data["Security_Name"] as? String {
            self.Security_Name = Security_Name
        }
        
        if let Security_Status_Desc = data["Security_Status_Desc"] as? String {
            self.Security_Status_Desc = Security_Status_Desc
        }
        
        if let Market_Type_Desc = data["Market_Type_Desc"] as? String {
            self.Market_Type_Desc = Market_Type_Desc
        }
        
        // Security_Isin
        if let Security_Isin = data["Security_Isin"] as? String {
            self.Security_Isin = Security_Isin
        }
        
    }
    
    
}
