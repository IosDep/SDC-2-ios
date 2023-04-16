//
//  HeaderView.swift
//  SDC
//
//  Created by Blue Ray on 19/03/2023.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet weak var arrowBack: UIButton!
    @IBOutlet weak var menu: UIButton!
    
    
 
    @IBOutlet weak var bell: UIView!
    
    
    func setVC(viewController:UIViewController)
    {
        var imageViewWithCount: UIView!
          var countLabel: UILabel!
        
        
        
        // Create the image view
          let imageView = UIImageView(image: UIImage(named: "bells"))
        imageView.contentMode = .center
//        bell.backgroundColor = .white
          
          // Create the count label
          countLabel = UILabel(frame: CGRect(x: 15, y: -5, width: 20, height: 20))
          countLabel.textColor = .white
          countLabel.font = UIFont.boldSystemFont(ofSize: 12)
          countLabel.textAlignment = .center
          countLabel.backgroundColor = .red
          countLabel.layer.cornerRadius = 10
          countLabel.clipsToBounds = true
          countLabel.text = "0"
        
          // Create the container view that combines the image view and count label
          imageViewWithCount = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
          imageViewWithCount.addSubview(imageView)
          imageViewWithCount.addSubview(countLabel)
//        let menu = UIBarButtonItem(image: UIImage(named:  "menus"), style: .plain, target: self, action: #selector(sideMenu))

          // Add the container view to the navigation bar as a custom UIBarButtonItem
        self.bell.addSubview(imageViewWithCount)
        arrowBack.addTarget(self, action: #selector(arrowback), for: .touchUpInside)
        menu.addTarget(self, action: #selector(didTabMneu), for: .touchUpInside)
 
        
    }
    @objc func didTabMneu(){
        print("didTabMneu")

    }
    
    @objc func arrowback(){
        print("arrowback")
        
        
    }
    
    
    
    

    
    
}
