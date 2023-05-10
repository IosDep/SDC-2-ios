//
//  InvestorOwnershipVC.swift
//  SDC
//
//  Created by Blue Ray on 19/03/2023.
//

import UIKit
import Alamofire
import JGProgressHUD
import MOLH

class InvestorOwnershipVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIScrollViewDelegate {
    
    @IBOutlet weak var sideMenuBtn: UIButton!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var busnissCard: UITableView!
    var refreshControl: UIRefreshControl!
    var isZeroSelected : Bool?
    var isWithoutSelected : Bool?
    @IBOutlet weak var withZero: DesignableButton!
    @IBOutlet weak var withoutZero: DesignableButton!
    var seatrching = false
    @IBOutlet weak var search_bar: UISearchBar!

    @IBOutlet weak var bellView: UIView!
    var invOwnership = [InvestoreOwnerShape]()
    var invAccount = [InvestoreOwnerShape]()
    var arr_search = [InvestoreOwnerShape]()
    var backColor = UIColor(red: 0.00, green: 0.78, blue: 0.42, alpha: 1.00)
    var checkSideMenu = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.withoutZero.cornerRadius = 12
        self.withZero.cornerRadius = 12
        if checkSideMenu == true {
            backBtn.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
            sideMenuBtn.setImage(UIImage(named: ""), for: .normal)
        }
        isZeroSelected = true
        isWithoutSelected = false
        highlightedButtons()
        self.getInvestoreInfo()
        search_bar.delegate = self

        self.busnissCard.delegate = self
        self.busnissCard.dataSource = self
        self.busnissCard.register(UINib(nibName: "BusnissCardTable", bundle: nil), forCellReuseIdentifier: "BusnissCardTable")

        view.layer.zPosition = 999
        busnissCard.contentInsetAdjustmentBehavior = .never
        
//        self.withZero.titleLabel?.tintColor = .white
//        self.withZero.backgroundColor  = UIColor(named: "AccentColor")
//        self.withZero.cornerRadius = 12
//refreshControl
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        self.busnissCard.addSubview(refreshControl)
        
        self.cerateBellView(bellview: self.bellView, count: "10")
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backPressed(_ sender: Any) {
        if checkSideMenu == true {
            self.dismiss(animated: true, completion: {
                let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.present(vc, animated: true, completion: nil)
            })
        }
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        self.seatrching = true
        busnissCard.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }
    
    
    
    //    refresh action
        @objc func didPullToRefresh() {
            self.invAccount.removeAll()
            self.busnissCard.reloadData()
            self.getInvestoreInfo()
        
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if seatrching{
            return arr_search.count
        }
        
        else {
            return self.invAccount.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CardTwoVc") as! CardTwoVc
        vc.modalPresentationStyle = .fullScreen
        vc.invOwnership = self.invAccount[indexPath.row]
        self.present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.busnissCard.dequeueReusableCell(withIdentifier: "BusnissCardTable", for: indexPath) as? BusnissCardTable
        cell?.addtionalStack.isHidden = false
        if cell == nil {
            let nib: [Any] = Bundle.main.loadNibNamed("BusnissCardTable", owner: self, options: nil)!
            cell = nib[0] as? BusnissCardTable
        }
        
        if seatrching == true {
            
            cell?.mainCardView.layer.cornerRadius =  8
            let data = arr_search[indexPath.row]
            cell?.literalName.text = data.Security_Name
            cell?.literalNum.text = data.securityID
            cell?.sector.text = data.Security_Sector_Desc
            cell?.balance.text = data.Nominal_Value
        }
        
        else {
            cell?.mainCardView.layer.cornerRadius =  8
            let data = invAccount[indexPath.row]
            
            cell?.literalName.text = data.Security_Name
            cell?.literalNum.text = data.securityID
            cell?.sector.text = data.Security_Sector_Desc
            cell?.balance.text = data.Quantity_Avilable
            cell?.balance.text = data.Nominal_Value


        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if MOLHLanguage.isArabic(){
            self.arr_search = self.invAccount.filter({($0.Security_Name?.prefix(searchText.count))! == searchText})
        self.seatrching = true
            self.busnissCard.reloadData()
            
        } else {
            self.arr_search = self.invAccount.filter({($0.Security_Name?.prefix(searchText.count))! == searchText})
            self.seatrching = true
                self.busnissCard.reloadData()
            
        }
    }
    
//    search
    func cancelbtn (search:UISearchBar){
        self.seatrching = false
        search_bar.text = ""
        view.endEditing(true)
        busnissCard.reloadData()
    }
    
    //function for change background selected background color for with and without zero btn
    
    func highlightedButtons() {
        if isZeroSelected == true && isWithoutSelected == false {
            DispatchQueue.main.async{
         
            self.withZero.setTitleColor(.white, for: .normal)
                
            self.withZero.backgroundColor  =
                UIColor(named: "AccentColor")
            self.withoutZero.titleLabel?.textColor = UIColor(named: "AccentColor")
            self.withoutZero.backgroundColor  = .systemGray6
            self.withoutZero.cornerRadius = 12
            self.withoutZero.borderColor =  UIColor(named: "AccentColor")
            self.withoutZero.borderWidth = 1
        }
        
        }
        else if isZeroSelected == false && isWithoutSelected == true {
            DispatchQueue.main.async {
                self.withoutZero.setTitleColor(.white, for: .normal)
                self.withoutZero.backgroundColor = UIColor(named: "AccentColor")
                
                self.withZero.titleLabel?.textColor = UIColor(named: "AccentColor")
                self.withZero.backgroundColor  = .systemGray6
                self.withZero.cornerRadius = 12
                self.withZero.borderColor =  UIColor(named: "AccentColor")
                self.withZero.borderWidth = 1
            }
        }
        
        else {
            self.withoutZero.titleLabel?.tintColor = .black
            self.withoutZero.backgroundColor  = .white
            self.withoutZero.cornerRadius = 12
            self.withoutZero.borderColor =  UIColor(named: "AccentColor")
            self.withoutZero.borderWidth = 1
            self.withZero.backgroundColor  = .white
            self.withZero.cornerRadius = 12
            self.withZero.borderColor =  UIColor(named: "AccentColor")
            self.withZero.borderWidth = 1
            
        }
    }
    
    
    @IBAction func withZeero(btn:UIButton){
        
            isZeroSelected = true
            isWithoutSelected = false
            highlightedButtons()
    }
    
    
    @IBAction func withoutZeero(btn:UIButton){
        isWithoutSelected = true
        isZeroSelected = false
        highlightedButtons()
    }
    
    
    
   
    
//    API Call
    
    
    
    
    func getInvestoreInfo(){
//
        let hud = JGProgressHUD(style: .light)
//        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)

    
     
        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": MOLHLanguage.isRTLLanguage() ? "ar": "en"
 ]
     
        let link = URL(string: APIConfig.GetInvOwnership)

        AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                   

                    if jsonObj != nil {
                        if let status = jsonObj!["status"] as? Int {
                            if status == 200 {
                                if let data = jsonObj!["data"] as? [[String: Any]]{
                                            for item in data {
                                                let model = InvestoreOwnerShape(data: item)
                                                self.invAccount.append(model)
                                 
                                            }
                                            
                                            DispatchQueue.main.async {
                                                self.busnissCard.reloadData()
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
    
    
    @IBOutlet weak var headerView: UIView!
    var previousScrollViewYOffset: CGFloat = 0
    var headerViewIsHidden = false

    @IBOutlet weak var headerConstrianett: NSLayoutConstraint!
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentScrollViewYOffset = scrollView.contentOffset.y
        
        if currentScrollViewYOffset <= 0 {
              // User is at the top of the table view
            headerView.isHidden = false
          } else {
              // User has scrolled down
              headerView.isHidden = true
          }
        if currentScrollViewYOffset > previousScrollViewYOffset {
            // scrolling down
            if !headerViewIsHidden {
                headerViewIsHidden = true
                headerConstrianett.constant = 600

                
                UIView.animate(withDuration: 0.2) {
                    self.headerView.alpha = 0
                }
            }
        } else {
            // scrolling up
            if headerViewIsHidden {
                headerConstrianett.constant = 494

                headerViewIsHidden = false
                UIView.animate(withDuration: 0.2) {
                    self.headerView.alpha = 1
                    
                }
            }
        }
        
        previousScrollViewYOffset = currentScrollViewYOffset
    }

}
