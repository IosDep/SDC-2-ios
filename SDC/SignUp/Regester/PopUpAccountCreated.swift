//
//  PopUpAccountCreated.swift
//  SDC
//
//  Created by Blue Ray on 14/04/2023.
//

import UIKit

class PopUpAccountCreated: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func AccountCreated(_ sender: Any) {
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

            
            let vc = storyBoard.instantiateViewController(withIdentifier: "WelcomePageVC") as! WelcomePageVC
            vc.modalPresentationStyle = .fullScreen
      
            self.present(vc, animated: true)
            
        
    }
    
}
