//
//  CardTwoVc.swift
//  SDC
//
//  Created by Blue Ray on 14/04/2023.
//

import UIKit

class CardTwoVc: UIViewController {

    @IBOutlet weak var bellView : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.cerateBellView(bellview: bellView, count: "12")
        
    }
    
    


}
