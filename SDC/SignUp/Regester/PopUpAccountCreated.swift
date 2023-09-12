//
//  PopUpAccountCreated.swift
//  SDC
//
//  Created by Blue Ray on 14/04/2023.
//

import UIKit

class PopUpAccountCreated: UIViewController {

    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if touch?.view == self.mainView{
            
        }else {
            self.dismiss(animated: true,completion: {
                print("Done WIth  2 second ")
            })
        }
    }
    
    
    


    @IBAction func AccountCreated(_ sender: Any) {
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

            
            let vc = storyBoard.instantiateViewController(withIdentifier: "WelcomePageVC") as! WelcomePageVC
            vc.modalPresentationStyle = .fullScreen
      
            self.present(vc, animated: true)
            
        
    }
    
}
