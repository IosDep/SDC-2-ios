//
//  AccountListXib.swift
//  SDC
//
//  Created by Blue Ray on 04/04/2023.
//

import UIKit

class AccountListXib: UITableViewCell {
    
    @IBOutlet weak var memberNum: UILabel!
    
  
    @IBOutlet weak var memberName: UILabel!
    
    @IBOutlet weak var accountNum: UILabel!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var accountOwnerShape: UIButton!
    @IBOutlet weak var profileInfo: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        greenView.roundCorners([.topLeft, .topRight], radius: 12)

    }


    
}
