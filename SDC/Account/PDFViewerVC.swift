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
import PDFKit

class PDFViewerVC: UIViewController , WKNavigationDelegate,WKUIDelegate , PDFDocumentDelegate , URLSessionDelegate, UIDocumentInteractionControllerDelegate, UIDocumentPickerDelegate {
    
    
    @IBOutlet weak var pdfView: PDFView!
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
            
//            webView.load(URLRequest(url: urlString))

        }

        else if flag == 2 {
            
            
            
            mainTitle.text = "Investor Information".localized()
//            guard let urlString = URL(string:url ?? "") else {
//                return
//
//            }
//
//            webView.load(URLRequest(url: urlString))
            
           

            
        }
        
        else if flag == 3 {
            
            mainTitle.text = "Investor Ownership".localized()
            guard let urlString = URL(string:url ?? "") else {
                return
                
            }
//            webView.load(URLRequest(url: urlString))
        }

        
        else if flag == 4 {
            
            mainTitle.text = "Investor Accounts".localized()
            guard let urlString = URL(string:url ?? "") else {
                return
                
            }
//            webView.load(URLRequest(url: urlString))
        }
        
        else if flag == 5 {
            
            mainTitle.text = "Account Ownership".localized()
            guard let urlString = URL(string:url ?? "") else {
                return
                
            }
//            webView.load(URLRequest(url: urlString))
        }
        
        else if flag == 6 {
            
            mainTitle.text = "Account Information".localized()
            guard let urlString = URL(string:url ?? "") else {
                return
                
            }
//            webView.load(URLRequest(url: urlString))
        }
        
        
        DispatchQueue.global().async {
            // Perform time-consuming task here (e.g., loading a PDF document).
            
            // Example:
            if let url = URL(string: self.url ?? "") {
                if let pdfDocument = PDFDocument(url: url) {
                    DispatchQueue.main.async {
                        // Update the UI with the result on the main thread.
                        self.pdfView.document = pdfDocument
                        self.activityIndicator.stopAnimating()
                    }
                } else {
                    // Handle the case where PDF document creation failed.
                    DispatchQueue.main.async {
//                            self.showErrorMessage("Failed to load PDF.")
                        self.activityIndicator.stopAnimating()
                    }
                }
            } else {
                // Handle the case where the URL is not valid.
                DispatchQueue.main.async {
//                        self.showErrorMessage("Invalid PDF URL.")
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        
        
        
//
//        webView.navigationDelegate=self
//        webView.uiDelegate = self
        
//        hundle the web showing
//        webView.navigationDelegate = self
//        webView.uiDelegate = self
        
//        webView.configuration.preferences.javaScriptEnabled = true
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
    
//
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//            if let pickedURL = urls.first {
//                // Handle the picked URL, you can save it or perform other actions here
//                print("Picked document URL: \(pickedURL)")
//            }
//        }
//
//        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
//            // Handle cancellation if needed
//        }
    
//    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
//            return self
//        }
//
    func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//
//        activityIndicator.stopAnimating()
//        activityIndicator.isHidden = true
//    }

//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        activityIndicator.startAnimating()
//        activityIndicator.isHidden = false
//    }

//    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        showActivityIndicator(show: false)
//
//
//    }
//
        
    
    func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        
        guard let pdfURL = URL(string: url ?? "") else {
                return
            }

            let activityViewController = UIActivityViewController(activityItems: [pdfURL], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        
        
//        guard let pdfURL = URL(string: url ?? "") else {
//                return
//            }
//
//            // Create a document interaction controller
//            let documentInteractionController = UIDocumentInteractionController(url: pdfURL)
//            documentInteractionController.delegate = self
//
//            // Present the document interaction controller
//            documentInteractionController.presentOptionsMenu(from: self.view.bounds, in: self.view, animated: true)
        
        
        
//            guard let pdfURL = URL(string: url ?? "") else {
//                return
//            }
//
//            let documentPicker = UIDocumentPickerViewController(url: pdfURL, in: .exportToService)
//            documentPicker.delegate = self
//            present(documentPicker, animated: true, completion: nil)
//
            }
    
    
    
    

    @IBAction func downloadButtonTapped(_ sender: Any) {

            // Check if a valid PDF URL is available (you should have stored it when loading the PDF).
        
        if let url = URL(string: self.url ?? "" ) {
            let destinationDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let destinationURL = destinationDirectoryURL.appendingPathComponent("downloaded.pdf")
            
            if FileManager.default.fileExists(atPath: destinationURL.path) {
                // Rename the existing file to avoid conflicts.
                let timestamp = Int(Date().timeIntervalSince1970)
                let renamedURL = destinationDirectoryURL.appendingPathComponent("downloaded_\(timestamp).pdf")
                
                do {
                    try FileManager.default.moveItem(at: destinationURL, to: renamedURL)
                } catch {
                    // Handle the renaming error.
                    print("Error renaming file: \(error)")
                }
            }
            
            if let pdfDocument = PDFDocument(url: url) {
                DispatchQueue.main.async {
                    // Update the UI with the result on the main thread.
                    self.pdfView.document = pdfDocument
                    self.activityIndicator.stopAnimating()
                }
            } else {
                // Handle the case where PDF document creation failed.
                DispatchQueue.main.async {
                    self.showErrorHud(msg: "Failed to load PDF.")
                    self.activityIndicator.stopAnimating()
                }
            }
        } else {
            // Handle the case where the URL is not valid.
            DispatchQueue.main.async {
                self.showWarningHud(msg: "Invalid PDF URL.")
                self.activityIndicator.stopAnimating()
            }
        }
        
        }
    
    
    
    @IBAction func saveToFiles(_ sender: Any) {
        
        
        if let url = URL(string: self.url ?? "") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    // Handle the case where the URL cannot be opened
                    print("Unable to open URL: \(url)")
                }
            } else {
                // Handle the case where the URL is invalid
                print("Invalid URL: \(url)")
            }
    }
    
    
    

}
