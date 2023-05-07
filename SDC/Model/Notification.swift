//
//  InvestoreOwnerShape.swift
//  SDC
//
//  Created by Blue Ray on 03/04/2023.
//

import Foundation
class NotificationModel {
    
    var id, userId : Int?
    
    var title, desc, createdAt , updatedAt : String?
    

    init(data: [String: Any]) {
        
        
        if let id = data["id"] as? Int {
            self.id = id
        }
        
        if let userId = data["user_id"] as? Int {
            self.userId = userId
        }
        
        if let title = data["title"] as? String {
            self.title = title
        }
        
        if let desc = data["desc"] as? String {
            self.desc = desc
        }
        
        if let createdAt = data["created_at"] as? String {
            self.createdAt = createdAt
        }
        
        if let updatedAt = data["updated_at"] as? String {
            self.updatedAt = updatedAt
        }
        
        
    }
    
    
}

