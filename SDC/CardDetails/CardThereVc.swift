//
//  CardThereVc.swift
//  SDC
//
//  Created by Blue Ray on 14/04/2023.
//

import UIKit
import MOLH

// Security info

class CardThereVc: UIViewController {

    @IBOutlet weak var bellView : UIView!
    @IBOutlet weak var transactionNumber: UILabel!
    @IBOutlet weak var tradeTime: UILabel!
    @IBOutlet weak var transactionDate: UILabel!
    @IBOutlet weak var settlementDate: UILabel!
    @IBOutlet weak var effectiveDate: UILabel!
    @IBOutlet weak var securityID: UILabel!
    @IBOutlet weak var securityName: UILabel!
    @IBOutlet weak var memberNumber: UILabel!
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var accountID: UILabel!
    @IBOutlet weak var accountType: UILabel!
    @IBOutlet weak var clientNumber: UILabel!
    @IBOutlet weak var descriptionI: UILabel!
    @IBOutlet weak var exactDescription: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var marketValue: UILabel!
    @IBOutlet weak var transID: UILabel!
    @IBOutlet weak var postDate: UILabel!
    
    @IBOutlet weak var mainStack: UIStackView!
    var trans : LastTransaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainStack.isLayoutMarginsRelativeArrangement = true
        
        
        transactionNumber.text =  self.convertIntToArabicNumbers(intString: trans?.Trans_No ?? "")
        
        
        
        // trans?.Trade_Time ?? ""
        
        tradeTime.text = MOLHLanguage.isRTLLanguage() ?
        self.convertTimeToArabicNumbers(timeString:         trans?.Trade_Time ?? "") : trans?.Trade_Time ?? ""
        
        // trans?.Trans_Date ?? ""
        transactionDate.text = self.convertDateToArabicNumbers(dateString: trans?.Trans_Date ?? "")
        
        
        // trans?.Settlement_Date ?? ""
        settlementDate.text = self.convertDateToArabicNumbers(dateString:         trans?.Settlement_Date ?? "")
        
        // trans?.Effictive_Date ?? ""
        effectiveDate.text =
        self.convertDateToArabicNumbers(dateString:         trans?.Effictive_Date ?? "")
        
        securityID.text = trans?.Security_Reuter_Code ?? ""
        
        
        securityName.text = trans?.Security_Name ?? ""
        
        memberNumber.text = self.convertIntToArabicNumbers(intString: trans?.Member_No ?? "")
        
        memberName.text = trans?.Member_Name ?? ""
        
        accountID.text = self.convertIntToArabicNumbers(intString: trans?.Account_No ?? "")
        
        accountType.text = self.convertIntToArabicNumbers(intString: trans?.Account_Type ?? "")
        
        clientNumber.text = self.convertIntToArabicNumbers(intString: trans?.Client_No ?? "")
        
        descriptionI.text = trans?.Trans_Maj_Code_Desc ?? ""
        exactDescription.text = trans?.Trans_Min_Code_Desc ?? ""
        quantity.text = self.convertIntToArabicNumbers(intString: trans?.Quantity ?? "")
        
        price.text = self.doubleToArabic(value: trans?.Price ?? "")
        
        marketValue.text = self.doubleToArabic(value: trans?.Market_Value ?? "")
        
        // trans?.Post_Date ?? ""
        postDate.text =
        self.convertDateToArabicNumbers(dateString:         trans?.Post_Date ?? "")
        
        transID.text = self.convertIntToArabicNumbers(intString: trans?.Rel_Trans_No ?? "")

        self.cerateBellView(bellview: bellView, count: "12")
        
    }
    
    
   

}
