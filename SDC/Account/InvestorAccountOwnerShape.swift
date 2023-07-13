
import UIKit
import Alamofire
import JGProgressHUD
import MOLH

struct AccountOwnerShapeHolder {
    var title: String?
    var array: [AccountOwnerShape]?
}


class InvestorAccountOwnerShape : UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UISearchBarDelegate , SelectedNatDelegate {
    
    
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var busnissCard: UITableView!

    @IBOutlet weak var currencyBtn: UIButton!
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var withZero: DesignableButton!
    @IBOutlet weak var withoutZero: DesignableButton!
    @IBOutlet weak var search_bar: UISearchBar!

    var totalDolar : Double?
    var totalDinar : Double?
    var currencyFlag : String?
    var data, filteredData , dolarData , dolarFilteredData: [AccountOwnerShapeHolder]?
    var dinarArray = [AccountOwnerShape]()
    var dolarArray = [AccountOwnerShape]()
    
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
    var isSearching = false


    override func viewDidLoad() {
        super.viewDidLoad()
        isZeroSelected = false
        isWithoutSelected = true
        withZeroFlag = "1"
        currencyFlag = "1"
        currencyBtn.setTitle("JOD", for: .normal)
        self.highlightedButtons()
        self.withoutZero.cornerRadius = 12
        self.withZero.cornerRadius = 12
        self.busnissCard.register(UINib(nibName: "BusnissCardTable", bundle: nil), forCellReuseIdentifier: "BusnissCardTable")
        busnissCard.register(UINib(nibName: "SectionNameView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "SectionNameView")
        self.busnissCard.delegate = self
        self.busnissCard.dataSource = self
        search_bar.delegate = self
        //refreshControl
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
                self.busnissCard.addSubview(refreshControl)
                
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isSearching = false
            filteredData = []
            dolarFilteredData = []
            self.busnissCard.reloadData()
            return
        }
//        if MOLHLanguage.isArabic(){
            
            //            self.arr_search = self.invAccount.filter({($0.Security_Name?.prefix(searchText.count))! == searchText})
            filteredData = []
            dolarFilteredData = []
        
        if currencyFlag == "1" {
            
            if let data {
                let newData = data.filter({!($0.array?.isEmpty ?? true)})
                for item in newData {
                    var itemsArray: [AccountOwnerShape]? = []
                    if let itemArray = item.array {
                        for innerItem in itemArray{
                            if innerItem.Security_Name?.lowercased().contains(searchText.lowercased()) ?? false {
                                itemsArray?.append(innerItem)
                            }
                        }
                    }
                    filteredData?.append(AccountOwnerShapeHolder(title: item.title, array: itemsArray))
                }
            }

            
        }
        
        else if currencyFlag == "22" {
            if let dolarData {
                let newData = dolarData.filter({!($0.array?.isEmpty ?? true)})
                for item in newData {
                    var itemsArray: [AccountOwnerShape]? = []
                    if let itemArray = item.array {
                        for innerItem in itemArray{
                            if innerItem.Security_Name?.lowercased().contains(searchText.lowercased()) ?? false {
                                itemsArray?.append(innerItem)
                            }
                        }
                    }
                    dolarFilteredData?.append(AccountOwnerShapeHolder(title: item.title, array: itemsArray))
                }
            }

        }
        
            self.isSearching = true
            self.busnissCard.reloadData()
        
    }
    
//    search
    func cancelbtn (search:UISearchBar){
        self.seatrching = false
        search_bar.text = ""
        view.endEditing(true)
        busnissCard.reloadData()
    }
    
    
    @IBAction func currencyPressed(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CurrencyPicker") as! CurrencyPicker
        vc.selectedNatDelegate = self
        self.present(vc, animated: true)
        
    }
    
    func getSelectdPicker(selectdTxt: String, flag: String) {
        currencyBtn.setTitle(selectdTxt, for: .normal)
        if flag == "1" {
            totalValue.text = self.numFormat(value: totalDinar ?? 0.0)
            self.currencyFlag = "1"
        }
        else if flag == "22"{
            totalValue.text = self.numFormat(value: totalDolar ?? 0.0)
            self.currencyFlag = "22"
        }
        
        DispatchQueue.main.async {
            self.busnissCard.reloadData()

        }
    }
        
    
    
    //    refresh action
        @objc func didPullToRefresh() {
            self.invAccount.removeAll()
            self.busnissCard.reloadData()
            if isZeroSelected == true && isWithoutSelected == false {
                self.getAccountInvestoreInfo(withZeroFlag: self.withZeroFlag ?? "")
                self.busnissCard.reloadData()

            }
            
            else if isZeroSelected == false && isWithoutSelected == true {
                self.getAccountInvestoreInfo(withZeroFlag: self.withZeroFlag ?? "")
                self.busnissCard.reloadData()
            }
            
        }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if !isSearching {
            if currencyFlag == "1" {
                if let data {
                    let newData = data.filter({!($0.array?.isEmpty ?? true)})
                    return newData.count
                }
            }
            
            else if currencyFlag == "22" {
                if let dolarData {
                    let newData = dolarData.filter({!($0.array?.isEmpty ?? true)})
                    return newData.count
                }
                
            }
            
        }
        
        else {
            
            if currencyFlag == "1" {
                if let filteredData {
                    let newData = filteredData.filter({!($0.array?.isEmpty ?? true)})
                    return newData.count
                }
                
                
            }
            
            else if currencyFlag == "22" {
                if let dolarFilteredData {
                    let newData = dolarFilteredData.filter({!($0.array?.isEmpty ?? true)})
                    return newData.count
                }
            }
        
        }
        
        return 0
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            
            if currencyFlag == "1" {
                if let filteredData {
                    let newData = filteredData.filter({!($0.array?.isEmpty ?? true)})
                    return newData[section].array?.count ?? 0
                }
            }
            
            else if currencyFlag == "22" {
                if let dolarFilteredData {
                    let newData = dolarFilteredData.filter({!($0.array?.isEmpty ?? true)})
                    return newData[section].array?.count ?? 0
                }
            }
        }
       
        
        else {
            if currencyFlag == "1" {
                if let data {
                    let newData = data.filter({!($0.array?.isEmpty ?? true)})
                    return newData[section].array?.count ?? 0
                }
            }
            
            else if currencyFlag == "22"{
                if let dolarData {
                    let newData = dolarData.filter({!($0.array?.isEmpty ?? true)})
                    return newData[section].array?.count ?? 0
                }
            }
        }
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = busnissCard.dequeueReusableHeaderFooterView(withIdentifier: "SectionNameView") as! SectionNameView
        if !isSearching {
            
            if currencyFlag == "1" {
                if let data {
                    let newData = data.filter({!($0.array?.isEmpty ?? true)})
                    headerView.sectionName.text = newData[section].title ?? ""
                }
            }
            
            else {
                if let dolarData {
                    let newData = dolarData.filter({!($0.array?.isEmpty ?? true)})
                    headerView.sectionName.text = newData[section].title ?? ""
                }
            }
            
        }
        
        else {
            if currencyFlag == "1" {
                if let filteredData {
                    let newData = filteredData.filter({!($0.array?.isEmpty ?? true)})
                    headerView.sectionName.text = newData[section].title ?? ""
                }
            }
            
            else if currencyFlag == "22" {
                if let dolarFilteredData {
                    let newData = dolarFilteredData.filter({!($0.array?.isEmpty ?? true)})
                    headerView.sectionName.text = newData[section].title ?? ""
                }
            }
            
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = self.busnissCard.dequeueReusableCell(withIdentifier: "BusnissCardTable", for: indexPath) as? BusnissCardTable
      
        cell?.addtionalStack.isHidden = false
        cell?.mainCardView.layer.cornerRadius =  25
        
        if isSearching  {
            if currencyFlag == "1" {
                if let filteredData {
                    let newData = filteredData.filter({!($0.array?.isEmpty ?? true)})
                    cell?.literalName.text = newData[indexPath.section].array?[indexPath.row].Security_Reuter_Code ?? ""
                    cell?.literalNum.text =  newData[indexPath.section].array?[indexPath.row].securityIsin  ?? ""
                    
                    cell?.sector.text = newData[indexPath.section].array?[indexPath.row].Security_Name ?? ""
                    
                    cell?.balance.text =  self.numStringFormat(value: newData[indexPath.section].array?[indexPath.row].Quantity_Owned ?? "")
                }
            }
            
            else if currencyFlag == "22" {
                if let dolarFilteredData {
                    let newData = dolarFilteredData.filter({!($0.array?.isEmpty ?? true)})
                    cell?.literalName.text = newData[indexPath.section].array?[indexPath.row].Security_Reuter_Code ?? ""
                    cell?.literalNum.text =  newData[indexPath.section].array?[indexPath.row].securityIsin  ?? ""
                    
                    cell?.sector.text = newData[indexPath.section].array?[indexPath.row].Security_Name ?? ""
                    
                    cell?.balance.text =  self.numStringFormat(value: newData[indexPath.section].array?[indexPath.row].Quantity_Owned ?? "")
                }
            }
            
        }
        
        
        else {
            if currencyFlag == "1" {
                if let data {
                    let newData = data.filter({!($0.array?.isEmpty ?? true)})
                    cell?.literalName.text = newData[indexPath.section].array?[indexPath.row].Security_Reuter_Code ?? ""
                    cell?.literalNum.text =  newData[indexPath.section].array?[indexPath.row].securityIsin  ?? ""
                    
                    cell?.sector.text = newData[indexPath.section].array?[indexPath.row].Security_Name ?? ""
                    
                    cell?.balance.text =  self.numStringFormat(value: newData[indexPath.section].array?[indexPath.row].Quantity_Owned ?? "")
                }

            }
            
            else if currencyFlag == "22" {
                
                if let dolarData {
                    let newData = dolarData.filter({!($0.array?.isEmpty ?? true)})
                    cell?.literalName.text = newData[indexPath.section].array?[indexPath.row].Security_Reuter_Code ?? ""
                    cell?.literalNum.text =  newData[indexPath.section].array?[indexPath.row].securityIsin  ?? ""
                    
                    cell?.sector.text = newData[indexPath.section].array?[indexPath.row].Security_Name ?? ""
                    
                    cell?.balance.text =  self.numStringFormat(value: newData[indexPath.section].array?[indexPath.row].Quantity_Owned ?? "")
                }
        }
            
        }
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        Mark
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CardOneVC") as! CardOneVC
        vc.modalPresentationStyle = .fullScreen
        
        if !isSearching {
            if currencyFlag == "1" {
                if let data {
                    let newData = data.filter({!($0.array?.isEmpty ?? true)})
                    vc.invAccount = newData[indexPath.section].array?[indexPath.row]
                }
            }
            
            else {
                if let dolarData {
                    let newData = dolarData.filter({!($0.array?.isEmpty ?? true)})
                    vc.invAccount = newData[indexPath.section].array?[indexPath.row]
                }
            }
        }
        
        
        else {
            
            if currencyFlag == "1" {
                if let filteredData {
                    let newData = filteredData.filter({!($0.array?.isEmpty ?? true)})
                    vc.invAccount = newData[indexPath.section].array?[indexPath.row]
                }
                
            }
            
            
            else if currencyFlag == "22" {
                if let dolarFilteredData {
                    let newData = dolarFilteredData.filter({!($0.array?.isEmpty ?? true)})
                    vc.invAccount = newData[indexPath.section].array?[indexPath.row]
                }
                
            }
           
        }
        self.present(vc, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
    
    @IBAction func clearPressed(_ sender: Any) {
        search_bar.text = ""
        seatrching = false
        filteredData?.removeAll()
        dolarFilteredData?.removeAll()
        self.busnissCard.reloadData()
    }
    
    @IBAction func withoutZeroAction(_ sender: UIButton) {
        invAccount.removeAll()
        data?.removeAll()
        dolarData?.removeAll()
        dolarArray.removeAll()
        dinarArray.removeAll()
        withZeroFlag = "1"
        isWithoutSelected = true
        isZeroSelected = false
        highlightedButtons()
    }
    
    @IBAction func withZeroAction(_ sender: UIButton) {
        invAccount.removeAll()
        data?.removeAll()
        dolarData?.removeAll()
        dinarArray.removeAll()
        dolarArray.removeAll()
        withZeroFlag = "2"
        isZeroSelected = true
        isWithoutSelected = false
        highlightedButtons()
    }
    
    //function for change background selected background color for with and without zero btn
    
    func highlightedButtons() {
        if isZeroSelected  == true && isWithoutSelected == false {
            self.withZeroFlag = "2"
            DispatchQueue.main.async {
                self.withZero.setTitleColor(.white, for: .normal)
                self.withZero.backgroundColor  = UIColor(named: "AccentColor")
                self.withoutZero.setTitleColor( UIColor(named: "AccentColor") , for: .normal)
                self.withoutZero.backgroundColor  = .white
                self.withoutZero.borderColor =  UIColor(named: "AccentColor")
                self.withoutZero.borderWidth = 1
                self.getAccountInvestoreInfo(withZeroFlag: self.withZeroFlag ?? "")
            }
        }
        
        else if !isZeroSelected  && isWithoutSelected {
            self.withZeroFlag = "1"
            DispatchQueue.main.async {
                self.withoutZero.setTitleColor(.white, for: .normal)
                self.withoutZero.backgroundColor  = UIColor(named: "AccentColor")
                self.withZero.setTitleColor(UIColor(named: "AccentColor"), for: .normal) 
                self.withZero.backgroundColor  = .white
                self.withZero.borderColor =  UIColor(named: "AccentColor")
                self.withZero.borderWidth = 1
                self.getAccountInvestoreInfo(withZeroFlag: self.withZeroFlag ?? "")
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }
    
 
    
//    API Call
    
    func getAccountInvestoreInfo(withZeroFlag : String){
        
        let hud = JGProgressHUD(style: .light)
//        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)

    
     
        let param : [String:Any] = [
                                    "sessionId" : Helper.shared.getUserSeassion() ?? ""
                                    ,"lang": MOLHLanguage.isRTLLanguage() ? "ar": "en",
                                    "memberId" : self.memberId,
                                    "accountNo" : self.accountNo,
                                    "securityId":self.securityId,
                                    "with_zero" : withZeroFlag
                                    
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
                                    
                                    self.dinarArray += self.invAccount.filter({ $0.Trade_Currency == "1" })

                                    self.dolarArray += self.invAccount.filter({ $0.Trade_Currency == "22" })
                                    
                                    
                                    
                                    self.data = []
                                    self.dolarData = []
                                    
                                    self.data?
                                        .append(AccountOwnerShapeHolder(title: "Bank".localized(), array: self.dinarArray.filter({($0 .Security_Sector) == "1"})))
                                    self.data?
                                        .append(AccountOwnerShapeHolder(title: "Insurance".localized(), array: self.dinarArray.filter({($0 .Security_Sector) == "2"})))
                                    self.data?
                                        .append(AccountOwnerShapeHolder(title: "Services".localized(), array: self.dinarArray.filter({($0 .Security_Sector) == "3"})))
                                        self.data?
                                            .append(AccountOwnerShapeHolder(title: "Industry".localized(), array: self.dinarArray.filter({($0 .Security_Sector) == "4"})))
                                    
                                    
                                    
                                    self.dolarData?
                                        .append(AccountOwnerShapeHolder(title: "Bank".localized(), array: self.dolarArray.filter({($0 .Security_Sector) == "1"})))
                                    self.dolarData?
                                        .append(AccountOwnerShapeHolder(title: "Insurance".localized(), array: self.dolarArray.filter({($0 .Security_Sector) == "2"})))
                                    self.dolarData?
                                        .append(AccountOwnerShapeHolder(title: "Services".localized(), array: self.dolarArray.filter({($0 .Security_Sector) == "3"})))
                                        self.dolarData?
                                            .append(AccountOwnerShapeHolder(title: "Industry".localized(), array: self.dolarArray.filter({($0 .Security_Sector) == "4"})))
                                           
                                    DispatchQueue.main.async {
                                        self.busnissCard.reloadData()
                                        self.refreshControl?.endRefreshing()
                                        hud.dismiss()
                                    }
                                        }
                                
                                if let total = jsonObj!["total"] as? [String: Any]{
                                    if let dinar = total["1"] as? [String: Any]{
                                        
                                        let market_value = dinar["market_value"] as? Double
                                        
                                        self.totalDinar = market_value
                                        self.totalValue.text = self.numFormat(value: market_value ?? 0.0)
                                        
                                    }
                                    
                                    if let dolar = total["22"] as? [String: Any]{
                                        
                                        let market_value = dolar["market_value"] as? Double
                                        self.totalDolar = market_value
                                        
                                    }
                                }
                                
                                    }
//                             Session ID is Expired
                            else if status == 400{
                                let msg = jsonObj!["message"] as? String
                                self.seassionExpired(msg: msg ?? "")
                            }
                            
//                           other Wise Problem
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
    
    var viewHeight: CGFloat = 180
    private var isAnimationInProgress = false

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isAnimationInProgress {
            
            // Check if an animation is required
            if scrollView.contentOffset.y > .zero &&
                headerConstrianett.constant > .zero {
                
                headerConstrianett.constant = .zero
                headerView.isHidden = true
                animateTopViewHeight()
            }
            else if scrollView.contentOffset.y <= .zero
                        && headerConstrianett.constant <= .zero {
                
                headerConstrianett.constant = viewHeight
                headerView.isHidden = false
                animateTopViewHeight()
            }
        }
    }
    
    private func animateTopViewHeight() {
        
        // Lock the animation functionality
        isAnimationInProgress = true
        
        UIView.animate(withDuration: 0.2) {
            
            self.view.layoutIfNeeded()
            
        } completion: { [weak self] (_) in
            
            // Unlock the animation functionality
            self?.isAnimationInProgress = false
        }
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
