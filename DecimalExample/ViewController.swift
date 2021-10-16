//
//  ViewController.swift
//  DecimalExample
//
//  Created by Himanshu Visroliya on 16/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtNum: UITextField!
    
    var maximumAllowedAfterDecimal = 2
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        txtNum.keyboardType = .decimalPad
        txtNum.addTarget(self, action: #selector(doDecimalCalculation), for: .editingChanged)
        txtNum.delegate = self
    }
    
    @objc func doDecimalCalculation(textField: UITextField) {
        
//        print("Text Num : ", txtNum.text ?? "")
//        print("Current Value : ", textField.text ?? "")
        
        let newStr = textField.text?.replacingOccurrences(of: " ", with: "") ?? ""
//        print("New Value before separator convert : ", newStr )
        
        guard let digit = Int(newStr) else {
            return
        }
        
//        print("digit : ", digit)
        let finalValue = formatter.string(from: NSNumber(value: Double(digit))) ?? "0"
//        print("finalValue : ", finalValue)
        self.txtNum.text = finalValue
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text: NSString = textField.text! as NSString
        let resultString = text.replacingCharacters(in: range, with: string)
        
        //Check the specific textField if Any
        
        let textArray = resultString.components(separatedBy: ".")
        if textArray.count > 1 {
            if textArray[1].count > maximumAllowedAfterDecimal {
                print("return false")
                return false
            }
        }
        return true
    }
}
