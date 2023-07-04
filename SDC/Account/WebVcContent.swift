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
            
            guard let urlString = URL(string:"https://www.sdc.com.jo/eportfolio/img/ar_ePortfolio_User_Manual.pdf") else {
                return
                
            }
            
            webView.load(URLRequest(url: urlString))

            
           
        }

        else if flag == 1 {
            tittle.text = "Concept and instructions".localized()
            
            guard let urlString = URL(string:"https://www.sdc.com.jo/arabic/index.php?option=com_content&task=view&id=1818") else {
                return
                
            }
            
            webView.load(URLRequest(url: urlString))

        }

        else if flag == 2 {
            tittle.text = "Terms and conditions".localized()
            
            guard let urlString = URL(string:"https://www.sdc.com.jo/arabic/index.php?option=com_content&task=view&id=1794") else {
                return
                
            }
            
            webView.load(URLRequest(url: urlString))
        }

        else if flag == 3 {
            tittle.text = "Notice".localized()
            
            guard let urlString = URL(string:"https://sdc2.bluerayjo.com/ar/node/9149") else {
                return
                
            }
            
            webView.load(URLRequest(url: urlString))
            

        }
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
        activityIndicator.color = .red
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






    func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }


}
