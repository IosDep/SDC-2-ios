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

//    @IBOutlet weak var bellView : UIView!
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
        
        
        // trans type
        
        transactionNumber.text =   trans?.Trans_Min_Code_Desc ?? ""
        
        
        // trans?.Trans_Date ?? ""
        transactionDate.text =   trans?.Trans_Date ?? ""
        
    
        
        securityID.text = trans?.Security_Reuter_Code ?? ""
        
        
        securityName.text = trans?.Security_Name ?? ""
        memberName.text = trans?.Member_Name ?? ""
        
        accountID.text =  trans?.Account_No ?? ""
        
        quantity.text =  trans?.Quantity ?? ""
        
        price.text = trans?.Price ?? ""
        
        marketValue.text = self.numStringFormat(value: trans?.Market_Value ?? "")
        
    }
    
    
   

}
