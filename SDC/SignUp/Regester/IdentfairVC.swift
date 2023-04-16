//
//  IdentfairVC.swift
//  SDC
//
//  Created by Blue Ray on 26/03/2023.
//

import UIKit

class IdentfairVC: UIViewController {
    @IBOutlet weak var idTxt: DesignableTextFeild!
    @IBOutlet weak var scroll: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }

    @IBAction func nextBtn(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

            
            let vc = storyBoard.instantiateViewController(withIdentifier: "DocumentType") as! DocumentType
            vc.modalPresentationStyle = .fullScreen
      
            self.present(vc, animated: true)
            
        
        
        
    }
}
