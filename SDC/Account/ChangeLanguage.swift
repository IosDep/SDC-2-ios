//
//  ChangeLanguage.swift
//  SDC
//  Created by Blue Ray on 09/04/2023.


import UIKit
import MOLH
class ChangeLanguage: UIViewController {
    @IBOutlet weak var bellView: UIView!
    
    @IBOutlet weak var majoreView: UIView!
    
    
    @IBOutlet weak var enimaeg: UIImageView!
    @IBOutlet weak var arimage: UIImageView!
//
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cerateBellView(bellview: bellView, count: "12")
        
        majoreView.roundCorners([.topLeft,.topRight], radius: 12)
        
        
        if MOLHLanguage.isArabic() {
            arimage.image = UIImage(systemName: "circle.fill")?.withTintColor(UIColor.black)
            enimaeg.image = UIImage(systemName: "circle")?.withTintColor(UIColor.black)

        }else {
            enimaeg.image = UIImage(systemName: "circle.fill")?.withTintColor(UIColor.black)
            arimage.image = UIImage(systemName: "circle")?.withTintColor(UIColor.black)
        }
    }
    

    @IBAction func Ar(_ sender: Any) {
        MOLH.setLanguageTo("ar")
        MOLH.reset()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.reset()
    }
    
    @IBAction func En(_ sender: Any) {
        MOLH.setLanguageTo("en")
        MOLH.reset()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.reset()
        
        
    }

}
