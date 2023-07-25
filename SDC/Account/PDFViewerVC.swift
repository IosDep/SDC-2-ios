//
//  PDFViewerVC.swift
//  SDC
//
//  Created by Razan Barq on 13/07/2023.
//

import UIKit
import WebKit
import JGProgressHUD
import Alamofire
import MOLH

class PDFViewerVC: UIViewController , WKNavigationDelegate,WKUIDelegate{
    
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var mainTitle: UILabel!
    
    var flag:Int?
    var url : String?
    
    
    var memberId:String?
    var securityId : String?
    var accountNo : String?
    var toDate : String?
    var fromDate : String?
    
    
    
    //refresh stuff
    let hud = JGProgressHUD(style: .light)
    
    
    var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    

       if flag == 1 {
           
            mainTitle.text = "Account Statement".localized()
            guard let urlString = URL(string: url ?? "") else {
                return
                
            }
            
            webView.load(URLRequest(url: urlString))

        }

        else if flag == 2 {
            
            mainTitle.text = "Investor Information".localized()
            guard let urlString = URL(string:url ?? "") else {
                return
                
            }
            
            webView.load(URLRequest(url: urlString))
        }
        
        else if flag == 3 {
            
            mainTitle.text = "Investor Ownership".localized()
            guard let urlString = URL(string:url ?? "") else {
                return
                
            }
            webView.load(URLRequest(url: urlString))
        }

        
        else if flag == 4 {
            
            mainTitle.text = "Investor Accounts".localized()
            guard let urlString = URL(string:url ?? "") else {
                return
                
            }
            webView.load(URLRequest(url: urlString))
        }
        
        else if flag == 5 {
            
            mainTitle.text = "Account Ownership".localized()
            guard let urlString = URL(string:url ?? "") else {
                return
                
            }
            webView.load(URLRequest(url: urlString))
        }
        
        else if flag == 6 {
            
            mainTitle.text = "Account Information".localized()
            guard let urlString = URL(string:url ?? "") else {
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
//        let preferences = WKPreferences()
//        preferences.javaScriptEnabled = true
//        let configuration = WKWebViewConfiguration()
//        configuration.preferences = preferences

        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.tintColor = .black
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
    
        
    
    func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }


}
