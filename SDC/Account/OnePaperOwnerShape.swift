//
//  OnePaperOwnerShape.swift
//  SDC
//
//  Created by Blue Ray on 15/04/2023.
//

import UIKit
import Alamofire
import MOLH
import JGProgressHUD

struct SecurityOwnerShapeHolder {
    var title: String?
    var array: [SecurityOwnership]?
}



class OnePaperOwnerShape: UIViewController ,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate , DataSelectedDelegate , SelectedNatDelegate, OnePaperHeaderDelegate {
    
    @IBOutlet weak var pdfBtn: UIButton!
    @IBOutlet weak var searchStack: UIStackView!
    
    @IBOutlet weak var staticCellInfo: UIView!
    @IBOutlet weak var securityNameLabel: UIButton!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var busnissCard: UITableView!
    @IBOutlet weak var isinLabel: UILabel!
    @IBOutlet weak var reuterCode: UILabel!
    @IBOutlet weak var secNameLabel: UILabel!
    @IBOutlet weak var secStatusLabel: UILabel!
    @IBOutlet weak var secMarketLabel: UILabel!
    
//    @IBOutlet weak var bellView: UIView!
    
    var totalDolar : Double?
    var totalDinar : Double?
    var currencyFlag : String?
    var didPick = false
    var flagSelectedTxt = false
    var pickerData: [String]?
    
    var dinarData, filteredData , dolarData , dolarFilteredData: [SecurityOwnerShapeHolder]?
    
    var dinarArray = [SecurityOwnership]()
    var dolarArray = [SecurityOwnership]()
    var dataArray = [PartialDataModel]()
    
    
    var memberId:String = ""
    var balanceType:String = ""
    var accountNo:String = ""
    var securityId:String = ""
    var invAccount = [InvestoreOwnerShape]()
    var securityOwnership = [SecurityOwnership]()
    var arr_search = [InvestoreOwnerShape]()
    var secData = [SecurityData]()
    var isZeroSelected : Bool?
    var isWithoutSelected : Bool?
    var withZeroFlag : String?
    var refreshControl: UIRefreshControl!
    var seatrching = false
    var numberCode = [String]()
    var securityName = [String]()
    var selectedPaperName : String?
    var selectedLiteralNum : String?
    var checkSideMenu = false
    var securtyIdToCallApi:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pdfBtn.isEnabled = false
        staticCellInfo.isHidden = true
        
        if checkSideMenu == true {
//            sideMenuBtn.setImage(UIImage(named: ""), for: .normal)
        }
        
        self.getInvestoreInfo(withZero: withZeroFlag ?? "")
        self.busnissCard.delegate = self
        self.busnissCard.dataSource = self
        self.busnissCard.register(UINib(nibName: "AccountListXib", bundle: nil), forCellReuseIdentifier: "AccountListXib")
        self.busnissCard.register(.init(nibName: "OnePaperSearchHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "OnePaperSearchHeaderTableViewCell")
        self.busnissCard.register(.init(nibName: "OnePaperTopHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "OnePaperTopHeaderTableViewCell")
        self.busnissCard.register(UINib.init(nibName: "OnePaperOwnerShipDataHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "OnePaperOwnerShipDataHeaderView")
        self.busnissCard.register(.init(nibName: "StaticInfoCell", bundle: nil), forCellReuseIdentifier: "StaticInfoCell")

    }
    
    
    @IBAction func currencyPressed(_ sender: Any) {
    
    }
    
    
    //    Tableview Configration
    
    
    
    @IBAction func clearBtnPressed(_ sender: Any) {
    
    }
    
    
    @IBAction func pdfPressed(_ sender: Any) {
        
        self.getSecurityOwnershipPDF(securtID: securtyIdToCallApi ?? "", withZero: withZeroFlag ?? "")
        
    }
    
    
    // jod usd option
    
    func getSelectdPicker(selectdTxt: String, flag: String) {
//        currencyBtn.setTitle(selectdTxt, for: .normal)
//        if flag == "1" {
//            totalValue.text = self.numFormat(value: totalDinar ?? 0.0)
//            self.currencyFlag = "1"
//        }
//        else if flag == "22"{
//            totalValue.text = self.numFormat(value: totalDolar ?? 0.0)
//            self.currencyFlag = "22"
//        }
//
//        DispatchQueue.main.async {
//            self.busnissCard.reloadData()
//
//
//        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return didPick ? 3 : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if didPick {
            switch section {
            case 0:
                return 1
            case 1:
                return 1
            case 2:
                return securityOwnership.count
            default:
                return 0
            }
        }
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "OnePaperTopHeaderTableViewCell", for: indexPath) as? OnePaperTopHeaderTableViewCell {
                cell.delegate = self
                cell.chooseButton.setTitle(didPick ? "\(pickerData?[2] ?? "")/\(pickerData?[1] ?? "")" : "choose".localized(), for: .normal)
                return cell
            }
        case 1:
//            if let cell = tableView.dequeueReusableCell(withIdentifier: "OnePaperSearchHeaderTableViewCell", for: indexPath) as? OnePaperSearchHeaderTableViewCell {
//
//                switch indexPath.row {
//                case 0:
//                    cell.theTitleLabel.text = "ISIN".localized()
//                case 1:
//                    cell.theTitleLabel.text = "Reuter Code".localized()
//                case 2:
//                    cell.theTitleLabel.text = "Security Name".localized()
//                case 3:
//                    cell.theTitleLabel.text = "Security Status".localized()
//                case 4:
//                    cell.theTitleLabel.text = "Market".localized()
//                default:
//                    break
//                }
//                cell.theDescriptionLabel.text = pickerData?[indexPath.row] ?? ""
//                return cell
//            }
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "StaticInfoCell", for: indexPath) as? StaticInfoCell {
                cell.isin.text = pickerData?[0]
                cell.reuterCode.text = pickerData?[1]
                cell.securityName.text = pickerData?[2]
                cell.securityStatus.text = pickerData?[3]
                cell.market.text = pickerData?[4]
                
                return cell
            }
            
            
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AccountListXib", for: indexPath) as? AccountListXib {
                cell.fillData(data: securityOwnership[indexPath.row])
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == 1 {
//            if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "OnePaperOwnerShipDataHeaderView") as? OnePaperOwnerShipDataHeaderView {
//                return header
//            }
//        }
//        return nil
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 1 {
//            return 60
//        }
//        return .zero
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0, 1:
            return UITableView.automaticDimension
        case 2:
            return 230
        default:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 2:
            return 230
        default:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "CardOneVC") as! CardOneVC
            vc.checkOnepaper = true
            vc.modalPresentationStyle = .fullScreen
            
            vc.securityOwnership = securityOwnership[indexPath.row]
            
            self.present(vc, animated: true)
        }
    }
    
    func didSelectChooseButton() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PickerVC") as! PickerVC
        
        vc.dataSelectedDelegate = self
        vc.checkFlag = "0"
        vc.secData = self.secData
        vc.checkAccountStatmnt = false
        self.present(vc, animated: true)
    }
    
    func didSelectInquiryButton() {
        if flagSelectedTxt == true {
            self.getSecurityOwnership(securtID: securtyIdToCallApi ?? "", withZero: withZeroFlag ?? "")
        }
        else {
            showErrorHud(msg: "Please fill security name")
        }
    }
    
    func didSelectClearButton() {
        didPick = false
        securityOwnership.removeAll()
        busnissCard.reloadData()
    }
    
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if !decelerate && scrollView.contentOffset.y == 0 {
//
//            // scrolling down
//            if !headerViewIsHidden {
//
//                headerViewIsHidden = true
//                headerConstrianett.constant = 850
//
//
//                UIView.animate(withDuration: 0.2) {
//                    self.headerView.alpha = 0
//                }
//            }
//        } else {
//            // scrolling up
//            if headerViewIsHidden {
//                headerConstrianett.constant = 310
//
//                headerViewIsHidden = false
//                UIView.animate(withDuration: 0.2) {
//                    self.headerView.alpha = 1
//
//                }
//            }
//        }
//
//    }
    
    func getSelectdPicker(selectdTxt: String, securtNumber: String, flag: String, securtyId: String, secMarket: String, secStatus: String, secISIN: String) {
        pdfBtn.isEnabled = true
        pickerData = []
        pickerData?.append(secISIN)
        pickerData?.append(securtNumber)
        pickerData?.append(selectdTxt)
        pickerData?.append(secStatus)
        pickerData?.append(secMarket)
        didPick = true

        self.securityOwnership.removeAll()
        self.busnissCard.reloadData()
        
        if flag == "0" {
            
            searchStack.isHidden = false
            staticCellInfo.isHidden = false
            
            selectedPaperName = selectdTxt
            self.securityNameLabel.setTitle(  "\(selectdTxt)/\(securtNumber)" , for: .normal)
           // ??
            
        }
        
        
        self.securtyIdToCallApi = securtyId
        
        flagSelectedTxt = true
        
        isinLabel.text = secISIN ?? ""
        reuterCode.text = securtNumber ?? ""
        secNameLabel.text = selectdTxt ?? ""
        secStatusLabel.text = secStatus ?? ""
        secMarketLabel.text = secMarket ?? ""
        
        
        print("Securty !!",securtyId)
        print("Securty !!",securtyId)
    }
    
    
    
    func getSelectdPicker(selectdTxt: String, securtNumber: String, flag: String, securtyId: String, secMarket: String, secStatus: String) {
        
        
        
    }
    
    
    
    
    
    // Security name Picker pressed
    
    @IBAction func securityNamePressed(_ sender: Any) {
        
    }
    
    
    @IBAction func literalNumPressed(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PickerVC") as! PickerVC
        vc.dataSelectedDelegate = self
        
        vc.checkFlag = "1"
        vc.checkAccountStatmnt = false
        
        vc.secData = self.secData
        
        self.present(vc, animated: true)
    }
    
    
    @IBAction func searchPressed(_ sender: Any) {
        
        if flagSelectedTxt == true {
            self.getSecurityOwnership(securtID: securtyIdToCallApi ?? "", withZero: withZeroFlag ?? "")
                
        }
        else {
            showErrorHud(msg: "Please fill security name")
        }

    }
    
    
    
    
    
    func getInvestoreInfo(withZero : String){
        //
        let hud = JGProgressHUD(style: .light)
        //        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        
        
        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang":  MOLHLanguage.isRTLLanguage() ? "ar" : "en" ,
                                    "with_zero" : "1"
                                    

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
                                    
                                    
                                }
                                
                                // partialData
                                
                                if let partialData = jsonObj!["partialData"] as? [[String: Any]]{


                                    for item in partialData {
                                        let model = PartialDataModel(data: item)
                                        self.dataArray.append(model)

                                        self.secData.append(SecurityData(secName: model.Security_Name ?? "", secNum: model.Security_Reuter_Code ?? "" , securotyID: model.Security_Id ?? "" , secMarket: model.Market_Type_Desc ?? "" , secStatus: model.Security_Status_Desc ?? "" , secISIN: model.Security_Isin ?? ""))

                                    }

                                    DispatchQueue.main.async {
                                        hud.dismiss()

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
                            else {
                                hud.dismiss(animated: true)
                                
                                
                                
                            }
                            
                            
                        }
                        
                    }
                    
                } catch let err as NSError {
                    print("Error: \(err)")
                    self.serverError(hud: hud)
                    
                }
            } else {
                print("Error")
                
                self.serverError(hud: hud)
                
                
            }
        }
    }
    
    func getSecurityOwnership(securtID:String , withZero : String){
        
       
        let hud = JGProgressHUD(style: .light)
        
        hud.show(in: self.view)
        
        
        
        let param : [String:Any] = [
            "sessionId" : Helper.shared.getUserSeassion() ?? ""
            ,"lang": MOLHLanguage.isRTLLanguage() ? "ar" : "en",
            "securityId":self.securtyIdToCallApi ?? "" ,
            "with_zero" : withZeroFlag
        ]
        
        let link = URL(string: APIConfig.GetSecurityOwnership)
        
        AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    
                    if jsonObj != nil {
                        
                        if let status = jsonObj!["status"] as? Int {
                            if status == 200 {
                                
                                
                                if let data = jsonObj!["data"] as? [[String: Any]]{
                                    for item in data {
                                        let model = SecurityOwnership(data: item)
                                        self.securityOwnership.append(model)
                                        
                                    }
                                    
                                   
                                    
                                    DispatchQueue.main.async {
                                        
                                        if self.securityOwnership.count == 0 {
                                            self.showWarningHud(msg: "No data to show".localized(), hud: hud)
                                        }
                                        
                                        self.busnissCard.reloadData()
                                        self.refreshControl?.endRefreshing()
                                        hud.dismiss()
                                        
                                        
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
                // self.refreshControl.endRefreshing()
                
                
            }
        }
    }
    
    
    func getSecurityOwnershipPDF(securtID:String , withZero : String){
        
        
        
        let hud = JGProgressHUD(style: .light)
        
        hud.show(in: self.view)
        
        
        
        let param : [String:Any] = [
            "sessionId" : Helper.shared.getUserSeassion() ?? ""
            ,"lang": MOLHLanguage.isRTLLanguage() ? "ar" : "en",
            "securityId":self.securtyIdToCallApi ?? "" ,
            "with_zero" : withZeroFlag
        ]
        
        let link = URL(string: APIConfig.GetSecurityOwnershipPDF)
        
        AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    
                    if jsonObj != nil {
                        
                        if let status = jsonObj!["status"] as? Int {
                            if status == 200 {
                                
                                if let data = jsonObj!["data"] as? [String: Any]{
                                    
                                    
                                    let file = data["file"] as? String
                                    
                                  DispatchQueue.main.async {
                                  hud.dismiss(afterDelay: 1.5, animated: true,completion: {
                                            
                              let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                              let vc = storyBoard.instantiateViewController(withIdentifier: "PDFViewerVC") as! PDFViewerVC
                                                vc.url = file
                                                vc.flag = 6
                                                vc.modalPresentationStyle = .fullScreen
                                                self.present(vc, animated: true)
                                                
                                            
                                        })
                                        
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
    
    var viewHeight: CGFloat = 400
    private var isAnimationInProgress = false
    
    
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let currentScrollViewYOffset = scrollView.contentOffset.y
//        
//        if currentScrollViewYOffset <= 0 {
//              // User is at the top of the table view
//            headerView.isHidden = false
//          } else {
//              // User has scrolled down
//              headerView.isHidden = true
//          }
//        if currentScrollViewYOffset > previousScrollViewYOffset {
//            // scrolling down
//            if !headerViewIsHidden {
//                headerViewIsHidden = true
//                headerConstrianett.constant = 600
//
//                UIView.animate(withDuration: 0.2) {
//                    self.headerView.alpha = 0
//                }
//            }
//        } else {
//            // scrolling up
//            if headerViewIsHidden {
//                headerConstrianett.constant = 600
//                headerViewIsHidden = false
//                UIView.animate(withDuration: 0.2) {
//                    self.headerView.alpha = 1
//                    
//                }
//            }
//        }
//        
//        previousScrollViewYOffset = currentScrollViewYOffset
//    }


//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if !isAnimationInProgress {
//
//            // Check if an animation is required
//            if scrollView.contentOffset.y > .zero &&
//                headerConstrianett.constant > .zero {
//
//                headerConstrianett.constant = .zero
//                headerView.isHidden = true
//                animateTopViewHeight()
//            }
//            else if scrollView.contentOffset.y <= .zero
//                        && headerConstrianett.constant <= .zero {
//
//                headerConstrianett.constant = viewHeight
//                headerView.isHidden = false
//                animateTopViewHeight()
//            }
//        }
//    }
//
//    private func animateTopViewHeight() {
//
//        // Lock the animation functionality
//        isAnimationInProgress = true
//
//        UIView.animate(withDuration: 0.2) {
//
//            self.view.layoutIfNeeded()
//
//        } completion: { [weak self] (_) in
//
//            // Unlock the animation functionality
//            self?.isAnimationInProgress = false
//        }
//    }
}

    
    
    
    


struct SecurityData {
    var secName : String
    var secNum : String
    var securotyID : String
    var secMarket : String
    var secStatus : String
    var secISIN : String
    
}


//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let currentScrollViewYOffset = scrollView.contentOffset.y
//
//        if currentScrollViewYOffset > previousScrollViewYOffset {
//            // scrolling down
//            if !headerViewIsHidden {
//
//                headerViewIsHidden = true
//                headerConstrianett.constant = 850
//
//
//                UIView.animate(withDuration: 0.2) {
//                    self.headerView.alpha = 0
//                }
//            }
//        } else {
//            // scrolling up
//            if headerViewIsHidden {
//                headerConstrianett.constant = 310
//
//                headerViewIsHidden = false
//                UIView.animate(withDuration: 0.2) {
//                    self.headerView.alpha = 1
//
//                }
//            }
//        }
//
//        previousScrollViewYOffset = currentScrollViewYOffset
//    }
