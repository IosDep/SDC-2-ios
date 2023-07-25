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
    
    @IBOutlet weak var secondStack: UIStackView!
    @IBOutlet weak var thirdStack: UIStackView!
    
    @IBOutlet weak var currency: UILabel!
    
    @IBOutlet weak var transactionNumber: UILabel!
    @IBOutlet weak var firstStack: UIStackView!
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
        
        
        if trans?.Trade_Currency == "1" {
            currency.text = "JOD".localized()
        }
        
        else if trans?.Trade_Currency == "22" {
            
            currency.text = "USD".localized()

        }
        // trans type
        
        if trans?.Min_Code == "1" {
            transactionNumber.textColor = UIColor(named: "AccentColor")
        }
        
        else if trans?.Min_Code == "2" {
            transactionNumber.textColor = .red
        }
        transactionNumber.text =   trans?.Trans_Min_Code_Desc ?? ""
        
        // trans?.Trans_Date ?? ""
        transactionDate.text =   self.convertedDate(dateString: trans?.Trans_Date ?? "")
        
        securityID.text = trans?.Security_Reuter_Code ?? ""
        securityName.text = trans?.Security_Name ?? ""
        memberName.text = trans?.Member_Name ?? ""
        accountID.text =  trans?.Account_No ?? ""
        quantity.text =  trans?.Quantity ?? ""
        price.text = trans?.Price ?? ""
        
        marketValue.text = self.numStringFormat(value: trans?.Market_Value ?? "")
        
    }
    
    override func viewDidLayoutSubviews() {
        firstStack.roundCorners([.topLeft, .topRight], radius: 8)
        secondStack.roundCorners([.topLeft, .topRight], radius: 8)
        thirdStack.roundCorners([.topLeft, .topRight], radius: 8)

    }
    
   

}
