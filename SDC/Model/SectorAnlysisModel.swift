


//
//  InvestoreOwnerShape.swift
//  SDC
//
//  Created by Blue Ray on 03/04/2023.
//

import Foundation
class SectorAnylisisModel{
    
    
    

    var  Quantity , sec_count  : Int?
    var  market_value : Double?

    init(data: [String: Any]) {
        
        
        
        if let Quantity = data["Quantity"] as? Int {
            self.Quantity = Quantity
        }
        
        
        if let sec_count = data["sec_count"] as? Int {
            self.sec_count = sec_count
        }
        
        
        if let market_value = data["market_value"] as? Double {
            self.market_value = market_value
        }
        
        
        
    }
    
    
}
