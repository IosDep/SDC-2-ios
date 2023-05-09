//
//  AgrementVc.swift
//  SDC
//
//  Created by Blue Ray on 14/04/2023.
//

import UIKit

class AgrementVc: UIViewController {

    @IBOutlet weak var nameTxt: DesignableLabel!
    @IBOutlet weak var centerPhoneTxt: DesignableLabel!
    @IBOutlet weak var phoneNumberTxt: DesignableLabel!
    @IBOutlet weak var btnAgree: DesignableButton!
    @IBOutlet weak var emailTxt: DesignableLabel!
    
    var flagAgree = 1
    var accountDetails : AccountDetails?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
    }
    
    @IBAction func agree(_ sender: Any) {
        if flagAgree == 1 {
//            user Agree
            btnAgree.setImage(UIImage(systemName: ""), for: .normal)
            flagAgree = 2
            
        }else {
//            user DisAgree
            btnAgree.setImage(UIImage(systemName: ""), for: .normal)
            flagAgree = 1
        }
        
        
        
    }
    @IBAction func next(_ sender: Any) {
        
        if flagAgree == 1 {
//            user agere call Api
        }else {
//            user should agree
            
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

            
            let vc = storyBoard.instantiateViewController(withIdentifier: "PopUpOTP") as! PopUpOTP
            vc.modalPresentationStyle = .overCurrentContext
      
        self.present(vc, animated: true)
            
        
    }
    
    
    
}
