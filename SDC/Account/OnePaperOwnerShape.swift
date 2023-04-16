//
//  OnePaperOwnerShape.swift
//  SDC
//
//  Created by Blue Ray on 15/04/2023.
//

import UIKit

class OnePaperOwnerShape: UIViewController ,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UISearchBarDelegate{

    
    @IBOutlet weak var search_bar: UISearchBar!
    @IBOutlet weak var ilterNumber: UITextField!
    @IBOutlet weak var paperName: UITextField!

    var seatrching = false

    @IBOutlet weak var busnissCard: UITableView!

    var refreshControl: UIRefreshControl!
    
    
    
    @IBOutlet weak var headerView: UIView!
    var previousScrollViewYOffset: CGFloat = 0
    var headerViewIsHidden = false

    @IBOutlet weak var headerConstrianett: NSLayoutConstraint!
    
    
    @IBOutlet weak var bellView: UIView!

    
    var memberId:String = ""
    var balanceType:String = ""
    var accountNo:String = ""
    var securityId:String = ""
    var invAccount = [InvestoreOwnerShape]()
    var arr_search = [InvestoreOwnerShape]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cerateBellView(bellview: bellView, count: "12")
        
        
        
        self.busnissCard.delegate = self
        self.busnissCard.dataSource = self
        self.busnissCard.register(UINib(nibName: "BusnissCardTable", bundle: nil), forCellReuseIdentifier: "BusnissCardTable")
        

        search_bar.delegate = self

        
        
        //refreshControl
                refreshControl = UIRefreshControl()
                refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
                self.busnissCard.addSubview(refreshControl)
    }
    
    //    refresh action
        @objc func didPullToRefresh() {
            self.invAccount.removeAll()
            self.busnissCard.reloadData()
            
        
        }
    

    
//    Tableview Configration
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if seatrching{
//            return arr_search.count
//        }
//        else {
//            return self.invAccount.count
//        }
        
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = self.busnissCard.dequeueReusableCell(withIdentifier: "BusnissCardTable", for: indexPath) as? BusnissCardTable
      
        
        
        
        if cell == nil {
            let nib: [Any] = Bundle.main.loadNibNamed("BusnissCardTable", owner: self, options: nil)!
            cell = nib[0] as? BusnissCardTable
        }
        

//        if seatrching == true {
//            
//            
//            
//            cell?.mainCardView.layer.cornerRadius =  8
//            let data = arr_search[indexPath.row]
//            
//            cell?.cardFaildOne.text = data.Security_Name
//            cell?.cardFaildTwo.text = data.securityIsin
//            cell?.cardFaildThere.text = data.clientNo
//            
//            
//            
//        }else {
//            
// 
//            cell?.mainCardView.layer.cornerRadius =  8
//            let data = invAccount[indexPath.row]
//            
//            cell?.cardFaildOne.text = data.Security_Name
//            cell?.cardFaildTwo.text = data.securityIsin
//            cell?.cardFaildThere.text = data.clientNo
//            
//        }
//        
//        
//
//        
        
        

        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
    
    
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentScrollViewYOffset = scrollView.contentOffset.y
        
        if currentScrollViewYOffset > previousScrollViewYOffset {
            // scrolling down
            if !headerViewIsHidden {
                headerViewIsHidden = true
                headerConstrianett.constant = 850

                
                UIView.animate(withDuration: 0.2) {
                    self.headerView.alpha = 0
                }
            }
        } else {
            // scrolling up
            if headerViewIsHidden {
                headerConstrianett.constant = 310

                headerViewIsHidden = false
                UIView.animate(withDuration: 0.2) {
                    self.headerView.alpha = 1
                    
                }
            }
        }
        
        previousScrollViewYOffset = currentScrollViewYOffset
    }


}
