//
//  AccountListXib.swift
//  SDC
//
//  Created by Blue Ray on 04/04/2023.
//

import UIKit

class AccountListXib: UITableViewCell {
    
    
    @IBOutlet weak var firstLabel: DesignableLabel2!
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var secondLabel: DesignableLabel2!
    @IBOutlet weak var fourthLabel: DesignableLabel2!
    @IBOutlet weak var thirdLabel: DesignableLabel2!
    @IBOutlet weak var buttonsStack: UIStackView!
    @IBOutlet weak var memberNum: UILabel!
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var accountNum: UILabel!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var accountOwnerShape: UIButton!
    @IBOutlet weak var profileInfo: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func fillData(data: SecurityOwnership) {
        self.firstLabel.text = "Member name".localized()
        self.secondLabel.text = "Account No".localized()
        self.thirdLabel.text = "Account type".localized()
        self.fourthLabel.text = "Owned balance".localized()

        self.buttonsStack.isHidden = true
        
        self.memberName.text = data.Member_Name ?? ""
        self.memberNum.text = data.Account_No ?? ""
        self.accountName.text = data.Account_Type_Desc ?? ""
        self.accountNum.text = data.Quantity_Owned ?? ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
//            self.mainCardView.layer.cornerRadius = 23
//            self.mainCardView.layer.masksToBounds = true
//            self.mainCardView.layer.backgroundColor = UIColor.black.cgColor
            self.mainCardView.backgroundColor = UIColor.systemBackground
//            self.mainCardView.layer.shadowColor = UIColor.systemGray3.cgColor
//            self.mainCardView.layer.shadowOpacity = 2
//            self.mainCardView.layer.shadowRadius = 23
//            self.mainCardView.layer.shadowOffset = CGSize(width: 1, height: 2)
//            self.mainCardView.layer.shadowPath = UIBezierPath(rect: self.mainCardView.bounds).cgPath
//            self.mainCardView.layer.shouldRasterize = true
            self.greenView.roundCorners([.topLeft, .topRight], radius: 12)


//            self.mainCardView.layer.cornerRadius = 23
//            self.mainCardView.layer.masksToBounds = true
//            self.mainCardView.layer.shadowColor = UIColor.black.cgColor
//            self.mainCardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//            self.mainCardView.layer.shadowRadius = 23
//            self.mainCardView.layer.shadowOpacity = 0.2
//            self.mainCardView.layer.shouldRasterize = true
//            self.mainCardView.layer.rasterizationScale = UIScreen.main.scale
        }
    }

    
}
