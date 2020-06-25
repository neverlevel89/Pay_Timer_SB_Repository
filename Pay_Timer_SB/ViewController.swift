//
//  ViewController.swift
//  Pay_Timer_SB
//
//  Created by Federico Pastormerlo on 06/05/2020.
//  Copyright © 2020 Federico Pastormerlo. All rights reserved.
//

import SwiftUI // Note the second import
import UIKit


class ViewController: UIViewController {
    
    
    // MARK: Global variable
    var hideShowUI:Bool = true
    var payString:String = ""
   
    // MARK: Global letting/constant
    let payObjc = Pay() // Pay object
    let gradientObjc = Gradient() // Gradient object
    
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
            gradientTimer(second: second)
            //print(second)
        
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
    
    // MARK: Grandiet change any minute method

    
    func gradientTimer(second:Int) {
        
        /* default value 59 */
        if (second == 59) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                
                // gradient transition animation
                UIView.animate(withDuration: 0.4) {
                    self.view.alpha = 0.7
                    self.gradientObjc.setupGradient(view: self.view)
                    self.view.alpha = 1
                    self.view.removeLayer(layerName: "gradientLayer")
                    self.gradientObjc.setupGradient(view: self.view)

                    //self.view.layer.sublayers?.popLast()
                }
            }
                  
            //sleep(1)
    }
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
    
    func setupFontColor(fontColor: UIColor){
        
        time.textColor = fontColor
        pay.textColor = fontColor
        checkPointLabel.textColor = fontColor
        
        

        // pay.textColor = view.backgroundColor?.isDarkColor == true ? .white : .black

    }
    
    
    
    func setupUIColorSchemes(){
        
    if self.traitCollection.userInterfaceStyle == .dark
    {
        setupFontColor(fontColor: .white)
    }
        if self.traitCollection.userInterfaceStyle == .light
        {
            setupFontColor(fontColor: .black)

        }

        
    }
    
    
    /**SwiftUI Handling**/
    
    struct PageViewController: UIViewControllerRepresentable {
           var controllers: [UIViewController]

           func makeUIViewController(context: Context) -> UIPageViewController {
               let pageViewController = UIPageViewController(
                   transitionStyle: .scroll,
                   navigationOrientation: .horizontal)

               return pageViewController
           }

           func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
               pageViewController.setViewControllers(
                   [controllers[0]], direction: .forward, animated: true)
           }
       }
       
    func setupUILayout(){
        
        // dark or light UI setup
        view.overrideUserInterfaceStyle = .unspecified
        pay.center = view.center
        time.center.x = view.center.x

        checkPointLabel.center.x = view.center.x
        pay.textAlignment = .center
        time.textAlignment = .center
        pay.center.x = view.center.x
        time.center.x = view.center.x
        //startButton.contentHorizontalAlignment = .center
        //startButton.contentHorizontalAlignment = .right
        startButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        payTextField.textAlignment = .center
        payTextField.center.x = view.center.x
        //startButton.center.x = view.center.x
        
        //1
        NSLayoutConstraint.activate([
          //2
          startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
          //3
          startButton.widthAnchor.constraint(equalToConstant: 500),
          startButton.heightAnchor.constraint(equalToConstant: 500)
        ])
        
        
        /*
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            view.widthAnchor.constraint(equalToConstant: 80),
            view.heightAnchor.constraint(equalToConstant: 80),

            ]) */


        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI(show: hideShowUI)
        //setupFontColor(fontColor: .white)
        gradientObjc.setupGradient(view: view)
        //setupUIColorSchemes()
        setupUILayout()
      
        

    
        //gradientObjc.setupGradientLabel(label:checkPointLabel, view: view)

      /* let layer:CALayer = CALayer()
        let mask:UIImage = UIImage(named: "Black-Star-Photographic-Agency")!
        layer.contents = mask
        layer.frame = CGRect(x: 0, y: 0, width: ((self.defaultImageView.image?.size.width)!), height: (self.defaultImageView.image?.size.height)!)
        self.defaultImageView.layer.mask = layer
        self.defaultImageView.layer.masksToBounds = true*/
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
     super.viewDidAppear(animated)
         // Create new Alert
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this?", preferredStyle: .alert)
        
        
        dialogMessage.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.blue

        // Accessing buttons tintcolor :
        dialogMessage.view.tintColor = UIColor.white
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
    
    
}







    





struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
