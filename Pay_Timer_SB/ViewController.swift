//
//  ViewController.swift
//  Pay_Timer_SB
//
//  Created by Federico Pastormerlo on 06/05/2020.
//  Copyright © 2020 Federico Pastormerlo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Global variable
    var hideShowUI:Bool = true
    var payString:String = ""
    
    // MARK: Global letting
    let payObjc = Pay() // Pay Object
    
    /***  IBOutlet  ***/
    
    // MARK: TextField
    @IBOutlet var payTextField: UITextField!
  
    // MARK: Label
    @IBOutlet var time: UILabel!
    @IBOutlet var pay: UILabel!
    @IBOutlet var checkPointLabel: UILabel!
    
    // MARK: Button
    @IBOutlet var startButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    
    @IBOutlet var startPause: UIButton! {
           didSet {
            /*   startPause.setBackgroundColor(.green, for: .normal)
               startPause.setBackgroundColor(.yellow, for: .selected)*/
           }
       }
    
    /***  IBAction  ***/

    @IBAction func toggle(_ sender: Any) {
        
        //sendler.isSelected =!sendler.isSelected
        stopwatch.toggle()
        payTextField.isHidden = true
        hideShowUI = false
        setupUI(show: hideShowUI)
        
        if stopwatch.isPaused == true {
            
            payTextField.isHidden = false
            payTextField.isSelected = true
            let textFieldTxt = payString
            //print(payString,"\"payString")
            let textFieldDouble = NSString(string: textFieldTxt).doubleValue // downcast as double Textfield value
            payAmountCount(seconds: textFieldDouble) // pay calculus method
            pay.text = textFieldTxt
            //payTextField.text = ""
            // payTextField.text = pay.text
            // let payLabelTxt = payString
            //pay.text = payLabelTxt
             //payTextField.text = payString

        }

    }
    
    @IBAction func reset(_ sender: Any) {
       
        stopwatch.stop()
        startPause.isSelected = false
        payTextField.isHidden = false

    }
    
    /***  @IBAction func payText(_ sender: Any) {
        let name =  (pay.text)!
    } **/
    
    
    private lazy var stopwatch = Stopwatch(timeUpdated: { [weak self] timeInterval in
        guard let strongSelf = self else { return }
        strongSelf.time.text = strongSelf.timeString(from: timeInterval)
    })
    
    deinit {
        stopwatch.stop()
        
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
            
            let secondDouble = Double(timeInterval.truncatingRemainder(dividingBy: 3600)) // variable amount seconds payed
            let minutes = Int(timeInterval.truncatingRemainder(dividingBy: 60 * 60) / 60)
            let hours = Int(timeInterval / 3600)
            payAmountCount(seconds: secondDouble) // pay calculus method
            let second = Int(timeInterval.truncatingRemainder(dividingBy: 60)) // downcast Double to Int
            checkPointTimer(time: minutes)
        
       /** switch minutes {
        case 1:
            pay.text = "fuck"
            case 2:
            pay.text = "CISO"

        default:
            break
        }**/
            return String(format: "%.2d:%.2d:%.2d", hours, minutes, second)
        }
    
        // MARK: Pay realtime method

            func payAmountCount(seconds:Double){
        
            let textFieldTxt = payTextField.text!
            let textFieldDouble = NSString(string: textFieldTxt).doubleValue // downcast as double Textfield value
            let payScore = payObjc.payCalculous(time:textFieldDouble, seconds:seconds)
           // let payScore = textFieldDouble / 3600 * seconds // pay calculous
            payString = String(String(format:"%.2f", payScore)) // convert Double to string for label
            pay.text = payString
            pay.lineBreakMode = .byTruncatingTail
            //print(payScore)

        }
    
         /*** UI elements management display method  ***/
    
            func setupUI(show:Bool) {
        
                 time.isHidden = show
                 pay.isHidden = show
                 stopButton.isHidden = show
        
            }
    
            func checkPointTimer(time: Int) {
        switch time {
        case 1:
            checkPointLabel.text = "fuck"
            case 2:
            checkPointLabel.text = "CISO"

        default:
            break
           }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI(show: hideShowUI)
       
        // Do any additional setup after loading the view.
    }
}
    




