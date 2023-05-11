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
    @IBOutlet weak var bellView: UIView!

    @IBOutlet weak var tittle: UILabel!
    
    var flag:Int!
    
    
    // https://wavemrs.aci.org.jo/WaveMRS/onlineuserlogin.aspx
    
// http://sdc2.bluerayjo.com/ar/node/9149
    
    //refresh stuff
    let hud = JGProgressHUD(style: .light)
    
    
    
    var activityIndicator: UIActivityIndicatorView!
    
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate=self
        webView.uiDelegate = self
        
        //hundle the web showing
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        guard let urlString = URL(string:" http://sdc2.bluerayjo.com/ar/node/9149") else {
            return
        }
//        let preferences = WKPreferences()
//        preferences.javaScriptEnabled = true
//        let configuration = WKWebViewConfiguration()
//        configuration.preferences = preferences
        webView.configuration.preferences.javaScriptEnabled = true
        webView.load(URLRequest(url: urlString))
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        
        
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            // Fallback on earlier versions
        }
        activityIndicator.color = .red
        
        activityIndicator.isHidden = true
        
        view.addSubview(activityIndicator)
        
        self.cerateBellView(bellview: self.bellView, count: "12")
        
        
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
