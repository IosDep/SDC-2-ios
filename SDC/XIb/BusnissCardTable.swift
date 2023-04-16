//
//  BusnissCardTable.swift
//  SDC
//
//  Created by Blue Ray on 19/03/2023.
//

import UIKit

class BusnissCardTable: UITableViewCell {

    @IBOutlet weak var cardFaildOne: UILabel!
    @IBOutlet weak var cardFaildTwo: UILabel!
    @IBOutlet weak var cardFaildThere: UILabel!

    @IBOutlet weak var addtionalLabel: UILabel!
    @IBOutlet weak var addtionalStack: UIStackView!
    @IBOutlet weak var addtionalValue: UILabel!
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var views: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        views.roundCorners([.topLeft, .topRight], radius: 2)

  
    }
    
}
