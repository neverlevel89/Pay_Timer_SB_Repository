//
//  Pay.swift
//  Pay_Timer_SB
//
//  Created by Federico Pastormerlo on 07/05/2020.
//  Copyright © 2020 Federico Pastormerlo. All rights reserved.
//

import Foundation

class Pay {
    
    // MARK:  Method calculus realtime pay

    func payCalculous(time:Double, seconds:Double) -> Double {
       let payRealTime = time / 3600 * seconds
       return payRealTime
    }
    
    func achivments(time:Int){
        
    switch time {
        case 1:
            ViewController().pay.text = "fuck"
            case 2:
            ViewController().pay.text = "CISO"

        default:
            break
        }
    }
}
