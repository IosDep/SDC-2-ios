//
//  BellCountView.swift
//  SDC
//
//  Created by Blue Ray on 19/03/2023.
//

import Foundation
import UIKit


class BellCountView: UIView {
    
    // Define constants for the bell shape and count label
    let bellWidth: CGFloat = 50.0
    let bellHeight: CGFloat = 50.0
    let countLabelWidth: CGFloat = 20.0
    let countLabelHeight: CGFloat = 20.0
    
    // Define variables for the count
    var count: Int = 0 {
        didSet {
            // Update the count label text when the count changes
            countLabel.text = "\(count)"
        }
    }
    
    // Define the bell shape layer
    let bellLayer = CAShapeLayer()
    
    // Define the count label
    let countLabel = UILabel()
    
    // Define the initializer for the view
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set the background color
        
        
        // Create the bell shape
        let bellPath = UIBezierPath()
        bellPath.move(to: CGPoint(x: bellWidth/2, y: bellHeight*0.2))
        bellPath.addCurve(to: CGPoint(x: bellWidth*0.95, y: bellHeight*0.6),
                           controlPoint1: CGPoint(x: bellWidth/2, y: bellHeight*0.3),
                           controlPoint2: CGPoint(x: bellWidth*0.9, y: bellHeight*0.3))
        bellPath.addCurve(to: CGPoint(x: bellWidth/2, y: bellHeight*0.9),
                           controlPoint1: CGPoint(x: bellWidth*1.0, y: bellHeight*0.8),
                           controlPoint2: CGPoint(x: bellWidth/2, y: bellHeight*0.9))
        bellPath.addCurve(to: CGPoint(x: bellWidth*0.05, y: bellHeight*0.6),
                           controlPoint1: CGPoint(x: bellWidth/2, y: bellHeight*0.8),
                           controlPoint2: CGPoint(x: bellWidth*0.1, y: bellHeight*0.8))
        bellPath.addCurve(to: CGPoint(x: bellWidth/2, y: bellHeight*0.2),
                           controlPoint1: CGPoint(x: bellWidth*0.0, y: bellHeight*0.3),
                           controlPoint2: CGPoint(x: bellWidth/2, y: bellHeight*0.3))
        bellPath.close()
        bellLayer.path = bellPath.cgPath
        bellLayer.fillColor = UIColor.gray.cgColor
        layer.addSublayer(bellLayer)
        
        // Create the count label
        countLabel.frame = CGRect(x: bellWidth-countLabelWidth, y: 0, width: countLabelWidth, height: countLabelHeight)
        countLabel.textAlignment = .center
        countLabel.font = UIFont.systemFont(ofSize: 14.0)
        countLabel.textColor = UIColor.white
        addSubview(countLabel)
    }
    
    // Define the required initializer for the view
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
