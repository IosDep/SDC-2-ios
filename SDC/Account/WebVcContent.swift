//
//  WebVcContent.swift
//  SDC
//
//  Created by Blue Ray on 08/04/2023.
//

import UIKit
import WebKit
import Alamofire
import JGProgressHUD
import MOLH


class WebVcContent: UIViewController , WKNavigationDelegate,WKUIDelegate{
    
    //
    //  ServcesVC.swift
    //  ASI
    //
    //  Created by Omar Warrayat on 15/01/2022.
    //
    
    @IBOutlet weak var webView: WKWebView!

    @IBOutlet weak var tittle: UILabel!
    
    var flag:Int!
    
    
    //refresh stuff
    let hud = JGProgressHUD(style: .light)
    
    
    var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if flag == 0 {
            tittle.text = "User Guide".localized()
            
            
//            guard let urlString = URL(string:"https://www.sdc.com.jo/eportfolio/img/ar_ePortfolio_User_Manual.pdf") else {
//                return
//
//            }
//
//
//            guard let arabicUrlString = URL(string:"https://www.sdc.com.jo/eportfolio/img/ar_ePortfolio_User_Manual.pdf") else {
//                return
//
//            }
//
//
//            MOLHLanguage.isRTLLanguage() ?             webView.load(URLRequest(url: urlString)) :             webView.load(URLRequest(url: arabicUrlString))
//
//
//
//
//
//
//
        }

        else if flag == 1 {
            tittle.text = "Concept and instructions".localized()
            
//            guard let urlString = URL(string:"https://www.sdc.com.jo/arabic/index.php?option=com_content&task=view&id=1818") else {
//                return
//
//            }
//
//            webView.load(URLRequest(url: urlString))

        }

        else if flag == 2 {
//            tittle.text = "Terms and conditions".localized()
//
//
//            guard let urlString = URL(string:"https://www.sdc.com.jo/arabic/index.php?option=com_content&task=view&id=1794") else {
//                return
//
//            }
//
//            webView.load(URLRequest(url: urlString))
        }

        else if flag == 3 {
//            tittle.text = "Notice".localized()
//
//            guard let urlString = URL(string:"https://sdc2.bluerayjo.com/ar/node/9149") else {
//                return
//
//            }
//
//            webView.load(URLRequest(url: urlString))
            

        }
        
        self.getLinks()
//
        webView.navigationDelegate=self
        webView.uiDelegate = self
        
//        hundle the web showing
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        webView.configuration.preferences.javaScriptEnabled = true
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences

        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true


        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
//             Fallback on earlier versions
        }
        activityIndicator.color = .darkGray
        activityIndicator.isHidden = true

        view.addSubview(activityIndicator)
        
        
        
        if #available(iOS 13, *) {

            self.navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor.clear

            self.navigationController?.navigationBar.standardAppearance.backgroundEffect = nil
            self.navigationController?.navigationBar.standardAppearance.shadowImage = UIImage()

            self.navigationController?.navigationBar.standardAppearance.shadowColor = .clear
            self.navigationController?.navigationBar.standardAppearance.backgroundImage = UIImage()
        }

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)


    }
    func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showActivityIndicator(show: false)


    }

    
    func getLinks(){
        
        
        let link = URL(string: APIConfig.GetLInks)
        
        
        AF.request(link!, method: .post , parameters: [:] , headers: nil ).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    
                    if jsonObj != nil {
                        
                        if let success = jsonObj!["success"] as? Bool {
                            if success == true {
                                
                                
                                if  let account_seetings  = jsonObj!["account_seetings"] as? [String : Any] {
                                  
                                    let id  = account_seetings["id"] as? Int
                                    
                                     let terms_and_conditions_en  = account_seetings["terms_and_conditions_en"] as? String
                                    
                                    guard let termsEn = URL(string: terms_and_conditions_en ?? "") else {
                                        return
                                    }
                                    
                                     let terms_and_conditions_ar  = account_seetings["terms_and_conditions_ar"] as? String
                                    
                                    guard let termsAR = URL(string: terms_and_conditions_ar ?? "") else {
                                        return
                                    }
                                    
                                   let notic_en  = account_seetings["notic_en"] as? String
                                        
                                    guard let noticeEn = URL(string: notic_en ?? "") else {
                                        return
                                    }
                                    
                                let notic_ar  = account_seetings["notic_ar"] as? String
                                    
                                    guard let noticeAr = URL(string: notic_ar ?? "") else {
                                        return
                                    }
                                    
                                    
                                let users_guide_en  = account_seetings["users_guide_en"] as? String
                                    
                                guard let userEn = URL(string: users_guide_en ?? "") else {
                                        return
                                    }
                                    
                                    
                                  let users_guide_ar  = account_seetings["users_guide_ar"] as? String
                                    
                                    guard let userAr = URL(string: users_guide_ar ?? "") else {
                                        return
                                    }
                                    
                                   
                                    
                                  let concept_and_instructions_en  = account_seetings["concept_and_instructions_en"] as? String
                                    
                                    guard let conceptEn = URL(string: concept_and_instructions_en ?? "") else {
                                        return
                                    }
                                    
                                     let concept_and_instructions_ar  = account_seetings["concept_and_instructions_ar"] as? String
                                    
                                    guard let conceptAr = URL(string: concept_and_instructions_ar ?? "") else {
                                         return
                                     }
                                    
                                    
                                    DispatchQueue.main.async {

                    switch self.flag {
                    case 0:
        MOLHLanguage.isRTLLanguage() ? self.webView.load(URLRequest(url: userAr)) : self.webView.load(URLRequest(url: userEn))
                                            
                    case 1:
       MOLHLanguage.isRTLLanguage() ? self.webView.load(URLRequest(url: conceptAr)) : self.webView.load(URLRequest(url: conceptEn))
                    case 2:
        MOLHLanguage.isRTLLanguage() ? self.webView.load(URLRequest(url: termsAR)) : self.webView.load(URLRequest(url: termsEn))
                
                    case 3:
        MOLHLanguage.isRTLLanguage() ? self.webView.load(URLRequest(url: noticeAr)) : self.webView.load(URLRequest(url: noticeEn))
            
                                            
                                        default:
                                            print("default")
                                        }

                                    }
                                    
                                  
                                }
                                
                               
                                
                                
                            }
                            
                            
                        }
                    }
                    
                    else {
                        print("erorrr")
                    }
                    
                } catch let err as NSError {
                    print("Error: \(err)")
                    
                    
                }
            } else {
                print("Error")
                
                
            }
        }
        
    }





    func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    
    // https://sdce5.blueraydev.com/api/investor_information/getAccountSettings
    
    
    


}
