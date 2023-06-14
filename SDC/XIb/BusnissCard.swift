//
//  BusnissCard.swift
//  SDC
//
//  Created by Blue Ray on 15/03/2023.
//

import UIKit

class BusnissCard: UICollectionViewCell {
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var firstlbl: UILabel!
    @IBOutlet weak var secondlbl: UILabel!
    @IBOutlet weak var theredlbl: UILabel!
//    @IBOutlet weak var forth: UILabel!

    @IBOutlet weak var greenView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        greenView.roundCorners([.topLeft, .topRight], radius: 10)


    }

   
    
}
