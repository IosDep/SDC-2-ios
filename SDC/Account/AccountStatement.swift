//
//  AccountStatement.swift
//  SDC
//
//  Created by Blue Ray on 15/04/2023.
//

import UIKit

class AccountStatement: UIViewController {

    @IBOutlet weak var bellView: UIView!
    @IBOutlet weak var membername: DesignableTextFeild!
    @IBOutlet weak var accountNumber: DesignableTextFeild!
    @IBOutlet weak var literalnumber: DesignableTextFeild!
    @IBOutlet weak var fromDate: DesignableTextFeild!
    @IBOutlet weak var toDate: DesignableTextFeild!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.cerateBellView(bellview: self.bellView, count: "12")
    }

    @IBAction func nextBtn(_ sender: Any) {
    }
}
