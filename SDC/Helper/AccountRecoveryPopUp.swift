//
//  AccountRecoveryPopUp.swift
//  SDC
//
//  Created by Razan Barq on 17/07/2023.
//

import UIKit

class AccountRecoveryPopUp: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var email : String?
    var mobileNum : String?
    
    var selectedNatDelegate:SelectedNatDelegate?

    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CurrencyCellTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyCellTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "CurrencyCellTableViewCell", for: indexPath) as? CurrencyCellTableViewCell
       
               switch indexPath.row {
               case 0 :
                   cell?.currency.text = self.maskEmail(email: email ?? "")
               case 1 :
                   cell?.currency.text = self.maskPhoneNumber(phoneNumber: mobileNum ?? "")
               default:
                   print("Defaultt")
               
           }
       
       return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0 :
            self.selectedNatDelegate?.getSelectdPicker(selectdTxt: email ?? "", flag: "1")
                        
        case 1 :
            self.selectedNatDelegate?.getSelectdPicker(selectdTxt: mobileNum ?? "", flag: "2")
            
        default:
            print("Defaultt")
        }
        
        self.dismiss(animated: true)
    }
    
    func maskEmail(email: String) -> String {
        let components = email.components(separatedBy: "@")
        let username = components[0]
        let domain = components[1]
        
        let maskedUsername = String(username.prefix(1)) + String(repeating: "*", count: username.count ) + String(username.suffix(1))
        
        return maskedUsername + "@" + domain
    }
    
    func maskPhoneNumber(phoneNumber: String) -> String {
        let countryCode = String(phoneNumber.prefix(5))
        let maskedNumber = String(repeating: "*", count: phoneNumber.count - 7)
        let lastDigits = String(phoneNumber.suffix(2))
        
        return countryCode + maskedNumber + lastDigits
    }
    

}
