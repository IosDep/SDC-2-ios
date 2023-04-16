//
//  PopUpOTP.swift
//  SDC
//
//  Created by Blue Ray on 14/04/2023.
//

import UIKit

class PopUpOTP: UIViewController {

    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var otpTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    


    @IBAction func Next(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

            
            let vc = storyBoard.instantiateViewController(withIdentifier: "PopUpAccountCreated") as! PopUpAccountCreated
            vc.modalPresentationStyle = .overCurrentContext
      
        self.present(vc, animated: true,completion: {self.dismiss(animated: true)})

        
    }
    
}
