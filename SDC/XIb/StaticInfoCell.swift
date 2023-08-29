//
//  StaticInfoCell.swift
//  SDC
//
//  Created by Razan Barq on 28/08/2023.
//

import UIKit

class StaticInfoCell: UITableViewCell {
    
    @IBOutlet weak var market: UILabel!
    @IBOutlet weak var securityStatus: UILabel!
    @IBOutlet weak var securityName: UILabel!
    @IBOutlet weak var reuterCode: UILabel!
    @IBOutlet weak var isin: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        

    }
    
}
