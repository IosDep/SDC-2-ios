//
//  MenuVC.swift
//  Paradise
//
//  Created by Omar Warrayat on 07/03/2021.
//

import UIKit
import MOLH
import JGProgressHUD
import CDAlertView
import Alamofire
class MenuVC: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }
    

    var dismissComplition: (() -> Void)?
    var languageComplition: (() -> Void)?
    
    enum Actions: Int {
        case home = 0
        case accountInfo = 1
        case invownerShabe = 2
        case invAccounyt = 3
        case notification = 4
        case lang = 5
        case contactUs = 6
        case address = 7
        case onePageOwnerShape = 8
        case delete_my_account
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        

        
        

        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func openMenu(sender:UIButton){
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

         if sender.tag == Actions.home.rawValue {
            
             self.tabBarController?.selectedIndex =  0


         }else if sender.tag == Actions.accountInfo.rawValue {
             
             let vc = storyBoard.instantiateViewController(withIdentifier: "AccountInfoDetails") as! AccountInfoDetails
             vc.modalPresentationStyle = .fullScreen
       
             self.present(vc, animated: true)
             
         }
        
        else if sender.tag == Actions.invAccounyt.rawValue {
            
            let vc = storyBoard.instantiateViewController(withIdentifier: "AccountList") as! AccountList
            vc.modalPresentationStyle = .fullScreen
      
            self.present(vc, animated: true)
            
        }
        
        else if sender.tag == Actions.onePageOwnerShape.rawValue {
            
            let vc = storyBoard.instantiateViewController(withIdentifier: "OnePaperOwnerShape") as! OnePaperOwnerShape
            vc.modalPresentationStyle = .fullScreen
      
            self.present(vc, animated: true)
            
        }
        
        
    }
              
        
        
        
        
        
        
        
        
    
        
    }
