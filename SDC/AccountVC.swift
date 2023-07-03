//
//  AccountVC.swift
//  SDC
//
//  Created by Blue Ray on 19/03/2023.
//

import UIKit
import MOLH

class AccountVC: UIViewController {
    var bellCountView: BellCountView!

    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }
    
    
    @IBOutlet weak var scroll: UIScrollView!
    
    enum Actions: Int {
        case CHANGEPASSWROD = 0
        case CHANGELANG = 1
        case USERGUIDE = 2
        case Concept = 3
        case TERMSANDCONDETION = 4
        case NOTICE = 5
        case FINGERPOINT = 6
        case LOGOUT = 7

    }
//    @IBOutlet weak var bellview: UIView!
    
    
    @IBOutlet weak var scrollViewHolder: UIView!
    
    
    @IBOutlet weak var arrowImag1: UIImageView!
    @IBOutlet weak var arrowImag2: UIImageView!
    @IBOutlet weak var arrowImag3: UIImageView!
    @IBOutlet weak var arrowImag4: UIImageView!
    @IBOutlet weak var arrowImag5: UIImageView!
    @IBOutlet weak var arrowImag6: UIImageView!
    @IBOutlet weak var arrowImag7: UIImageView!
    @IBOutlet weak var arrowImag8: UIImageView!
    
    var imageViewWithCount: UIView!
      var countLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationText(title: "Account Settings".localized())

//        if MOLHLanguage.isArabic(){
//            self.arrowImag1.transform = CGAffineTransform(scaleX: -1, y: 1)
//            self.arrowImag2.transform = CGAffineTransform(scaleX: -1, y: 1)
//            self.arrowImag3.transform = CGAffineTransform(scaleX: -1, y: 1)
//            self.arrowImag4.transform = CGAffineTransform(scaleX: -1, y: 1)
//            self.arrowImag5.transform = CGAffineTransform(scaleX: -1, y: 1)
//            self.arrowImag6.transform = CGAffineTransform(scaleX: -1, y: 1)
//            self.arrowImag7.transform = CGAffineTransform(scaleX: -1, y: 1)
//            self.arrowImag8.transform = CGAffineTransform(scaleX: -1, y: 1)
//
//        }
//
        
//        self.cerateBellView(bellview: self.bellview, count: "10")
        
        
    }
    
    override func viewDidLayoutSubviews() {
        scroll.roundCorners([.topLeft, .topRight], radius: 20)
    }


//    Action
    @IBAction func Aaction(btn:UIButton){
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

        if btn.tag == Actions.CHANGEPASSWROD.rawValue {
            
            let vc = storyBoard.instantiateViewController(withIdentifier: "ForgetPassword") as! ForgetPassword
            vc.modalPresentationStyle = .fullScreen
      
            self.present(vc, animated: true)
            
            
        }
        else  if btn.tag == Actions.CHANGELANG.rawValue {
            
            let vc = storyBoard.instantiateViewController(withIdentifier: "ChangeLanguage") as! ChangeLanguage
            vc.modalPresentationStyle = .fullScreen
      
            self.present(vc, animated: true)
            
        }
        else  if btn.tag == Actions.USERGUIDE.rawValue {
            
        }
        else  if btn.tag == Actions.Concept.rawValue {
            
        }
        else  if btn.tag == Actions.TERMSANDCONDETION.rawValue {
            
        }
     
        else  if btn.tag == Actions.NOTICE.rawValue {
            let vc = storyBoard.instantiateViewController(withIdentifier: "WebVcContent") as! WebVcContent
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
    
        }
        else  if btn.tag == Actions.FINGERPOINT.rawValue {
            
        }
        
        
        
        else  if btn.tag == Actions.LOGOUT.rawValue {
            let vc = storyBoard.instantiateViewController(withIdentifier: "WelcomePageVC") as! WelcomePageVC
            vc.modalPresentationStyle = .fullScreen
      
            self.present(vc, animated: true)
            
        }
        
        
        
    }


    


}



