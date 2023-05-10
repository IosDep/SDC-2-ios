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
    
    var urlString: String? = "https://wavemrs.aci.org.jo/WaveMRS/onlineuserlogin.aspx"
    
    //refresh stuff
    let hud = JGProgressHUD(style: .light)
    
    
    
    var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        
        webView.navigationDelegate=self
        webView.uiDelegate = self
        
        //hundle the web showing
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
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
