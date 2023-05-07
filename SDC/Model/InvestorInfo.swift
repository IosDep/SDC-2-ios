
//
//  InvestoreOwnerShape.swift
//  SDC
//
//  Created by Blue Ray on 03/04/2023.
//

import Foundation
class AccountInfo{
    
    
    

    var clientNo, securityID, securityIsin, securityReuterCode,Security_Name , Pending_In, Pending_Out, Security_Close_Price, Quantity_Owned ,Quantity_Avilable, Quantity_Pledge , Quantity_Freezed, Quantity_Unlisted , Security_Sector_Desc, Nominal_Value , clientName  , memberName , memberId , accountNo , accountType , idDocTypeDesc , idDocNo , idDocDate , idDocExpDate, idDocReference , identificationNo , pobox , postalCode , resCountry ,resCity, bankName , bankId , bankTypeDesc: String?

    init(data: [String: Any]) {
        
        if let Pending_In = data["Pending_In"] as? String {
            self.Pending_In = Pending_In
        }
        
        if let memberName = data["memberName"] as? String {
            self.memberName = memberName
        }
        
        if let memberId = data["memberId"] as? String {
            self.memberId = memberId
        }
        
        if let accountNo = data["accountNo"] as? String {
            self.accountNo = accountNo
        }
        
        if let accountType = data["accountType"] as? String {
            self.accountType = accountType
        }
        if let idDocTypeDesc = data["idDocTypeDesc"] as? String {
            self.idDocTypeDesc = idDocTypeDesc
        }
        
        if let idDocNo = data["idDocNo"] as? String {
            self.idDocNo = idDocNo
        }
        
        if let idDocReference = data["idDocReference"] as? String {
            self.idDocReference = idDocReference
        }
        
        if let idDocDate = data["idDocDate"] as? String {
            self.idDocDate = idDocDate
        }
        
        if let idDocExpDate = data["idDocExpDate"] as? String {
            self.idDocExpDate = idDocExpDate
        }
        if let identificationNo = data["identificationNo"] as? String {
            self.identificationNo = identificationNo
        }
        
        if let pobox = data["pobox"] as? String {
            self.pobox = pobox
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
        
        
        
        if let clientName = data["clientName"] as? String {
            self.clientName = clientName
        }
        
        
        
        if let Nominal_Value = data["Nominal_Value"] as? String {
            self.Nominal_Value = Nominal_Value
        }
        
        if let Security_Sector_Desc = data["Security_Sector_Desc"] as? String {
            self.Security_Sector_Desc = Security_Sector_Desc
        }
        
        if let Pending_Out = data["Pending_Out"] as? String {
            self.Pending_Out = Pending_Out
        }
        
        if let Security_Close_Price = data["Security_Close_Price"] as? String {
            self.Security_Close_Price = Security_Close_Price
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
        
        if let Security_Name = data["Security_Name"] as? String {
            self.Security_Name = Security_Name
        }
        
        
        
        
        
    }
    
    
}
