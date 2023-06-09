//
//  SignUpVC.swift
//  SDC
//
//  Created by Blue Ray on 05/02/2023.
//

import UIKit
import StepIndicator
import TPKeyboardAvoidingSwift
//import StepIndicator
class SignUpVC: UIViewController {

    @IBOutlet weak var indecoterView: UIView!
    var stepIndicatorView =  StepIndicatorView()

    @IBOutlet weak var scroll: TPKeyboardAvoidingScrollView!
    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scroll.roundCorners([.topLeft, .bottomRight], radius: 10)
        
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }

}
extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }

}
