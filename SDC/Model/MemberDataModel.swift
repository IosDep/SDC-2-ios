


//
//  InvestoreOwnerShape.swift
//  SDC
//
//  Created by Razan Barq on 03/08/2023.
//

import Foundation
class MemberDataModel {
    
    var   Member_No , Member_Name  : String?

    
    init(data: [String: Any]) {
        
        if let Member_No = data["Member_No"] as? String {
            self.Member_No = Member_No
        }
        
        if let Member_Name = data["Member_Name"] as? String {
            self.Member_Name = Member_Name
        }
        
        
    }
    
    
}
