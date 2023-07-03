//
//  LastCoorporationActionCell.swift
//  SDC
//
//  Created by Razan Barq on 25/06/2023.
//

import UIKit

class LastCoorporationActionCell: UITableViewCell {
    
    
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var arrowBtn: UIButton!
    @IBOutlet weak var percentage: UILabel!
    @IBOutlet weak var afterAction: UILabel!
    @IBOutlet weak var beforeAction: UILabel!
    @IBOutlet weak var actionType: UILabel!
    @IBOutlet weak var transType: UILabel!
    @IBOutlet weak var company: UILabel!
    
    @IBOutlet weak var actionDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        greenView.roundCorners([.topLeft, .topRight], radius: 12)

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        

        // Configure the view for the selected state
    }
    
}
