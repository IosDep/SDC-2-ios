//
//  DocumentType.swift
//  SDC
//
//  Created by Blue Ray on 26/03/2023.
//

import UIKit

class DocumentType: UIViewController {

    @IBOutlet weak var DocumentType: DesignableTextFeild!
    
    @IBOutlet weak var DocumentNumber : DesignableTextFeild!
    
    @IBOutlet weak var DocumentStartDate: DesignableTextFeild!
    
    @IBOutlet weak var DocumentendDate: DesignableTextFeild!
    
    
    @IBOutlet weak var famileyNoteNumber: DesignableTextFeild!
    
    var accountDetails : AccountDetails?

    
    @IBOutlet weak var scroll: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }
    @IBAction func nextBtn(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

            
            let vc = storyBoard.instantiateViewController(withIdentifier: "PhoneNumberVc") as! PhoneNumberVc
        vc.accountDetails = AccountDetails(name: "" , phoneNum: "", email: "")
            vc.modalPresentationStyle = .fullScreen
      
            self.present(vc, animated: true)
            
        
        
        
    }
    

}
