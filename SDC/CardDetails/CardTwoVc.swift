//
//  CardTwoVc.swift
//  SDC
//
//  Created by Blue Ray on 14/04/2023.
//

import UIKit

// Security info

class CardTwoVc: UIViewController {

    @IBOutlet weak var bellView : UIView!
    @IBOutlet weak var currentBalance: UILabel!
    @IBOutlet weak var freeBalance: UILabel!
    @IBOutlet weak var reservedBalance: UILabel!
    @IBOutlet weak var pledgedBalance: UILabel!
    @IBOutlet weak var nonCurrentBalance: UILabel!
    @IBOutlet weak var pendingIn: UILabel!
    @IBOutlet weak var pendingOut: UILabel!
    @IBOutlet weak var closePrice: UILabel!
    @IBOutlet weak var securityID: UILabel!
    @IBOutlet weak var iSSN: UILabel!
    @IBOutlet weak var securityName: UILabel!
    var invOwnership : InvestoreOwnerShape?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentBalance.text = invOwnership?.Quantity_Owned ?? ""
        freeBalance.text = invOwnership?.Quantity_Avilable ?? ""
        pledgedBalance.text = invOwnership?.Quantity_Pledge ?? ""
        reservedBalance.text = invOwnership?.Quantity_Freezed ?? ""
        nonCurrentBalance.text = invOwnership?.Quantity_Unlisted ?? ""
        securityID.text = invOwnership?.securityID ?? ""
        securityName.text = invOwnership?.Security_Name ?? ""
        iSSN.text = invOwnership?.securityIsin ?? ""
        pendingIn.text = invOwnership?.Pending_In ?? ""
        pendingOut.text = invOwnership?.Pending_Out ?? ""
        closePrice.text = invOwnership?.Security_Close_Price ?? ""

        self.cerateBellView(bellview: bellView, count: "12")
        
    }
    
    


}
