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
    var checkCompanyAction : Bool?
    var categories : [String] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CurrencyCellTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyCellTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if checkCompanyAction == true {
            return categories.count
        }
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "CurrencyCellTableViewCell", for: indexPath) as? CurrencyCellTableViewCell
       
               if cell == nil {
                   let nib: [Any] = Bundle.main.loadNibNamed("CurrencyCellTableViewCell", owner: self, options: nil)!
                   cell = nib[0] as? CurrencyCellTableViewCell
               }
       else {
           
           if checkCompanyAction == true {
               cell?.currency.text = categories[indexPath.row]
           }
           
           else {
               switch indexPath.row {
               case 0 :
                   cell?.currency.text = "JOD"
               case 1 :
                   cell?.currency.text = "USD"
               default:
                   print("Defaultt")
               }
           }
       }
       
       return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if checkCompanyAction == true {
            
            self.selectedNatDelegate?.getSelectdPicker(selectdTxt: categories[indexPath.row], flag: "\(indexPath.row)")
        }
        
        else {
            switch indexPath.row {
            case 0 :
                self.selectedNatDelegate?.getSelectdPicker(selectdTxt: "JOD", flag: "1")
                            
            case 1 :
                self.selectedNatDelegate?.getSelectdPicker(selectdTxt: "USD", flag: "22")
                
            default:
                print("Defaultt")
            }
        }
        
        
        self.dismiss(animated: true)

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
  }

