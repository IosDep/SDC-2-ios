

//
//  InvestoreOwnerShape.swift
//  SDC
//
//  Created by Blue Ray on 03/04/2023.
//

import Foundation
class InvInfo{
    
    
    

    var  pobox , postalCode , resCountry ,resCity, bankName , bankId , bankTypeDesc , clientNo: String?

    init(data: [String: Any]) {
        
        
        
        if let clientNo = data["clientNo"] as? String {
            self.clientNo = clientNo
        }
        
        if let postalCode = data["postalCode"] as? String {
            self.postalCode = postalCode
        }
        
        if let resCountry = data["resCountry"] as? String {
            self.resCountry = resCountry
        }
        
        if let resCity = data["resCity"] as? String {
            self.resCity = resCity
        }
        if let bankName = data["bankName"] as? String {
            self.bankName = bankName
        }
        
        if let bankId = data["bankId"] as? String {
            self.bankId = bankId
        }
        if let bankTypeDesc = data["bankTypeDesc"] as? String {
            self.bankTypeDesc = bankTypeDesc
        }
        
        
        
       
        
        
        
        
    }
    
    
}
