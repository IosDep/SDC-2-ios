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
        
        self.memberName.text = data.Account_No ?? ""
        self.memberNum.text = data.Member_Name ?? ""
        self.accountName.text = data.Account_Type_Desc ?? ""
        self.accountNum.text = data.Quantity_Owned ?? ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.mainCardView.backgroundColor = UIColor.systemBackground
            self.greenView.roundCorners([.topLeft, .topRight], radius: 10)
            self.mainCardView.layer.shadowColor = UIColor.black.cgColor
            self.mainCardView.layer.shadowOpacity = 0.2
            self.mainCardView.layer.shadowOffset = CGSize(width: 2, height: 2)
            self.mainCardView.layer.shadowRadius = 4
            self.mainCardView.layer.masksToBounds = false



        }
    }

    
}
