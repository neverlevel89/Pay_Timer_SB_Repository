//
//  Gradient.swift
//  Pay_Timer_SB
//
//  Created by Federico Pastormerlo on 22/05/2020.
//  Copyright © 2020 Federico Pastormerlo. All rights reserved.
//

import Foundation
import UIKit

struct GradientSetup {
    
    var gradientRandom = UIColor(
    red:   CGFloat(drand48()),
    green: CGFloat(drand48()),
    blue:  CGFloat(drand48()),
    alpha: 1.0
    )
    
   
}
class Gradient {
    
    func setupGradient(view:UIView){
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.zPosition = -1
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        view.layer.addSublayer(gradientLayer)
        
    }
    
    func anotherGetRandomColor() -> UIColor {

        let newRed   = Double(arc4random_uniform(256))/255.0
        let newGreen = Double(arc4random_uniform(256))/255.0
        let newBlue  = Double(arc4random_uniform(256))/255.0
        
        return UIColor(red: CGFloat(newRed), green: CGFloat(newGreen), blue: CGFloat(newBlue), alpha: 1.0)
    }
    
    func getRandomColor() -> UIColor {
         //Generate between 0 to 1
         let red:CGFloat = CGFloat(drand48())
         let green:CGFloat = CGFloat(drand48())
         let blue:CGFloat = CGFloat(drand48())

         return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
}
