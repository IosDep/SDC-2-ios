//
//  AccountListXib.swift
//  SDC
//
//  Created by Blue Ray on 04/04/2023.
//

import UIKit

class AccountListXib: UITableViewCell {

    @IBOutlet weak var firstLbl: UILabel!
    
    @IBOutlet weak var secondeLbl: UILabel!
    
    @IBOutlet weak var theraedLbl: UILabel!
    
    
    
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var accountOwnerShape: UIButton!
    
    @IBOutlet weak var profileInfo: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        greenView.roundCorners([.topLeft, .topRight], radius: 12)
    }


    
}
