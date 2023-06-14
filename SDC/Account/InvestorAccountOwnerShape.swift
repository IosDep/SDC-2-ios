
import UIKit
import Alamofire
import JGProgressHUD
import MOLH
class InvestorAccountOwnerShape : UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UISearchBarDelegate {
    
    
    @IBOutlet weak var busnissCard: UITableView!

    var refreshControl: UIRefreshControl!
    @IBOutlet weak var withZero: DesignableButton!
    @IBOutlet weak var withoutZero: DesignableButton!
    @IBOutlet weak var search_bar: UISearchBar!

    @IBOutlet weak var bellView: UIView!
    
    
    var memberId:String = ""
    var balanceType:String = ""
    var accountNo:String = ""
    var securityId:String = ""
    var invAccount = [AccountOwnerShape]()
    var arr_search = [AccountOwnerShape]()
    var withZeroFlag : String?
    var seatrching = false
    var isZeroSelected : Bool = false
    var isWithoutSelected : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        isZeroSelected = true
        isWithoutSelected = false
        withZeroFlag = "1"
        self.withoutZero.cornerRadius = 12
        self.withZero.cornerRadius = 12
        self.withoutZero.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        self.highlightedButtons()
        self.busnissCard.delegate = self
        self.busnissCard.dataSource = self
        self.busnissCard.register(UINib(nibName: "BusnissCardTable", bundle: nil), forCellReuseIdentifier: "BusnissCardTable")
        self.getAccountInvestoreInfo(withZero: withZeroFlag ?? "")

        search_bar.delegate = self

        
        self.cerateBellView(bellview: self.bellView, count: "10")
        
        // Do any additional setup after loading the view.
        
        //refreshControl
                refreshControl = UIRefreshControl()
                refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
                self.busnissCard.addSubview(refreshControl)
                
                
                self.cerateBellView(bellview: self.bellView, count: "10")
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if MOLHLanguage.isArabic(){
            self.arr_search = self.invAccount.filter({($0.Security_Name?.prefix(searchText.count))! == searchText})
        self.seatrching = true
            self.busnissCard.reloadData()
            
        } else {
            self.arr_search = self.invAccount.filter({($0.Security_Name?.prefix(searchText.count))! == searchText} )
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
    
    
    //    refresh action
        @objc func didPullToRefresh() {
            self.invAccount.removeAll()
            self.busnissCard.reloadData()
            if isZeroSelected == true && isWithoutSelected == false {
                self.getAccountInvestoreInfo(withZero: self.withZeroFlag ?? "")
                self.busnissCard.reloadData()

            }
            
            else if isZeroSelected == false && isWithoutSelected == true {
                self.getAccountInvestoreInfo(withZero: self.withZeroFlag ?? "")
                self.busnissCard.reloadData()
            }
            
            
        
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if seatrching{
            return arr_search.count
        }
        else {
            return self.invAccount.count
        }    }
    
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
            
        }else if !(invAccount.isEmpty) {
            

            cell?.mainCardView.layer.cornerRadius =  8
            let data = invAccount[indexPath.row]
            
            cell?.literalName.text = data.Security_Name
            cell?.literalNum.text = data.securityID
            cell?.sector.text = data.Security_Sector_Desc
            cell?.balance.text = data.Security_Close_Price
            
        }
       
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        Mark
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CardOneVC") as! CardOneVC
        vc.modalPresentationStyle = .fullScreen
        vc.invAccount = self.invAccount[indexPath.row]
        self.present(vc, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
    
    @IBAction func clearPressed(_ sender: Any) {
        search_bar.text = ""
        seatrching = false
        self.arr_search.removeAll()
        self.busnissCard.reloadData()
    }
    
    @IBAction func withoutZeroAction(_ sender: UIButton) {
        invAccount.removeAll()
        withZeroFlag = "0"
        isWithoutSelected = true
        isZeroSelected = false
        highlightedButtons()
    }
    
    @IBAction func withZeroAction(_ sender: UIButton) {
        invAccount.removeAll()
        withZeroFlag = "1"
        isZeroSelected = true
        isWithoutSelected = false
        highlightedButtons()
    }
    
    //function for change background selected background color for with and without zero btn
    
    func highlightedButtons() {
        if isZeroSelected  == true && isWithoutSelected == false {
            DispatchQueue.main.async {
                self.withZero.setTitleColor(.white, for: .normal)
                self.withZero.backgroundColor  = UIColor(named: "AccentColor")
                self.withoutZero.titleLabel?.textColor = UIColor(named: "AccentColor")
                self.withoutZero.backgroundColor  = .systemGray6
//                self.withoutZero.cornerRadius = 12
                self.withoutZero.borderColor =  UIColor(named: "AccentColor")
                self.withoutZero.borderWidth = 1
                self.getAccountInvestoreInfo(withZero: self.withZeroFlag ?? "")
            }
        }
        else if !isZeroSelected  && isWithoutSelected {
            DispatchQueue.main.async {
                self.withoutZero.setTitleColor(.white, for: .normal)
                self.withoutZero.backgroundColor  = UIColor(named: "AccentColor")
                self.withZero.titleLabel?.textColor = UIColor(named: "AccentColor")
                self.withZero.backgroundColor  = .systemGray6
//                self.withZero.cornerRadius = 12
                self.withZero.borderColor =  UIColor(named: "AccentColor")
                self.withZero.borderWidth = 1
                self.getAccountInvestoreInfo(withZero: self.withZeroFlag ?? "")
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }
    
 
    
//    API Call
    
    func getAccountInvestoreInfo(withZero : String){
        
        let hud = JGProgressHUD(style: .light)
//        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)

    
     
        let param : [String:Any] = [
                                    "sessionId" : Helper.shared.getUserSeassion() ?? ""
                                    ,"lang": MOLHLanguage.isRTLLanguage() ? "ar": "en",
                                    "memberId" : self.memberId,
                                    "accountNo" : self.accountNo,
                                    "securityId":self.securityId,
                                    "with_zero" : withZero
 ]
     
        let link = URL(string: APIConfig.GetAccountOwnerShpe)

        AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                   

                    if jsonObj != nil {
                        
                        
                            
                            
                        if let status = jsonObj!["status"] as? Int {
                            if status == 200 {
                                
                                if let partialData = jsonObj!["partialData"] as? [[String : Any]] {
                                    
                                }
                                    
                                if let data = jsonObj!["data"] as? [[String: Any]]{
                                            for item in data {
                                                let model = AccountOwnerShape(data: item)
                                                self.invAccount.append(model)
                                 
                                            }
                                            
                                            DispatchQueue.main.async {
                                                self.busnissCard.reloadData()
                                                self.refreshControl?.endRefreshing()
                                                hud.dismiss()


                                            }
                                        }
                                
                                    }
//                             Session ID is Expired
                            else if status == 400{
                                let msg = jsonObj!["message"] as? String
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
extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
