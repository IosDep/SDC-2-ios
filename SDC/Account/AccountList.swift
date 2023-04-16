//
//  AccountList.swift
//  SDC
//
//  Created by Blue Ray on 04/04/2023.
//

import UIKit
import Alamofire
import MOLH
import JGProgressHUD

class AccountList: UIViewController,UITableViewDelegate,UITableViewDataSource {

    

    @IBOutlet weak var tableVIew: UITableView!
    @IBOutlet weak var roundview: UIView!

    @IBOutlet weak var bellView: UIView!
    
    var accountList =  [AccountListModel]()
    var refreshControl: UIRefreshControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableVIew.dataSource = self
        tableVIew.delegate = self
        
        self.getAccountList()

//        roundview.roundCorners([.topLeft,.topRight], radius: 12)
        
        cerateBellView(bellview: self.bellView, count: "12")
        
        tableVIew.register(UINib(nibName: "AccountListXib", bundle: nil), forCellReuseIdentifier: "AccountListXib")
        
        //refreshControl
                refreshControl = UIRefreshControl()
                refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        self.tableVIew.addSubview(refreshControl)
                

        // Do any additional setup after loading the view.
    }
    @objc func didPullToRefresh() {
        self.accountList.removeAll()
        self.tableVIew.reloadData()
        self.getAccountList()
    
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell = self.tableVIew.dequeueReusableCell(withIdentifier: "AccountListXib", for: indexPath) as? AccountListXib
      
        
        
        
        if cell == nil {
            let nib: [Any] = Bundle.main.loadNibNamed("AccountListXib", owner: self, options: nil)!
            cell = nib[0] as? AccountListXib
        }
        
        let data = accountList[indexPath.row]
        cell?.firstLbl.text = data.Account_No
        cell?.secondeLbl.text = data.Member_Name
        cell?.theraedLbl.text = data.Member_Type
        
        
        
        cell?.accountOwnerShape.tag =  indexPath.row
        cell?.accountOwnerShape.addTarget(self, action: #selector(accountOwnerShape), for:.touchUpInside)
        
        cell?.profileInfo.tag =  indexPath.row
        
        cell?.profileInfo.addTarget(self, action: #selector(accountInfo), for:.touchUpInside)
        
        
        
        return cell!
        
        
        
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
    
    @objc func accountOwnerShape(sender: UIButton){
        
        
//        let cell  =
        
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

        let vc = storyBoard.instantiateViewController(withIdentifier: "InvestorAccountOwnerShape") as! InvestorAccountOwnerShape
        vc.modalPresentationStyle = .fullScreen
  
        vc.memberId = self.accountList[sender.tag].Member_No ?? ""
        vc.accountNo =  self.accountList [sender.tag].Account_No ?? ""
//        vc.securityId  = self.accountList[sender.tag].s
        
        
        self.present(vc, animated: true)
        
        
    }
    @objc func accountInfo(){
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

        
        let vc = storyBoard.instantiateViewController(withIdentifier: "AccountInfoDetails") as! AccountInfoDetails
        
        vc.modalPresentationStyle = .fullScreen
  
        self.present(vc, animated: true)
        
    }
    
    
    
    
    //    API Call
        
        func getAccountList(){
            
            

    //
            let hud = JGProgressHUD(style: .light)
    //        hud.textLabel.text = "Please Wait".localized()
            hud.show(in: self.view)

        
         
            let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": MOLHLanguage.isRTLLanguage() ? "ar": "en"
     ]
         
            let link = URL(string: APIConfig.GetAccountInfo)

            AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
                if response.error == nil {
                    do {
                        let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                       

                        if jsonObj != nil {
                            
                            
                                
                                
                            if let status = jsonObj!["status"] as? Int {
                                if status == 200 {
                                    
                                
                                        
                                    if let data = jsonObj!["data"] as? [[String: Any]]{
                                                for item in data {
                                                    let model = AccountListModel(data: item)
                                                    self.accountList.append(model)
                                     
                                                }
                                                
                                                DispatchQueue.main.async {
                                                    self.tableVIew.reloadData()
                                                    self.refreshControl?.endRefreshing()
                                                    hud.dismiss()
    //                                                self.showSuccessHud(msg: message ?? "", hud: hud)
                                                    
    //                                                if self.car_arr.count == 0{
    //
    //
    //                                                    self.noDataImage.isHidden = false
    //                                                }else{
    //
    //                                                    self.noDataImage.isHidden = true
    //                                                }

                                                }
                                            }
                                    
                                        }
    //                             Session ID is Expired
                                else if status == 400{
                                    let msg = jsonObj!["message"] as? String
    //                                self.showErrorHud(msg: msg ?? "")
                                    self.seassionExpired(msg: msg ?? "")
                                }
                                    
                                    
                                    
                                    
    //                                other Wise Problem
                                else {  self.refreshControl.endRefreshing()
                                                    hud.dismiss(animated: true)      }
                          
                                
                            }
                            
                        }

                    } catch let err as NSError {
                        print("Error: \(err)")
                        self.serverError(hud: hud)
                        self.refreshControl.endRefreshing()

                  }
                } else {
                    print("Error")

                    self.serverError(hud: hud)
                    self.refreshControl.endRefreshing()


                }
            }




            
            
            
        }
}
