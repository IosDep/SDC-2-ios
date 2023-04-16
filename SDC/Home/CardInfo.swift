//
//  CardInfo.swift
//  SDC
//
//  Created by Blue Ray on 27/03/2023.
//

import UIKit

class CardInfo: UIViewController {

    @IBOutlet weak var mainVIew: UIView!
    @IBOutlet weak var bellView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cerateBellView(bellview: self.bellView, count: "12")
        mainVIew.roundCorner(corners: [.topLeft,.topRight], radius: 17)
    }
    


//    override func viewDidAppear(_ animated: Bool) {
//        self.setupSideMenu()
//
//    }
}
