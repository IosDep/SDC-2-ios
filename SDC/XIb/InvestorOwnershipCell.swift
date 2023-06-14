//
//  InvestorOwnershipCell.swift
//  SDC
//
//  Created by Razan Barq on 13/06/2023.
//

import UIKit

class InvestorOwnershipCell: UITableViewCell , UITableViewDelegate , UITableViewDataSource {
    

    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var busnissCard: UITableView!
    
    var invOwnership = [InvestoreOwnerShape]()
    var invAccount = [InvestoreOwnerShape]()
    var arr_search = [InvestoreOwnerShape]()
    var investorOwnershipDelegate : InvestorOwnershipDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.busnissCard.delegate = self
        self.busnissCard.dataSource = self
        self.busnissCard.register(UINib(nibName: "BusnissCardTable", bundle: nil), forCellReuseIdentifier: "BusnissCardTable")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return invAccount.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.busnissCard.dequeueReusableCell(withIdentifier: "BusnissCardTable", for: indexPath) as? BusnissCardTable
        cell?.addtionalStack.isHidden = false
        
            cell?.literalName.text = invAccount[indexPath.row].Security_Name ?? ""
            cell?.literalNum.text = invAccount[indexPath.row].securityID  ?? ""
            cell?.sector.text = invAccount[indexPath.row].Security_Sector_Desc ?? ""
            cell?.balance.text = invAccount[indexPath.row].Security_Close_Price ?? ""
        
        return cell!
    }
    
   
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        investorOwnershipDelegate?.cardSelected(invAccount: invAccount[indexPath.row])

    }
    
}


protocol InvestorOwnershipDelegate {
    func cardSelected(invAccount : InvestoreOwnerShape)
    
}
