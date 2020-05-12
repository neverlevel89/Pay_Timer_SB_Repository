//
//  ViewController.swift
//  Pay_Timer_SB
//
//  Created by Federico Pastormerlo on 06/05/2020.
//  Copyright © 2020 Federico Pastormerlo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet var startPause: UIButton! {
        didSet {
         /*   startPause.setBackgroundColor(.green, for: .normal)
            startPause.setBackgroundColor(.yellow, for: .selected)*/
        }
    }
    @IBOutlet var time: UILabel!
    @IBOutlet var pay: UILabel!
    
    private lazy var stopwatch = Stopwatch(timeUpdated: { [weak self] timeInterval in
           guard let strongSelf = self else { return }
           strongSelf.time.text = strongSelf.timeString(from: timeInterval)
       })
       
       deinit {
           stopwatch.stop()
       }
       
    @IBAction func toggle(_ sender: Any) {
        //sendler.isSelected =!sendler.isSelected
        stopwatch.toggle()
    }
    
    @IBAction func reset(_ sender: Any) {
        stopwatch.stop()
               startPause.isSelected = false
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
            
            let secondDouble = Double(timeInterval.truncatingRemainder(dividingBy: 3600)) // variable amount seconds payed
            let minutes = Int(timeInterval.truncatingRemainder(dividingBy: 60 * 60) / 60)
            let hours = Int(timeInterval / 3600)
        
            payAmountCount(seconds: secondDouble) // pay calculus method
        
            let second = Int(timeInterval.truncatingRemainder(dividingBy: 60)) // Downcast Double to Int
            return String(format: "%.2d:%.2d:%.2d", hours, minutes, second)
        }
    
    func payAmountCount(seconds:Double){
        
        let scorePay = 100.0
        let payScore = scorePay / 3600 * seconds
        let payString = String(String(format:"%.2f", payScore))
        pay.text = payString
        pay.lineBreakMode = .byTruncatingTail
        //print(payScore)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    }
    




