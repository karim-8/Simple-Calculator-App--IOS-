

import UIKit

enum modes {
    case not_set
    case addtion
    case subtraction
    case multiply
}

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    //instance vars
    var labelString = "0"
    var currentMode: modes = .not_set
    var savedNum = 0
    var lastButtonWasMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   
    
    @IBAction func didPressPlus(_ sender: Any) {
        changeMode(newMode: .addtion)
    }
    
    @IBAction func didPressSubtract(_ sender: Any) {
        changeMode(newMode: .subtraction)
        
    }
    
    @IBAction func didPressMultiply(_ sender: Any) {
        changeMode(newMode: .multiply)
    }
    @IBAction func didPressNumber(_ sender: UIButton){
        
        //when user hit a number let it remove zero on left by appending string
        let stringValue = sender.titleLabel?.text
        
        if(lastButtonWasMode){
            lastButtonWasMode = false
            labelString = "0"
        }
        
        labelString = labelString.appending(stringValue!)
        updateText()
        
        
        
    }
    
    @IBAction func didPressClear(_ sender: Any) {
        //clearing the text and all the calc
        
         labelString = "0"
         currentMode = .not_set
         savedNum = 0
         lastButtonWasMode = false
         label.text = "0"
        
    }
    
    @IBAction func didPressEqual(_ sender: Any) {
        
        guard let parseInt = Int(labelString) else {
            print("Error")
            return
        }
        
        if(currentMode == .not_set || lastButtonWasMode){
            return
        }
        else if (currentMode == .addtion){
            savedNum += parseInt
        }
        else if (currentMode == .subtraction){
            savedNum -= parseInt
        }
        else if (currentMode == .multiply){
            savedNum *= parseInt
        }
        
        currentMode = .not_set
        labelString = ("\(savedNum)")
        updateText()
        lastButtonWasMode = true
        
    }
    
    func changeMode(newMode:modes){
        //if user hit - ,+ dont care and return
        if (savedNum == 0) {
            return
        }
        
        currentMode = newMode
        lastButtonWasMode = true
        
    }
    
    func updateText () {
        
        guard let parseInt = Int(labelString) else {
            print("Error")
            return
        }
        
        if (currentMode == .not_set) {
            savedNum = parseInt
        }
        //format nums to decimal
        let formatter:NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let num:NSNumber = NSNumber(value: parseInt)
        
        label.text = formatter.string(from: num)
        
    }


}

