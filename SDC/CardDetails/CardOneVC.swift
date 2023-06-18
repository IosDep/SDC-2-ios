//
//  CardOneVC.swift
//  SDC
//
//  Created by Blue Ray on 14/04/2023.
//

import UIKit

class CardOneVC: UIViewController {
    
    // Security info
    
    @IBOutlet weak var bellView : UIView!
   
    @IBOutlet weak var clientNum: UILabel!
    
    @IBOutlet weak var nominalValue: UILabel!
    
    @IBOutlet weak var closePrice: UILabel!
    
    @IBOutlet weak var currantBalance : UILabel!
    
    @IBOutlet weak var freeBalance: UILabel!
    
    @IBOutlet weak var tradeCuurency: UILabel!
    
    @IBOutlet weak var reservedBalacnce: UILabel!
    
    @IBOutlet weak var nonCurranncyBalance: UILabel!
    
    
    @IBOutlet weak var bledgedBalance: UILabel!
    
    @IBOutlet weak var pendeingSell: UILabel!
    
    @IBOutlet weak var pendingBuy: UILabel!
    
    
    @IBOutlet weak var securityID: UILabel!
    
    
    @IBOutlet weak var isin: UILabel!
    @IBOutlet weak var securityName: UILabel!
    @IBOutlet weak var additionalStack: UIStackView!
    @IBOutlet weak var marketValue: UILabel!
    @IBOutlet weak var securityStatus: UILabel!
    
    var invAccount : AccountOwnerShape?
    var securityOwnership : SecurityOwnership?
    var checkOnepaper = false
    

// Security_Reuter_Code

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        self.cerateBellView(bellview: bellView, count: "12")
        
        if checkOnepaper == true {
        
            currantBalance.text = self.convertIntToArabicNumbers(intString: securityOwnership?.Quantity_Owned ?? "")
            freeBalance.text = self.convertIntToArabicNumbers(intString: securityOwnership?.Quantity_Avilable ?? "")
            bledgedBalance.text = self.convertIntToArabicNumbers(intString: securityOwnership?.Quantity_Pledge ?? "")
            reservedBalacnce.text = self.convertIntToArabicNumbers(intString: securityOwnership?.Quantity_Freezed ?? "")
            
            nonCurranncyBalance.text = self.convertIntToArabicNumbers(intString: securityOwnership?.Quantity_Unlisted ?? "")
            
            pendingBuy.text = self.convertIntToArabicNumbers(intString: securityOwnership?.Pending_In ?? "")
            pendeingSell.text = self.convertIntToArabicNumbers(intString: securityOwnership?.Pending_Out ?? "")
            
            closePrice.text = self.doubleToArabic(value: securityOwnership?.Security_Close_Price ?? "")
            securityID.text = securityOwnership?.securityReuterCode ?? ""
            securityName.text = securityOwnership?.Security_Name ?? ""
            
            isin.text = securityOwnership?.Security_Isin ?? ""
            
            clientNum.text = self.doubleToArabic(value: securityOwnership?.Client_No ?? "")
            
            nominalValue.text = self.doubleToArabic(value: securityOwnership?.Nominal_Value  ?? "")
            securityName.text = securityOwnership?.Security_Name ?? ""
            securityStatus.text = securityOwnership?.Security_Sector_Desc ?? ""
            tradeCuurency.text = self.convertIntToArabicNumbers(intString: securityOwnership?.Trade_Currency ?? "")
            if let value = securityOwnership?.MarketValue as? Int {
                marketValue.text = self.doubleToArabic(value: "\(value)")
            }        }
        
        else {
            securityID.text = invAccount?.Security_Reuter_Code ?? ""
            currantBalance.text = self.convertIntToArabicNumbers(intString: invAccount?.Quantity_Owned ?? "")
            freeBalance.text = self.convertIntToArabicNumbers(intString: invAccount?.Quantity_Avilable ?? "")
            bledgedBalance.text = self.convertIntToArabicNumbers(intString: invAccount?.Quantity_Pledge ?? "")
            reservedBalacnce.text = self.convertIntToArabicNumbers(intString: invAccount?.Quantity_Freezed ?? "")
            nonCurranncyBalance.text = self.convertIntToArabicNumbers(intString: invAccount?.Quantity_Unlisted ?? "")
            
            pendingBuy.text = self.convertIntToArabicNumbers(intString: invAccount?.Pending_In ?? "")
            pendeingSell.text = self.convertIntToArabicNumbers(intString: invAccount?.Pending_Out ?? "")
            closePrice.text = self.doubleToArabic(value: invAccount?.Security_Close_Price ?? "")
            securityID.text = self.convertIntToArabicNumbers(intString: invAccount?.securityReuterCode ?? "")
            securityName.text = invAccount?.Security_Name ?? ""
            isin.text = invAccount?.securityIsin ?? ""
            clientNum.text = self.convertIntToArabicNumbers(intString: invAccount?.Client_No ?? "")
            nominalValue.text = self.convertIntToArabicNumbers(intString: invAccount?.Nominal_Value  ?? "")
            securityStatus.text = self.convertIntToArabicNumbers(intString: invAccount?.closePrice ?? "")
            tradeCuurency.text = self.convertIntToArabicNumbers(intString: invAccount?.Trade_Currency ?? "")
            
            if let value =  invAccount?.MarketValue as? Int {
                marketValue.text = self.doubleToArabic(value: "\(value)")
            }
          
        }
        
       
        
        
    }
    
    
    
    
    
    


}
