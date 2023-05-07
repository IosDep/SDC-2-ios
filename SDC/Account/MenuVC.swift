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
    
    @IBOutlet weak var invOwnershipBtn: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }
    

    var dismissComplition: (() -> Void)?
    var languageComplition: (() -> Void)?
    
    enum Actions: Int {
        case home = 0
        case invInfo = 1
        case invownerShabe = 2
        case invAccount = 3
        case companyProcedure = 4
        case invOwnershipOf = 5
        case accountSetting = 6
        case accountStatement = 7
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        invOwnershipBtn.titleLabel?.font = .systemFont(ofSize: 5)

        invOwnershipBtn.clipsToBounds = true
        

        
        
        
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

         }
             else if sender.tag == Actions.invInfo.rawValue {

             let vc = storyBoard.instantiateViewController(withIdentifier: "CardFiveVC") as! CardFiveVC
             vc.modalPresentationStyle = .fullScreen

             self.present(vc, animated: true)

         }

        else if sender.tag == Actions.invownerShabe.rawValue {

            let vc = storyBoard.instantiateViewController(withIdentifier: "InvestorOwnershipVC") as! InvestorOwnershipVC
            vc.modalPresentationStyle = .fullScreen

            self.present(vc, animated: true)

        }

        else if sender.tag == Actions.invAccount.rawValue {

            let vc = storyBoard.instantiateViewController(withIdentifier: "AccountList") as! AccountList
            vc.modalPresentationStyle = .fullScreen

            self.present(vc, animated: true)

        }

        else if sender.tag == Actions.invOwnershipOf.rawValue {

            let vc = storyBoard.instantiateViewController(withIdentifier: "OnePaperOwnerShape") as! OnePaperOwnerShape
            vc.modalPresentationStyle = .fullScreen

            self.present(vc, animated: true)

        }
    

        
        else if sender.tag == Actions.accountSetting.rawValue {

            let vc = storyBoard.instantiateViewController(withIdentifier: "AccountVC") as! AccountVC
            vc.modalPresentationStyle = .fullScreen

            self.present(vc, animated: true)

        }
        
        else if sender.tag == Actions.accountStatement.rawValue {

            let vc = storyBoard.instantiateViewController(withIdentifier: "AccountStatement") as! AccountStatement
            vc.modalPresentationStyle = .fullScreen

            self.present(vc, animated: true)

        }
        
        
        
    }
              
        
        
        
        
        
        
        
        
    
        
    }
