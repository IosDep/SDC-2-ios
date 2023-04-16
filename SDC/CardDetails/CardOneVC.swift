//
//  CardOneVC.swift
//  SDC
//
//  Created by Blue Ray on 14/04/2023.
//

import UIKit

class CardOneVC: UIViewController {
    
    @IBOutlet weak var bellView : UIView!
    @IBOutlet weak var mebmerName: UILabel!
    
    
    @IBOutlet weak var mebmerType: UILabel!
    
    @IBOutlet weak var accountNumber: UILabel!
    
    @IBOutlet weak var accountType: UILabel!
    
    @IBOutlet weak var currantBalance : UILabel!
    
    @IBOutlet weak var freeBalance: UILabel!
    
    
    @IBOutlet weak var reservedBalacnce: UILabel!
    
    @IBOutlet weak var nonCurranncyBalance: UILabel!
    
    
    @IBOutlet weak var bledgedBalance: UILabel!
    
    @IBOutlet weak var pendeingSell: UILabel!
    
    @IBOutlet weak var pendingBuy: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.cerateBellView(bellview: bellView, count: "12")
        
    }
    
    
    
    
    
    


}
