//
//  CBMViewController.swift
//  PoomgoCalculator
//
//  Created by 한병두 on 2018. 7. 1..
//  Copyright © 2018년 Byungdoo Han. All rights reserved.
//

import UIKit
import LabelSwitch

class CBMViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, LabelSwitchDelegate {
    
    func switchChangToState(_ state: SwitchState) {
        switch state {
        case .L: print("circle on left")
        case .R: print("circle on right")
        }
    }
    
    
    @IBOutlet weak var pickerView: UIPickerView! 
    
    @IBOutlet weak var widthTextField: UITextField!
    @IBOutlet weak var depthTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var widthMeasure: UILabel!
    @IBOutlet weak var depthMeasure: UILabel!
    @IBOutlet weak var heightMeasure: UILabel!
    
    @IBOutlet weak var valueOfPerLbl: UILabel!
    @IBOutlet weak var totalValueLbl: UILabel!
    
    var units = ["m", "cm", "mm"]
    var selectedUnit = ""
    var valueOfPer : Int = 0
    var totalValue : Int = 0
    
    let ls = LabelSwtichSetting(text: "cm",
                                textColor: .white,
                                font: UIFont.boldSystemFont(ofSize: 15),
                                backgroundColor: .red)
    
    let rs = LabelSwtichSetting(text: "mm",
                                textColor: .white,
                                font: UIFont.boldSystemFont(ofSize: 20),
                                backgroundColor: .green)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Set the default state of the switch,
        let labelSwitch = LabelSwitch(center: .zero, leftSetting: ls, rightSetting: rs, defaultState: .L)
        
        // Set the appearance of the circle button
        labelSwitch.circleShadow = false
        labelSwitch.circleColor = .red
        
        // Make switch be triggered by tapping on any position in the switch
        labelSwitch.fullSizeTapEnabled = true
        
        // Set the delegate to inform when the switch was triggered
        labelSwitch.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    //피커 뷰의 선택에 따라 단위가 바뀐다.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if units[row] == "m" {
            selectedUnit = units[row]
            widthMeasure.text = units[row]
            depthMeasure.text = units[row]
            heightMeasure.text = units[row]
        
            
        } else if units[row] == "cm" {
            selectedUnit = units[row]
            widthMeasure.text = units[row]
            depthMeasure.text = units[row]
            heightMeasure.text = units[row]
            
        } else {
            selectedUnit = units[row]
            widthMeasure.text = units[row]
            depthMeasure.text = units[row]
            heightMeasure.text = units[row]
        }
    }

    
    @IBAction func btnAction(_ sender: Any) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        if  (widthTextField.text?.isEmpty)! || (depthTextField.text?.isEmpty)! || (heightTextField.text?.isEmpty)! {
            print("error")
            //TODO -  Toast message
        } else {
            print("hello")
            switch selectedUnit {
            case "m":
                print("here is m")
                
            case "cm":
                print("here is cm")
                valueOfPer = Int(1000000 / (((widthTextField.text! as NSString).intValue) * ((depthTextField.text! as NSString).intValue) * ((heightTextField.text! as NSString).intValue)))
                valueOfPerLbl.text = numberFormatter.string(from: NSNumber(integerLiteral: valueOfPer))
                
                
            case "mm":
                print("here is mm")
                valueOfPer = Int(1000000000 / (((widthTextField.text! as NSString).intValue) * ((depthTextField.text! as NSString).intValue) * ((heightTextField.text! as NSString).intValue)))
                valueOfPerLbl.text = numberFormatter.string(from: NSNumber(integerLiteral: valueOfPer))

            default:
                break
            }
            
        }
    }
}

extension ViewController: LabelSwitchDelegate {
    func switchChangToState(_ state: SwitchState) {
        switch state {
        case .L: print("circle on left")
        case .R: print("circle on right")
        }
    }
}

