//
//  NatPickerVC.swift
//  SDC
//
//  Created by Razan Barq on 09/05/2023.
//

import UIKit

class NatPickerVC: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
   
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var nationalities = [Nationality]()
    var selectedNatDelegate:SelectedNatDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "NatPickerCell", bundle: nil), forCellReuseIdentifier: "NatPickerCell")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if touch?.view == self.mainView{
            
        }else {
            self.dismiss(animated: true,completion: {
                print("Done WIth  2 second ")
            })
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nationalities.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "NatPickerCell", for: indexPath) as? NatPickerCell
       
               if cell == nil {
                   let nib: [Any] = Bundle.main.loadNibNamed("NatPickerCell", owner: self, options: nil)!
                   cell = nib[0] as? NatPickerCell
               }
       else {
           cell?.investorNum.text = nationalities[indexPath.row].Client_No
           cell?.name.text = nationalities[indexPath.row].Client_Name ?? ""
           cell?.nationality.text = nationalities[indexPath.row].Nationality ?? ""
           cell?.invStatus.text = nationalities[indexPath.row].Client_Status_Desc ?? ""

       }
       
       return cell!
    }
    
    
    
    
    
  }

protocol SelectedNatDelegate{
    func getSelectdPicker(selectdTxt:String,flag:String)
}
