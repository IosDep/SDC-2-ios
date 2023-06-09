//
//  CardOneVC.swift
//  SDC
//
//  Created by Blue Ray on 14/04/2023.
//

import UIKit

class CardOneVC: UIViewController {
    
    // Security info
    
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
    

// Security_Reuter_Code

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        if checkOnepaper == true {
            
            additionalView.isHidden = false
            aditionalView2.isHidden = false
            additionalView4.isHidden = false
            aditionalView1.isHidden = false
            
            firstLabel.text = "Membership Type".localized()
            secondLabel.text = "Member Name".localized()
            thirdLabel.text = "Account No.".localized()
            
            currantBalance.text =  securityOwnership?.Quantity_Owned ?? ""
            freeBalance.text =  securityOwnership?.Quantity_Avilable ?? ""
            bledgedBalance.text =  securityOwnership?.Quantity_Pledge ?? ""
            reservedBalacnce.text =  securityOwnership?.Quantity_Freezed ?? ""
            
            nonCurranncyBalance.text =  securityOwnership?.Quantity_Unlisted ?? ""
            
            pendingBuy.text =  securityOwnership?.Pending_In ?? ""
            pendeingSell.text =  securityOwnership?.Pending_Out ?? ""
            
            closePrice.text =  securityOwnership?.Security_Close_Price ?? ""
            
            securityID.text = securityOwnership?.securityReuterCode ?? ""
            
            securityName.text = securityOwnership?.Security_Name ?? ""
            
            isin.text = securityOwnership?.Security_Isin ?? ""
            
            //            clientNum.text = self.doubleToArabic(value: securityOwnership?.Client_No ?? "")
            //
            //            nominalValue.text = self.doubleToArabic(value: securityOwnership?.Nominal_Value  ?? "")
            securityName.text = securityOwnership?.Security_Name ?? ""
            
            marketValue.text = self.numFormat(value: securityOwnership?.MarketValue ?? 0.0)
            
            //            tradeCuurency.text = self.doubleToArabic(value: securityOwnership?.Trade_Currency ?? "")
            //            if let value = securityOwnership?.MarketValue as? Double {
            //                marketValue.text = "\(value)"
            //            }        }
            //
        }
            
        else {
            additionalView.isHidden = true
            aditionalView2.isHidden = true
            additionalView4.isHidden = true
            aditionalView1.isHidden = true
            
            securityID.text = invAccount?.Security_Reuter_Code ?? ""
            currantBalance.text =  invAccount?.Quantity_Owned ?? ""
            freeBalance.text =  invAccount?.Quantity_Avilable ?? ""
            bledgedBalance.text =  invAccount?.Quantity_Pledge ?? ""
            reservedBalacnce.text =  invAccount?.Quantity_Freezed ?? ""
            nonCurranncyBalance.text =  invAccount?.Quantity_Unlisted ?? ""
            
            pendingBuy.text =  invAccount?.Pending_In ?? ""
            pendeingSell.text =  invAccount?.Pending_Out ?? ""
            closePrice.text =  invAccount?.Security_Close_Price ?? ""
            securityName.text = invAccount?.Security_Name ?? ""
            isin.text = invAccount?.securityIsin ?? ""
//            clientNum.text =  invAccount?.Client_No ?? ""
//            nominalValue.text = self.convertIntToArabicNumbers(intString: invAccount?.Nominal_Value  ?? "")
//
//            tradeCuurency.text = self.doubleToArabic(value: invAccount?.Trade_Currency ?? "")
            
            marketValue.text = self.numFormat(value: invAccount?.MarketValue ?? 0.0)
            
//            if let value =  invAccount?.MarketValue as? Double {
//                marketValue.text =  "\(value)"
//            }
          
        }
      
    }
    
}
