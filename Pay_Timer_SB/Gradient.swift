//
//  Gradient.swift
//  Pay_Timer_SB
//
//  Created by Federico Pastormerlo on 22/05/2020.
//  Copyright © 2020 Federico Pastormerlo. All rights reserved.
//

import Foundation
import UIKit

struct GradientTimer {
    
    let timer:Timer
    
}
class Gradient {
    
    func setupGradient(view:UIView){
        
        //let timer = GradientTimer(timer: Timer)
        let gradientFirstcolor = getRandomColor()
        let gradientSecondcolor = getRandomColor()
        let gradientLayer = CAGradientLayer()
        gradientLayer.zPosition = -1
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [gradientFirstcolor.cgColor, gradientSecondcolor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        view.layer.addSublayer(gradientLayer)
        //view.overrideUserInterfaceStyle = .dark
        
    }
    
    func getRandomColor() -> UIColor {
        
        // generate random RGB colors
        let randomRed   = Double(arc4random_uniform(256))/255.0
        let randomGreen = Double(arc4random_uniform(256))/255.0
        let randomBlue  = Double(arc4random_uniform(256))/255.0
        print("Red:\(randomRed)\n","Green:\(randomGreen)\n","Blue:\(randomBlue)\n")
        
        return UIColor(red: CGFloat(randomRed), green: CGFloat(randomGreen), blue: CGFloat(randomBlue), alpha: 1.0)
    }
  
    /**
    func anotherGetRandomColor() -> UIColor {
         //Generate between 0 to 1
         let red:CGFloat = CGFloat(drand48())
         let green:CGFloat = CGFloat(drand48())
         let blue:CGFloat = CGFloat(drand48())

         return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }  **/
}
