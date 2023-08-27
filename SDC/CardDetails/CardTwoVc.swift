//
//  CardTwoVc.swift
//  SDC
//
//  Created by Blue Ray on 14/04/2023.
//

import UIKit

// Security info

class CardTwoVc: UIViewController {

    @IBOutlet weak var currencyFlag: DesignableLabel!
    @IBOutlet weak var sectorName: UILabel!
    @IBOutlet weak var reuterCode: UILabel!
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
    @IBOutlet weak var securityStack: UIStackView!
    @IBOutlet weak var balanceStack: UIStackView!
    @IBOutlet weak var pendingStack: UIStackView!
    @IBOutlet weak var marketValue: UILabel!
    
    var invOwnership : InvestoreOwnerShape?
    var currency : String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currency == "1" {
            currencyFlag.text = "JOD".localized()
    }
        else if currency == "22" {
            currencyFlag.text = "USD".localized()
        }
        
        currentBalance.text = self.thousandigitNum(invOwnership?.Quantity_Owned ?? "")

        
        freeBalance.text = self.thousandigitNum(invOwnership?.Quantity_Avilable ?? "")
        
        pledgedBalance.text = self.thousandigitNum(invOwnership?.Quantity_Pledge ?? "")
       
        
        reservedBalance.text = self.thousandigitNum(invOwnership?.Quantity_Freezed ?? ""
)
        
        
        nonCurrentBalance.text = self.thousandigitNum(invOwnership?.Quantity_Unlisted ?? "")
        
        
        securityName.text = invOwnership?.Security_Name ?? ""
        reuterCode.text = invOwnership?.Security_Reuter_Code ?? ""
        iSSN.text = invOwnership?.securityIsin ?? ""
        
        
        pendingIn.text = self.thousandigitNum(invOwnership?.Pending_In ?? "")
        
        
        pendingOut.text = self.thousandigitNum(invOwnership?.Pending_Out ?? "")
        
        //doubleToArabic
        closePrice.text =  invOwnership?.closePrice ?? ""
        
        sectorName.text = invOwnership?.Security_Sector_Desc ?? ""
        
        
        if let value =  invOwnership?.MarketValue as? Double {
            marketValue.text = self.numFormat(value: value )
                    }
        
    
//        if let value =  invOwnership?.MarketValue as? Double {
//            marketValue.text =  self.numFormat(value: "\(value)")
//
//        }
        
//        self.cerateBellView(bellview: bellView, count: "12")
        
    }
    

    override func viewDidLayoutSubviews() {
        securityStack.roundCorners([.topLeft, .topRight], radius: 12)
        balanceStack.roundCorners([.topLeft, .topRight], radius: 12)
        pendingStack.roundCorners([.topLeft, .topRight], radius: 12)
    }
    
    


}
