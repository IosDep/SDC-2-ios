//
//  PieTableCell.swift
//  SDC
//
//  Created by Razan Barq on 26/06/2023.
//

import UIKit

class PieTableCell: UITableViewCell {
    
    @IBOutlet weak var percentageValue: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var value: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
