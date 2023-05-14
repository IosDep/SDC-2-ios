//
//  ChangeLanguage.swift
//  SDC
//  Created by Blue Ray on 09/04/2023.


import UIKit
import MOLH
class ChangeLanguage: UIViewController {
    
    
    @IBOutlet weak var englishBtn: DesignableButton!
    @IBOutlet weak var arabicBtn: DesignableButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var langView: UIStackView!
    @IBOutlet weak var bellView: UIView!
    @IBOutlet weak var majoreView: UIView!
    @IBOutlet weak var enimaeg: UIImageView!
    @IBOutlet weak var arimage: UIImageView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.cerateBellView(bellview: bellView, count: "12")
        majoreView.roundCorners([.topLeft,.topRight], radius: 12)
        self.langView.layer.cornerRadius = 23
        self.langView.layer.backgroundColor = UIColor.black.cgColor
        self.langView.backgroundColor = UIColor.systemBackground
        self.langView.layer.shadowColor = UIColor.systemGray3.cgColor
        langView.layer.shadowOpacity = 2
        langView.layer.shadowRadius = 23
        langView.layer.shadowOffset = .zero
        langView.layer.shadowPath = UIBezierPath(rect: langView.bounds).cgPath
        langView.layer.shouldRasterize = true

    // UIColor(named: "AccentColor")
        
        if MOLHLanguage.isArabic() {
            enimaeg.semanticContentAttribute = .forceRightToLeft
            arimage.image = UIImage(systemName: "circle.fill")
            arimage.tintColor = UIColor(named: "AccentColor") ?? UIColor.green
            enimaeg.image = UIImage(systemName: "circle")?.withTintColor(UIColor(named: "AccentColor") ?? UIColor.green)
        }else {
            enimaeg.image = UIImage(systemName: "circle.fill")
            enimaeg.tintColor = UIColor(named: "AccentColor") ?? UIColor.green
            arimage.image = UIImage(systemName: "circle")?.withTintColor(UIColor(named: "AccentColor") ?? UIColor.green)
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
