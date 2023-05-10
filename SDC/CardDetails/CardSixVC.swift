//
//  CardSixVC.swift
//  SDC
//
//  Created by Razan Barq on 10/05/2023.
//

import UIKit

class CardSixVC: UIViewController {

    @IBOutlet weak var bellView: UIButton!
    @IBOutlet weak var corporationName: DesignableLabel2!
    @IBOutlet weak var corporationID: DesignableLabel2!
    @IBOutlet weak var isin: UILabel!
    @IBOutlet weak var literalNum: UILabel!
    @IBOutlet weak var actionDate: UILabel!
    @IBOutlet weak var action: UILabel!
    @IBOutlet weak var actionDescription: UILabel!
    @IBOutlet weak var beforeAction: UILabel!
    @IBOutlet weak var afterAction: UILabel!
    
    var lastAction : LastAction?

    override func viewDidLoad() {
        super.viewDidLoad()
            self.cerateBellView(bellview: bellView, count: "12")
        corporationName.text = lastAction?.Member_Name ?? ""
        corporationID.text = lastAction?.Member_Id ?? ""
        isin.text = lastAction?.Isin ?? ""
        literalNum.text = lastAction?.Reuter_Code ?? ""
        actionDate.text = lastAction?.Action_Date ?? ""
        action.text = lastAction?.Trans_Type_Desc ?? ""
        actionDescription.text = lastAction?.Action_Type_Desc ?? ""
        beforeAction.text = lastAction?.Value_Before ?? ""
        afterAction.text = lastAction?.Value_After ?? ""
        
        
    }
    

    
}
