//
//  NatPickerCell.swift
//  SDC
//
//  Created by Razan Barq on 09/05/2023.
//

import UIKit

class NatPickerCell: UITableViewCell {
    
    
    @IBOutlet weak var investorNum: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var nationality: UILabel!
    
    @IBOutlet weak var centerNum: UILabel!
    
    @IBOutlet weak var invStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
