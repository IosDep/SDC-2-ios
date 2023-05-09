//
//  EmailVc.swift
//  SDC
//
//  Created by Blue Ray on 26/03/2023.
//

import UIKit

class EmailVc: UIViewController {
    @IBOutlet weak var emailTxt: DesignableTextFeild!

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

            
            let vc = storyBoard.instantiateViewController(withIdentifier: "AgrementVc") as! AgrementVc
            vc.modalPresentationStyle = .fullScreen
      
            self.present(vc, animated: true)
            
        
        
        
    }
    
}
