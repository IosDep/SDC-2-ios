//
//  OnePaperSearchHeaderTableViewCell.swift
//  SDC
//
//  Created by Razan Barq on 25/08/2023.
//

import UIKit

class OnePaperSearchHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var theTitleLabel: DesignableLabel2!
    @IBOutlet weak var theDescriptionLabel: DesignableLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
