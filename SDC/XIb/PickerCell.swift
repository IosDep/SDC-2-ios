//
//  PickerCell.swift
//  SDC
//
//  Created by Razan Barq on 02/05/2023.
//

import UIKit

class PickerCell: UITableViewCell {
    

    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
