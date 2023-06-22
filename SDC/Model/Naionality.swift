

//
//  InvestoreOwnerShape.swift
//  SDC
//
//  Created by Blue Ray on 03/04/2023.
//

import Foundation
class Nationality{
    
    
    

    var  Client_No , Client_Name , Nationality , Client_Status , Status_Date , Client_Status_Desc: String?

    init(data: [String: Any]) {
        
        
        
        if let Client_No = data["Client_No"] as? String {
            self.Client_No = Client_No
        }
        
        
        if let Client_Name = data["Client_Name"] as? String {
            self.Client_Name = Client_Name
        }
        
        
        if let Nationality = data["Nationality"] as? String {
            self.Nationality = Nationality
        }
        
       
        if let Client_Status = data["Client_Status"] as? String {
            self.Client_Status = Client_Status
        }
        
        if let Status_Date = data["Status_Date"] as? String {
            self.Status_Date = Status_Date
        }
        
        if let Client_Status_Desc = data["Client_Status_Desc"] as? String {
            self.Client_Status_Desc = Client_Status_Desc
        }
       
        
        
        
    }
    
    
}
