//
//  InvestoreOwnerShape.swift
//  SDC
//
//  Created by Blue Ray on 03/04/2023.
//

import Foundation
class InvestoreOwnerShape{
    
    
    

    var clientNo, securityID, securityIsin, securityReuterCode,Security_Name: String?

    init(data: [String: Any]) {
        
        
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
        
        if let Security_Name = data["Security_Name"] as? String {
            self.Security_Name = Security_Name
        }
        
        
        
        
        
    }
    
}
