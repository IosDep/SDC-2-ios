//
//  NotficationXIB.swift
//  SDC
//
//  Created by Blue Ray on 26/03/2023.
//

import UIKit

class NotficationXIB: UITableViewCell {
    
    
    @IBOutlet weak var notificationTitle: UILabel!
    
    @IBOutlet weak var dateCreated: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
