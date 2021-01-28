//
//  ViewController.swift
//  Shopping Calculator
//
//  Created by Jiwoo Seo on 6/15/20.
//  Copyright © 2020 Jiwoo Seo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBOutlet weak var textfieldP: UITextField!
    @IBOutlet weak var textfieldD: UITextField!
    @IBOutlet weak var textfieldS: UITextField!
    @IBOutlet weak var finalPrice: UILabel!
    @IBOutlet weak var msg: UILabel!
    @IBOutlet weak var msgNegVal: UILabel!
    
     var discounted = 0.0
    
    
    @IBAction func priceTyped(_ sender: Any) {
        calc()
    }
    @IBAction func discountTyped(_ sender: Any) {
        calc()
    }
    @IBAction func taxTyped(_ sender: Any) {
        calc()
    }
    
    
    
    func calc() {
        var price = 0.0
        var discount = 0.0
        var tax = 0.0
        
        if textfieldP != nil && Double(textfieldP.text!) != nil {
            price = Double(textfieldP.text!)!
        }
        
        if textfieldD != nil &&  Double(textfieldD.text!) != nil{
            discount = Double(textfieldD.text!)!
        }
        
        if textfieldS != nil && Double(textfieldS.text!) != nil {
            tax = Double(textfieldS.text!)!
        }
        
        
        //dealing negative values
        if price < 0 || discount < 0 || tax < 0 {
            msgNegVal.isHidden = false
        }
        else {
            msgNegVal.isHidden = true
        }
        
        // dealing with discount % > 100
        if discount > 100 {
            msg.isHidden = false
        }
        else {
            msg.isHidden = true
        }
        
        // if no error cases, display the final price
        if msg.isHidden == true && msgNegVal.isHidden == true {
            discounted = (price - price * (0.01 * discount)) * (1 + (0.01 * tax))
            let displayText = "$\(String(format: "%.2f", discounted))"
            finalPrice.text = String(displayText)
            finalCurr.text = ""
        }
        else {
            finalPrice.text = ""
        }
        
        
        
    }
    
    
    
    
    /* Features for the
     1) dark mode
     2) converting final price into different currencies */
    
    
    // creative portion 1: dark mode
    @IBOutlet weak var darkmode: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var darkLabel: UILabel!
    @IBOutlet weak var fpLabel: UILabel!
    
    
    @IBAction func darked(_ sender: UISwitch) {
        if darkmode.isOn {
            // dark
            titleLabel.textColor = UIColor.lightGray
            priceLabel.textColor = UIColor.lightGray
            discountLabel.textColor = UIColor.lightGray
            finalPrice.textColor = UIColor.white
            taxLabel.textColor = UIColor.lightGray
            darkLabel.textColor = UIColor.lightGray
            textfieldP.backgroundColor = UIColor.darkGray
            textfieldP.textColor = UIColor.lightGray
            textfieldD.backgroundColor = UIColor.darkGray
            textfieldD.textColor = UIColor.lightGray
            textfieldS.backgroundColor = UIColor.darkGray
            textfieldS.textColor = UIColor.lightGray
            fpLabel.textColor = UIColor.white
            view.backgroundColor = UIColor.black
            finalCurr.textColor = UIColor.lightGray
        }
        else {
            // light
            titleLabel.textColor = UIColor.black
            priceLabel.textColor = UIColor.black
            discountLabel.textColor = UIColor.black
            finalPrice.textColor = UIColor.black
            taxLabel.textColor = UIColor.black
            darkLabel.textColor = UIColor.black
            textfieldP.backgroundColor = UIColor.white
            textfieldP.textColor = UIColor.black
            textfieldD.backgroundColor = UIColor.white
            textfieldD.textColor = UIColor.black
            textfieldS.backgroundColor = UIColor.white
            textfieldS.textColor = UIColor.black
            fpLabel.textColor = UIColor.black
            view.backgroundColor = UIColor.white
            finalCurr.textColor = UIColor.black
        }
    }
    
    
    
    
    
    // Feature for other currencies
    // Drop down menu: I was helped by a youtube video: https://www.youtube.com/watch?v=dIKK-SCkh_c
    
    @IBOutlet var currSet: [UIButton]!
    @IBOutlet weak var finalCurr: UILabel!
    
    @IBAction func currencyTab(_ sender: UIButton) {
        currSet.forEach{ (button)  in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func currSelected(_ sender: UIButton) {
        
        var exchanged = 0.0
        var dpText = ""
        
        guard let title = sender.currentTitle, let cur = Currencies(rawValue: title) else {
            return
        }
        switch cur {
        case .korea:
            if discounted != 0.0 {
                exchanged = discounted * 1212.82
                dpText = "₩ \(String(format: "%.2f", exchanged))"
                finalCurr.text = String(dpText)
            }
            
        case .eu:
            if discounted != 0.0 {
                exchanged = discounted * 0.89
                dpText = "€ \(String(format: "%.2f", exchanged))"
                finalCurr.text = String(dpText)
            }
            
        case .japan:
            if discounted != 0.0 {
                exchanged = discounted * 107.42
                dpText = "¥ \(String(format: "%.2f", exchanged))"
                finalCurr.text = String(dpText)
            }
            
        case .uk:
            if discounted != 0.0 {
                exchanged = discounted * 0.80
                dpText = "£ \(String(format: "%.2f", exchanged))"
                finalCurr.text = String(dpText)
            }
        }
        
    }
    
    enum Currencies: String {
        case korea = "₩"
        case eu = "€"
        case japan = "¥"
        case uk = "£"
    }
    
    
    
    

    
}

