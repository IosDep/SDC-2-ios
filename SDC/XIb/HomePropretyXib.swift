//
//  HomePropretyXib.swift
//  SDC
//
//  Created by Blue Ray on 26/03/2023.
//

import UIKit
import Charts
class HomePropretyXib: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var chartView: PieChartView!
    @IBOutlet weak var logo: UIImageView!
    
    
    @IBOutlet weak var mainview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

}
