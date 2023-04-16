//
//  TradingXibView.swift
//  
//
//  Created by Blue Ray on 06/04/2023.
//

import UIKit

class TradingXibView: UITableViewCell {

    @IBOutlet weak var value1: UILabel!
    @IBOutlet weak var value2: UILabel!
    @IBOutlet weak var value3: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var type: DesignableLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
