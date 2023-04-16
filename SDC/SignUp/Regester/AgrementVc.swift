//
//  AgrementVc.swift
//  SDC
//
//  Created by Blue Ray on 14/04/2023.
//

import UIKit

class AgrementVc: UIViewController {

    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var centerPhoneTxt: UILabel!
    @IBOutlet weak var phoneNumberTxt: UILabel!
    @IBOutlet weak var btnAgree: UIButton!
    @IBOutlet weak var emailTxt: UILabel!
var flagAgree = 1
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
