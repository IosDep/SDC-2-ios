//
//  Extensions.swift
//  Paradise
//
//  Created by Omar Warrayat on 28/12/2020.
//

import Foundation
import UIKit
import JGProgressHUD
import Alamofire
import MOLH
import Loaf
import SideMenu
import CDAlertView
extension UIViewController {
    
    func image(fromLayer layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)
        
        layer.render(in: UIGraphicsGetCurrentContext()!)

        let outputImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return outputImage!
    }
    func makeShadow(mainView:UIView){
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOpacity = 0.5
        mainView.layer.shadowOffset = CGSize(width: 2, height: 2)
        mainView.layer.shadowRadius = 5
        mainView.layer.cornerRadius = 10
    }
    func cerateBellView(bellview:UIView,count:String){
        var imageViewWithCount: UIView!
        var countLabel: UILabel!



        // Create the image view
        let imageView = UIImageView(image: UIImage(named: "bells"))
        imageView.contentMode = .center
        countLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        countLabel.textColor = .green
        countLabel.font = UIFont.boldSystemFont(ofSize: 10)
        countLabel.textAlignment = .center
        countLabel.backgroundColor = .white
        countLabel.layer.cornerRadius = 9
        countLabel.clipsToBounds = true
        countLabel.text = count

        imageViewWithCount = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageViewWithCount.addSubview(imageView)
        imageViewWithCount.addSubview(countLabel)

        imageViewWithCount.center = CGPoint(x: bellview.frame.size.width/2, y: bellview.frame.size.height/2)
        let myButton = UIButton()
        myButton.setTitle(" ".localized(), for: .normal)
        myButton.setTitleColor(.blue, for: .normal)
        myButton.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        self.view.addSubview(myButton)

        myButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

       

        bellview.addSubview(imageViewWithCount)
        bellview.addSubview(myButton)



    }
    
    func seassionExpired(msg:String){
        let alert = CDAlertView(title: "Expired".localized(), message:  msg, type: .error)
        
        let action = CDAlertViewAction(title: "Cancel".localized(), font: UIFont.systemFont(ofSize: 17), textColor: UIColor.red, backgroundColor: UIColor.white, handler: { action in
            
//            rest cash token cause it is expired
            Helper.shared.saveToken(auth: "")
            Helper.shared.saveUserId(id: 0)
            Helper.shared.SaveSeassionId(seassionId: "")

                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                               appDelegate.notLogin()
                return true
            })


            alert.add(action: action)
        
        alert.show()
            

        
        
        
    }
    @objc func buttonAction(sender:UIButton){
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "NotfictionVC") as! NotfictionVC
        vc.modalPresentationStyle = .fullScreen
  
        self.present(vc, animated: true)
    }
    func addGradientForBtn(btn: UIButton, sizeForBtn: Int, height: Int) {
        btn.clipsToBounds = true
        
        let color1 = UIColor(red: 0/255, green: 128/255, blue: 0/255, alpha: 1)
        let color2 = UIColor(red: 0/255, green: 128/255, blue: 0/255, alpha: 1)
        
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.frame.size = btn.frame.size
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width - CGFloat(sizeForBtn), height: CGFloat(height))
        
        btn.layer.insertSublayer(gradient, at: 0)
    }
    
    func navColor() {
        let color = UIColor(red: 76/255, green: 193/255, blue: 139/255, alpha: 0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = color
            appearance.titleTextAttributes = [.font:
            UIFont.boldSystemFont(ofSize: 20.0),
                                          .foregroundColor: UIColor.white]

            // Customizing our navigation bar
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            
        } else {
            navigationController?.navigationBar.tintColor = .white
            //navigationController?.navigationBar.barTintColor = .white
            navigationController?.navigationBar.backgroundColor = color
            navigationController?.navigationBar.titleTextAttributes = [.font:
            UIFont.boldSystemFont(ofSize: 20.0),
                                          .foregroundColor: UIColor.white]
        }
    }
    
    func side_menu() {
        self.setupSideMenu()
        if MOLHLanguage.isRTLLanguage() {
            present(SideMenuManager.default.rightMenuNavigationController!, animated: true, completion: nil)

        } else {
            present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)


        }
        
    }
    func navColorWhite() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.titleTextAttributes = [.font:
            UIFont.boldSystemFont(ofSize: 20.0),
                                          .foregroundColor: UIColor.black]

            // Customizing our navigation bar
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            
        } else {
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.backgroundColor = .white
            navigationController?.navigationBar.titleTextAttributes = [.font:
            UIFont.boldSystemFont(ofSize: 20.0),
                                          .foregroundColor: UIColor.black]
        }
    }
    
    func showMustLoginHud() {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Please login first".localized()
        hud.indicatorView = JGProgressHUDErrorIndicatorView()
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 1.5, animated: true, completion: {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.notLogin()
        })
    }
    
    func showErrorHud(msg: String) {
//        let hud = JGProgressHUD(style: .light)
//        hud.textLabel.text = msg
//        hud.indicatorView = JGProgressHUDErrorIndicatorView()
//        hud.show(in: self.view)
//        hud.dismiss(afterDelay: 1.5)
//
        Loaf(msg, state: .error,location: .top, sender: self).show()

    }
    
    
    
    func showSuccessHud(msg: String) {
//        let hud = JGProgressHUD(style: .light)
//        hud.textLabel.text = msg
//        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
//        hud.show(in: self.view)
//        hud.dismiss(afterDelay: 1.5)
//        hud.dismiss(afterDelay: 1.5)

        Loaf(msg, state: .success,location: .top, sender: self).show()
    }
    func showErrorHud(msg: String, hud: JGProgressHUD) {
//        hud.indicatorView = JGProgressHUDErrorIndicatorView()
//        hud.textLabel.text = msg
//        hud.dismiss(afterDelay: 1.5)
        hud.dismiss(afterDelay: 1.5)

        Loaf(msg, state: .error,location: .top, sender: self).show()

        
    }
    @IBAction func notfication(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "NotfictionVC") as! NotfictionVC
        vc.modalPresentationStyle = .fullScreen
  
        self.present(vc, animated: true)
        
        
        
    }
    func getTopMostViewController() -> UIViewController? {
        var topMostViewController = UIApplication.shared.keyWindow?.rootViewController
        while let presentedViewController = topMostViewController?.presentedViewController {
            topMostViewController = presentedViewController
        }
        return topMostViewController
    }
    
    @IBAction func dismiss(_ sender: Any) {self.dismiss(animated: true)}
    @IBAction func setupMenu(_ sender: Any) {self.side_menu()}

    
    
    func showSuccessHud(msg: String, hud: JGProgressHUD) {
//        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
//        hud.textLabel.text = msg
//        hud.dismiss(afterDelay: 1.5)
        hud.dismiss(afterDelay: 1.5)

        Loaf(msg, state: .success,location: .top, sender: self).show()
    }
    
    func showSuccessHudAndOut(msg: String, hud: JGProgressHUD) {
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.textLabel.text = msg
        Loaf(msg, state: .success,location: .top, sender: self).show()
        hud.dismiss(afterDelay: 1.5, animated: true, completion: {
            self.navigationController?.popViewController(animated: true)
        })
    }
    func setupSideMenu() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let menuController = storyBoard.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
  
        let MenuNavigationController = SideMenuNavigationController(rootViewController: menuController)
        SideMenuManager.default.rightMenuNavigationController = nil
        SideMenuManager.default.leftMenuNavigationController = nil
        if MOLHLanguage.isRTLLanguage() {

            
            SideMenuManager.default.rightMenuNavigationController = MenuNavigationController

        } else {
            SideMenuManager.default.leftMenuNavigationController = MenuNavigationController
 

        }
        
//        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
//        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: navigationController!.navigationBar)
    }
    
    func internetError(hud: JGProgressHUD) {
        hud.indicatorView = JGProgressHUDErrorIndicatorView()
        hud.textLabel.text = "Please check internet connection".localized()
        hud.dismiss(afterDelay: 1.5)
    }
    
    func serverError(hud: JGProgressHUD) {
        hud.indicatorView = JGProgressHUDErrorIndicatorView()
        hud.textLabel.text = "Server Error".localized()
        hud.dismiss(afterDelay: 1.5)
    }
    
    func navigationText(title: String) {
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.title = title
    }
    
    
    func setupNavBar(title:String){
        var imageViewWithCount: UIView!
          var countLabel: UILabel!
        
        
        self.navColor()
        // Create the image view
          let imageView = UIImageView(image: UIImage(named: "bells"))
        imageView.contentMode = .center
        self.view.backgroundColor = .white
          
          // Create the count label
          countLabel = UILabel(frame: CGRect(x: 15, y: -5, width: 20, height: 20))
          countLabel.textColor = .white
          countLabel.font = UIFont.boldSystemFont(ofSize: 12)
          countLabel.textAlignment = .center
          countLabel.backgroundColor = .red
          countLabel.layer.cornerRadius = 10
          countLabel.clipsToBounds = true
          countLabel.text = "0"
        
          // Create the container view that combines the image view and count label
          imageViewWithCount = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
          imageViewWithCount.addSubview(imageView)
          imageViewWithCount.addSubview(countLabel)
        let menu = UIBarButtonItem(image: UIImage(named:  "menus"), style: .plain, target: self, action: #selector(sideMenu))

          // Add the container view to the navigation bar as a custom UIBarButtonItem
          let imageBarButton = UIBarButtonItem(customView: imageViewWithCount)
          
        
        navigationItem.rightBarButtonItems = [imageBarButton, menu]
        

    }
    
    
    @objc func bell() {
        // Handle home button tap
    }

    @objc func sideMenu() {
        // Handle message button tap
    }

   
//
//    func addToFavourite(item: ItemsModel, completionHandler: @escaping ((Bool) -> Void)) {
//        let defaults = UserDefaults.standard
//        let id = defaults.value(forKey: "id") as? String
//        print("idsss")
//        print(id)
//        if id == nil {
//            let hud = JGProgressHUD(style: .light)
//            hud.indicatorView = JGProgressHUDErrorIndicatorView()
//            hud.textLabel.text = "Please login first".localized()
//            hud.show(in: self.view)
//            hud.dismiss(afterDelay: 1.5, animated: true, completion: {
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.notLogin()
//            })
//
//        } else {
//            let hud = JGProgressHUD(style: .light)
//            hud.textLabel.text = "Please Wait".localized()
//            hud.show(in: self.view)
//
//            let favouriteUrl = URL(string: ServerConstants.BASE_URL + ServerConstants.App_Ext + ServerConstants.ADDFAVOURITE_URL)
//
//            let favouriteParam: [String: Any] = [
//                "uid":id!,
//                "product_id":"\(item.pid!)"
//                ,
//                "lang": MOLHLanguage.isRTLLanguage() ? "ar": "en"
//            ]
//
//            print("favouriteParam")
//            print(favouriteParam)
//            AF.request(favouriteUrl!, method: .post, parameters: favouriteParam).response { (response) in
//                if response.error == nil {
//                    do {
//                        let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
//
//                        if let msg = jsonObj!["msg"] as? [String: Any] {
//                             let status = msg["status"] as? Int
//
//                                if status == 1 {
//
//                                    if let message = msg["message"] as? String {
//                                        DispatchQueue.main.async {
//                                            self.showSuccessHud(msg: message, hud: hud)
//                                            completionHandler(true)
//
//                                        }
//
//                                    }
//
//                                } else {
//                                    if let message = msg["message"] as? String {
//                                        DispatchQueue.main.async {
//                                            self.showErrorHud(msg: message, hud: hud)
//                                            completionHandler(false)
//
//                                        }
//                                    }
//
//                            }
//                        }
//
//                    } catch let err as NSError {
//                        print("Error: \(err)")
//                        self.serverError(hud: hud)
//                    }
//                } else {
//                    print("Error")
//                    self.internetError(hud: hud)
//                }
//            }
//        }
//    }
//


//    func addToCart(itemId: Int, quantity: String,price:Int, completionHandler: @escaping ((Bool) -> Void)) {
//        let hud = JGProgressHUD(style: .light)
//        hud.textLabel.text = "Please Wait".localized()
//        hud.show(in: self.view)
//
//        let defaults = UserDefaults.standard
//        let id = defaults.value(forKey: "id") as? Int
//
//        var addToCartUrl: URL?
//        var addToCartParam: [String: Any]?
//
//
//            addToCartUrl = URL(string: ServerConstants.BASE_URL + ServerConstants.ADDTOCART_URL)
//            addToCartParam = [
//                "uid": String(id!),
//                "vid": String(itemId),
//                "quantity": quantity,
//                "price": price,
//
//                "lang": MOLHLanguage.isRTLLanguage() ? "ar": "en"
//            ]
//
//
//
//        AF.request(addToCartUrl!, method: .post, parameters: addToCartParam).response { (response) in
//            if response.error == nil {
//                do {
//                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
//
//                    if jsonObj != nil {
//                        if let msg = jsonObj!["msg"] as? [String :Any] {
//                            if let status = msg["status"] as? Int{
//
//
//
//                                if status == 1 {
//                            if let message = msg["message"] as? String{
//                                self.showSuccessHud(msg: message)
//
//                            }
//                                }else {
//                                    if let message = msg["message"] as? String{
//                                        self.showSuccessHud(msg: message)
//
//                                    self.showErrorHud(msg: message)
//                                    }
//                                }
//
//
//                            }
//
//                        }
//                    }
//
//                } catch let err as NSError {
//                    print("Error: \(err)")
//                    self.serverError(hud: hud)
//                }
//            } else {
//                print("Error")
//                self.internetError(hud: hud)
//            }
//        }
//    }
    
 
 
//    func addToCart(itemId: String, quantity: String,price:Double, completionHandler: @escaping ((Bool) -> Void)) {
//        let hud = JGProgressHUD(style: .light)
//        hud.textLabel.text = "Please Wait".localized()
//        hud.show(in: self.view)
//
//        let defaults = UserDefaults.standard
//        let id = defaults.value(forKey: "id") as? String
//
//
//
//        var addToCartUrl = URL(string: ServerConstants.BASE_URL + ServerConstants.App_Ext + ServerConstants.ADDTOCART_URL)
//
//        let addToCartParam: [String: Any] = [
//            "uid": id ?? "0",
//            "vid": String(itemId),
//            "quantity": quantity,
//            "price" :price,
//            "lang": MOLHLanguage.isRTLLanguage() ? "ar": "en"
//        ]
//
//
//        print("CartParam")
//        print(addToCartParam)
//        print(addToCartUrl)
//
//        AF.request(addToCartUrl!, method: .post, parameters: addToCartParam).response { (response) in
//            if response.error == nil {
//                do {
//                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
//
//                    if jsonObj != nil {
//                        if let msg = jsonObj!["msg"] as? [String:Any] {
//
//                            let status = msg["status"] as? Int
//
//                            if status == 1 {
//                                if let message = msg["message"] as? String {
//                                    DispatchQueue.main.async {
//                                        completionHandler(true)
//                                        self.showSuccessHud(msg: message, hud: hud)
//                                    }
//                                }
//                            }else {
//                                if let message = msg["message"] as? String {
//                                    DispatchQueue.main.async {
//                                        completionHandler(false)
//                                        self.showErrorHud(msg: message, hud: hud)
//                                    }
//                                }
//
//                            }
//
//                        }
//
//                    }
//
//
//                } catch let err as NSError {
//                    print("Error: \(err)")
//                    self.serverError(hud: hud)
//                }
//            } else {
//                print("Error")
//                self.internetError(hud: hud)
//            }
//        }
//    }
//

}

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: self, comment: "")
    }
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

extension UIView {
    func addBorders(borderWidth: CGFloat = 0.5, borderColor: CGColor ){
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
    }
    
    func addShadowToView(shadowRadius: CGFloat = 2) {
        self.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.layer.shadowOffset = CGSize(width: -1, height: 2)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 0.3
    }
 
    func roundCorner(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
func animateViewHeight (controller:UIViewController
                        ,height:CGFloat
                        ,heightConstraint:NSLayoutConstraint) {
        UIView.animate(withDuration: 0.5, animations: {
             heightConstraint.constant=height
            controller.view.layoutIfNeeded()
        })
    }

    
        @IBInspectable var topLeftRounded: Bool {
            get {
                return layer.maskedCorners == [.layerMinXMinYCorner]
            }
            set {
                if newValue {
                    layer.cornerRadius = 16
                    layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                } else {
                    layer.cornerRadius = 0
                    layer.maskedCorners = []
                }
            }
        }
    

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}




@IBDesignable
extension UIView {
    @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue?.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
    }

    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }

    @IBInspectable var shadowOffset: CGSize {
        set {
            layer.shadowOffset = newValue
        }
        get {
            return layer.shadowOffset
        }
    }

    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    
    
    
}
