//
//  OnePaperTopHeaderTableViewCell.swift
//  SDC
//
//  Created by Razan Barq on 25/08/2023.
//

import UIKit

protocol OnePaperHeaderDelegate: NSObjectProtocol {
    func didSelectChooseButton()
    func didSelectInquiryButton()
    func didSelectClearButton()
}

class OnePaperTopHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var theNameLabel: DesignableLabel2!
    @IBOutlet weak var chooseButton: DesignableButton!
    @IBOutlet weak var inquiryButton: DesignableButton!
    @IBOutlet weak var clearButton: DesignableButton!
    
    var delegate: OnePaperHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func chooseButtonAction(_ sender: Any) {
        delegate?.didSelectChooseButton()
    }

    @IBAction func inquiryButtonAction(_ sender: Any) {
        delegate?.didSelectInquiryButton()
    }
    
    @IBAction func clearButtonAction(_ sender: Any) {
        delegate?.didSelectClearButton()
    }
}
