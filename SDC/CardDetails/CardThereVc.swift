//
//  CardThereVc.swift
//  SDC
//
//  Created by Blue Ray on 14/04/2023.
//

import UIKit

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
    
    var trans : LastTransaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transactionNumber.text = trans?.Trans_No ?? ""
        tradeTime.text = trans?.Trade_Time ?? ""
        transactionDate.text = trans?.Trans_Date ?? ""
        settlementDate.text = trans?.Settlement_Date ?? ""
        effectiveDate.text = trans?.Effictive_Date ?? ""
        securityID.text = trans?.Security_Id ?? ""
        securityName.text = trans?.Security_Name ?? ""
        memberNumber.text = trans?.Member_No ?? ""
        memberName.text = trans?.Member_Name ?? ""
        accountID.text = trans?.Account_No ?? ""
        accountType.text = trans?.Account_Type ?? ""
        clientNumber.text = trans?.Client_No ?? ""
        descriptionI.text = trans?.Trans_Maj_Code_Desc ?? ""
        exactDescription.text = trans?.Trans_Min_Code_Desc ?? ""
        quantity.text = trans?.Quantity ?? ""
        price.text = trans?.Price ?? ""
        marketValue.text = trans?.Market_Value ?? ""
        postDate.text = trans?.Post_Date ?? ""
        transID.text = trans?.Rel_Trans_No ?? ""
    

        self.cerateBellView(bellview: bellView, count: "12")
        
    }
    
    

}
