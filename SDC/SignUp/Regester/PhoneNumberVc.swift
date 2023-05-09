//
//  PhoneNumberVc.swift
//  SDC
//
//  Created by Blue Ray on 26/03/2023.
//

import UIKit

class PhoneNumberVc: UIViewController {
    @IBOutlet weak var phoneTxt: DesignableTextFeild!

    @IBOutlet weak var scroll: UIScrollView!
    
    var accountDetails : AccountDetails?

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }
    @IBAction func nextBtn(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

            
            let vc = storyBoard.instantiateViewController(withIdentifier: "EmailVc") as! EmailVc
            vc.modalPresentationStyle = .fullScreen
      
            self.present(vc, animated: true)
            
        
        
        
    }
    

}
