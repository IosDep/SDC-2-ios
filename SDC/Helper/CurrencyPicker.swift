//
//  NatPickerVC.swift
//  SDC
//
//  Created by Razan Barq on 09/05/2023.
//

import UIKit

class CurrencyPicker: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var selectedNatDelegate:SelectedNatDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "CurrencyCellTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyCellTableViewCell")
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "CurrencyCellTableViewCell", for: indexPath) as? CurrencyCellTableViewCell
       
               if cell == nil {
                   let nib: [Any] = Bundle.main.loadNibNamed("CurrencyCellTableViewCell", owner: self, options: nil)!
                   cell = nib[0] as? CurrencyCellTableViewCell
               }
       else {
//           s
           switch indexPath.row {
           case 0 :
               cell?.currency.text = "Dinar"
           case 1 :
               cell?.currency.text = "Dollar"
           default:
               print("Defaultt")
           }

       }
       
       return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0 :
            self.selectedNatDelegate?.getSelectdPicker(selectdTxt: "Dinar", flag: "1")
                        
        case 1 :
            self.selectedNatDelegate?.getSelectdPicker(selectdTxt: "Dolar", flag: "22")
            
        default:
            print("Defaultt")
        }
        
        self.dismiss(animated: true)

    }
    
    
  }

