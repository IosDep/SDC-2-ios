//
//  CardOneVC.swift
//  SDC
//
//  Created by Razan barq on 14/04/2023.
//

import UIKit

class CardOneVC: UIViewController {
    
    // Security info
    
    @IBOutlet weak var accountType: UILabel!
    @IBOutlet weak var currencyStack: UIStackView!
    @IBOutlet weak var additionalView: UIView!
    @IBOutlet weak var secondLabel: DesignableLabel2!
    @IBOutlet weak var firstLabel: DesignableLabel2!
    
    @IBOutlet weak var thirdLabel: DesignableLabel2!
    @IBOutlet weak var sectorName: UILabel!
    
    @IBOutlet weak var clientNum: UILabel!
    
    @IBOutlet weak var nominalValue: UILabel!
    
    @IBOutlet weak var closePrice: UILabel!
    
    @IBOutlet weak var currantBalance : UILabel!
    
    @IBOutlet weak var freeBalance: UILabel!
    
    @IBOutlet weak var tradeCuurency: UILabel!
    
    @IBOutlet weak var reservedBalacnce: UILabel!
    
    @IBOutlet weak var nonCurranncyBalance: UILabel!
    
    
    @IBOutlet weak var currencyLabel: DesignableLabel!
    @IBOutlet weak var bledgedBalance: UILabel!
    
    @IBOutlet weak var pendeingSell: UILabel!
    
    @IBOutlet weak var pendingBuy: UILabel!
    
    @IBOutlet weak var securityID: UILabel!
    
    @IBOutlet weak var aditionalView1: UIView!
    @IBOutlet weak var isin: UILabel!
    @IBOutlet weak var securityName: UILabel!
    @IBOutlet weak var additionalStack: UIStackView!
    @IBOutlet weak var marketValue: UILabel!
    @IBOutlet weak var securityStatus: UILabel!
    
    @IBOutlet weak var aditionalView2: UIView!
    
    @IBOutlet weak var additionalView4: UIView!
    
    var invAccount : AccountOwnerShape?
    var securityOwnership : SecurityOwnership?
    var checkOnepaper = false
    var currencyFlag : String?
    

// Security_Reuter_Code

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        if checkOnepaper == true {
            
            additionalView.isHidden = false
            aditionalView2.isHidden = true
            additionalView4.isHidden = true
            aditionalView1.isHidden = false
            
            currencyStack.isHidden = true
            
            firstLabel.text =  "Membership Type".localized()
            secondLabel.text = "Member Name".localized()
            
            thirdLabel.text = "Account No.".localized()
            
            
            currantBalance.text =  self.numStringFormat(value: securityOwnership?.Quantity_Owned ?? "")
            
            freeBalance.text =  self.numStringFormat(value: securityOwnership?.Quantity_Avilable ?? "")
            
            bledgedBalance.text =  self.numStringFormat(value: securityOwnership?.Quantity_Pledge ?? "")
            reservedBalacnce.text =  self.numStringFormat(value: securityOwnership?.Quantity_Freezed ?? "")
            
            nonCurranncyBalance.text = self.numStringFormat(value: securityOwnership?.Quantity_Unlisted ?? "")
            
            pendingBuy.text =  securityOwnership?.Pending_In ?? ""
            pendeingSell.text =  securityOwnership?.Pending_Out ?? ""
            
            securityID.text = securityOwnership?.Member_Name ?? ""
            
            isin.text = securityOwnership?.Member_Type_Desc ?? ""
            
            securityName.text = securityOwnership?.Account_No ?? ""
            accountType.text = securityOwnership?.Account_Type_Desc
          
        }
            
        else {
            
            if currencyFlag == "1" {
                currencyLabel.text = "JOD".localized()
            }
            
            else if currencyFlag == "22" {
                currencyLabel.text = "USD".localized()
            }
            
            additionalView.isHidden = true
            aditionalView2.isHidden = false
            additionalView4.isHidden = false
            aditionalView1.isHidden = true
            
            securityID.text = invAccount?.Security_Reuter_Code ?? ""
            
            currantBalance.text =  self.numStringFormat(value: invAccount?.Quantity_Owned ?? "")
            
            freeBalance.text = self.numStringFormat(value: invAccount?.Quantity_Avilable ?? "")
            
            bledgedBalance.text =  self.numStringFormat(value: invAccount?.Quantity_Pledge ?? "")
            
            reservedBalacnce.text =  self.numStringFormat(value: invAccount?.Quantity_Freezed ?? "")
            
            nonCurranncyBalance.text = self.numStringFormat(value: invAccount?.Quantity_Unlisted ?? "")
            
            sectorName.text = invAccount?.Security_Sector_Desc
            
            pendingBuy.text =  invAccount?.Pending_In ?? ""
            pendeingSell.text =  invAccount?.Pending_Out ?? ""
            closePrice.text =  invAccount?.Security_Close_Price ?? ""
            securityName.text = invAccount?.Security_Name ?? ""
            isin.text = invAccount?.securityIsin ?? ""

            
            marketValue.text = self.numFormat(value: invAccount?.MarketValue ?? 0.0)
            
//            if let value =  invAccount?.MarketValue as? Double {
//                marketValue.text =  "\(value)"
//            }
          
        }
      
    }
    
}
