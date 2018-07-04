//
//  CBMViewController.swift
//  PoomgoCalculator
//
//  Created by 한병두 on 2018. 7. 1..
//  Copyright © 2018년 Byungdoo Han. All rights reserved.
//

import UIKit
import LabelSwitch

class CBMViewController: UIViewController, UITextFieldDelegate, LabelSwitchDelegate {
    
    
    @IBOutlet weak var widthTextField: UITextField!
    @IBOutlet weak var depthTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var itemCountTextField: UITextField!
    @IBOutlet weak var widthMeasure: UILabel!
    @IBOutlet weak var depthMeasure: UILabel!
    @IBOutlet weak var heightMeasure: UILabel!
    
    @IBOutlet weak var valueOfPerLbl: UILabel!
    @IBOutlet weak var totalValueLbl: UILabel!
    
    var units = ["cm", "mm"]
    var selectedUnit = ""
    var valueOfPer : Double = 0
    var totalValue : Double = 0
    
    let ls = LabelSwtichSetting(text: "cm",
                                textColor: .white,
                                font: UIFont.boldSystemFont(ofSize: 15),
                                backgroundColor: .purple)
    
    let rs = LabelSwtichSetting(text: "mm",
                                textColor: .white,
                                font: UIFont.boldSystemFont(ofSize: 15),
                                backgroundColor: .blue)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        widthTextField.keyboardType = UIKeyboardType.numberPad
        depthTextField.keyboardType = UIKeyboardType.numberPad
        heightTextField.keyboardType = UIKeyboardType.numberPad
        itemCountTextField.keyboardType = UIKeyboardType.numberPad
        
        
        // Set the default state of the switch,
        let labelSwitch = LabelSwitch(center: CGPoint(x:310, y: 610), leftSetting: ls, rightSetting: rs, defaultState: .L)

        // Set the appearance of the circle button
        labelSwitch.circleShadow = false
        labelSwitch.circleColor = .red
        
        // Make switch be triggered by tapping on any position in the switch
        labelSwitch.fullSizeTapEnabled = true
        
        // Set the delegate to inform when the switch was triggered
        labelSwitch.delegate = self
        
        view.addSubview(labelSwitch)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    func switchChangToState(_ state: SwitchState) {
        switch state {
        case .L: print("circle on left")
        selectedUnit = rs.text
        widthMeasure.text = rs.text
        depthMeasure.text = rs.text
        heightMeasure.text = rs.text
            
        case .R: print("circle on right")
        selectedUnit = ls.text
        widthMeasure.text = ls.text
        depthMeasure.text = ls.text
        heightMeasure.text = ls.text
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return units[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return units.count
    }
  
    
    @IBAction func btnAction(_ sender: Any) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 10
        
        if  (widthTextField.text?.isEmpty)! || (depthTextField.text?.isEmpty)! || (heightTextField.text?.isEmpty)! || (itemCountTextField.text?.isEmpty)! {
            print("error")
            
            showToast(message: "모든 값을 입력해주세요.")
            //TODO -  Toast message
        } else {
            print("hello")
            switch selectedUnit {
            case "cm":
                print("here is cm")
                valueOfPer = (((widthTextField.text! as NSString).doubleValue * (depthTextField.text! as NSString).doubleValue * (heightTextField.text! as NSString).doubleValue) / 1000000)
                totalValue = Double(valueOfPer) * (itemCountTextField.text! as NSString).doubleValue
                print(valueOfPer)
                valueOfPerLbl.text = numberFormatter.string(from: NSNumber(value: valueOfPer))
                totalValueLbl.text = numberFormatter.string(from: NSNumber(value: totalValue))
                
            case "mm":
                print("here is mm")
                valueOfPer = (((widthTextField.text! as NSString).doubleValue * (depthTextField.text! as NSString).doubleValue * (heightTextField.text! as NSString).doubleValue) / 1000000000)
                totalValue = Double(valueOfPer) * (itemCountTextField.text! as NSString).doubleValue
                valueOfPerLbl.text = numberFormatter.string(from: NSNumber(value: valueOfPer))
                totalValueLbl.text = numberFormatter.string(from: NSNumber(value: totalValue))

            default:
                break
            }
            
        }
    }
}

extension CBMViewController {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-550, width: 250, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    } }
