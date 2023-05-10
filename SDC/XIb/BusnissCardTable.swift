//
//  BusnissCardTable.swift
//  SDC
//
//  Created by Blue Ray on 19/03/2023.
//

import UIKit

class BusnissCardTable: UITableViewCell {

    @IBOutlet weak var firstLbl: DesignableLabel2!
    
    @IBOutlet weak var secondLbl: DesignableLabel2!
    
    @IBOutlet weak var thirdLbl: DesignableLabel2!
    
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var literalNum: UILabel!
    
    
    @IBOutlet weak var extraStack: UILabel!
    @IBOutlet weak var sector: UILabel!
    @IBOutlet weak var addtionalLabel: UILabel!
    @IBOutlet weak var addtionalStack: UIStackView!
    @IBOutlet weak var literalName: UILabel!
    @IBOutlet weak var addtionalValue: UILabel!
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var views: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        views.roundCorners([.topLeft, .topRight], radius: 2)
        
        
  
    }
    
}
