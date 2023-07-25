//
//  NotfictionVC.swift
//  SDC
//
//  Created by Blue Ray on 26/03/2023.
//

import UIKit
import Alamofire
import JGProgressHUD
import MOLH

class NotfictionVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var notficationTable:UITableView!
    @IBOutlet weak var mainView:UIView!
    
    var notifications = [NotificationModel]()
    var notificationCount : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        notficationTable.dataSource = self
        notficationTable.delegate = self
        getNotificationInfo()
        
        
        notficationTable.register(UINib(nibName: "NotficationXIB", bundle: nil), forCellReuseIdentifier: "NotficationXIB")
        
        
    }

    override func viewDidLayoutSubviews() {
     mainView.roundCorners([.topRight,.topLeft], radius: 18)

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count ?? 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.notficationTable.dequeueReusableCell(withIdentifier: "NotficationXIB", for: indexPath) as? NotficationXIB
      
        
        if cell == nil {
            let nib: [Any] = Bundle.main.loadNibNamed("NotficationXIB", owner: self, options: nil)!
            cell = nib[0] as? NotficationXIB
           
            
        }
        cell?.notificationTitle.text = notifications[indexPath.row].desc
        cell?.dateCreated.text = self.convertDate(dateString: notifications[indexPath.row].createdAt ?? "")
        
//        self.makeShadow(mainView: cell?.mainCardView)
//        self.makeShadow(mainView: cell!.contentView)
//        cell?.mainCardView.layer.cornerRadius = 10
//        cell?.mainCardView.clipsToBounds = true
//        cell?.mainCardView.layer.borderWidth = 0
//        cell?.mainCardView.layer.shadowColor = UIColor.black.cgColor
//        cell?.mainCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        cell?.mainCardView.layer.shadowRadius = 5
//        cell?.mainCardView.layer.shadowOpacity = 0.2
//        cell?.mainCardView.layer.masksToBounds = false
        
        
        return cell!
    }
    
    
    func getNotificationInfo(){
//
        let hud = JGProgressHUD(style: .light)
//        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)

        let param : [String:Any] = ["sessionId" : Helper.shared.getUserSeassion() ?? "","lang": MOLHLanguage.isRTLLanguage() ? "ar": "en"
 ]
     
        let link = URL(string: APIConfig.GetNotfication)

        AF.request(link!, method: .post, parameters: param,headers: NetworkService().requestHeaders()).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                   

                    if jsonObj != nil {
                        if let status = jsonObj!["status"] as? Int {
                            if status == 200 {
                                if let data = jsonObj!["notifications"] as? [[String: Any]]{
                                            for item in data {
                                                let model = NotificationModel(data: item)
                                                self.notifications.append(model)
                                 
                                            }
                                  
                                    
                                    
                                            
                                            DispatchQueue.main.async {
                                                
                                                self.notificationCount = String(self.notifications.count)
                                               
                                            self.notficationTable.reloadData()
                                                    
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
                            else {
                                hud.dismiss(animated: true)      }
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

//    override func viewDidAppear(_ animated: Bool) {
//        self.setupSideMenu()
//
//    }
    
    
    
//    func convertDate(dateString: String) -> String? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
//        
//        guard let date = dateFormatter.date(from: dateString) else {
//            return nil
//        }
//        
//        if MOLHLanguage.isRTLLanguage() {
//            let arabicLocale = Locale(identifier: "ar")
//            dateFormatter.locale = arabicLocale
//            dateFormatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
//            
//        }
//        
//        else {
//            let englishLocale = Locale(identifier: "en")
//            dateFormatter.locale = englishLocale
//            dateFormatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
//        }
//        
//        return dateFormatter.string(from: date)
//    }

}
