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
        //view.layer.addSublayer(gradientLayer)
        gradientAnimation(gradient:gradientLayer, firstColor:gradientFirstcolor, secondColor:gradientSecondcolor, view:view)
        //makeCurve(gradient: gradientLayer)
        
                
    }
    
   private func getRandomColor() -> UIColor {
        
        // generate random RGB colors
        let randomRed   = Double(arc4random_uniform(256))/255.0
        let randomGreen = Double(arc4random_uniform(256))/255.0
        let randomBlue  = Double(arc4random_uniform(256))/255.0
        print("Red:\(randomRed)\n","Green:\(randomGreen)\n","Blue:\(randomBlue)\n")
        
        return UIColor(red: CGFloat(randomRed), green: CGFloat(randomGreen), blue: CGFloat(randomBlue), alpha: 1.0)
    }
    
    private func gradientAnimation(gradient:CAGradientLayer, firstColor:UIColor, secondColor:UIColor, view:UIView) {
        
        // gradient transiscion animnation
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = [firstColor.cgColor, secondColor.cgColor]
        animation.toValue = [secondColor.cgColor, firstColor.cgColor]
        animation.duration = 5.0
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        // add the animation to the gradient
        gradient.add(animation, forKey: nil)

        // add the gradient to the view
        view.layer.addSublayer(gradient)
        gradient.name = "gradientLayer"
        
       

        //gradient.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)


        
       
        
        
    }
    
   private func makeCurve(gradient: CAGradientLayer){
    
      /**  let circlePath = UIBezierPath(arcCenter: CGPoint(x: 100, y: 100), radius: CGFloat(20), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)  **/
    
   let circlePath = UIBezierPath(arcCenter: CGPoint(x: CGFloat(Double(arc4random_uniform(256))), y: CGFloat(Double(arc4random_uniform(256)))), radius: CGFloat(Double(arc4random_uniform(256))), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)

    
        let shapeLayer = CAShapeLayer()
       /* shapeLayer.path = circlePath.cgPath
        gradient.mask = shapeLayer*/
    
    //fileprivate
    //shapeLayer.removeFromSuperlayer()
    
    var timeLeft = 60

    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
        if timeLeft != 0 {
            shapeLayer.path = circlePath.cgPath
            gradient.mask = shapeLayer
            timeLeft -= 1
            
        } else {
            timer.invalidate()
            shapeLayer.removeFromSuperlayer()
        }
    }


    }
    
    
    
    func setupGradientTxt(gradient: CAGradientLayer, label: UILabel, view: UIView){
        
        let shapeLayer = CAShapeLayer()
        view.addSubview(label)
        gradient.mask = shapeLayer
    }
    
    /*  Invert gradient method  */
    
     func setupGradientLabel(label:UILabel, view:UIView){
        
        label.frame = view.bounds
        //label.font = UIFont.boldSystemFont(ofSize: 100)
        //label.textAlignment = .center
        view.addSubview(label)
        view.mask = label
        
        
        
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

extension UIColor
{
    var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  lum < 0.50
    }
   // pay.textColor = view.backgroundColor?.isDarkColor == true ? .white : .black

}

extension UIView {
    func removeLayer(layerName: String) {
            for item in self.layer.sublayers ?? [] where item.name == layerName {
                    item.removeFromSuperlayer()
            }
        }
}
