//
//  DepositViewController.swift
//  Savings
//
//  Created by John Jakobsen on 8/3/20.
//  Copyright © 2020 John Jakobsen. All rights reserved.
//

import UIKit

class DepositViewController: UIViewController {

    @IBOutlet weak var mainDepositInput: UITextField!
    @IBOutlet weak var totalSavedAmountLabel: UILabel!
    @IBOutlet weak var totalSavedLabel: UILabel!
    @IBOutlet weak var personalFundsView: UIView!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var personalFundSwitch: UISwitch!
    @IBOutlet weak var reasonForDepositTextField: UITextView!
    @IBOutlet weak var personalFundsSlider: UISlider!
    @IBOutlet weak var personalFundsPercentLabel: UILabel!
    @IBOutlet weak var tipsInput: UITextField!
    @IBOutlet weak var personalFundsTotalLabel: UILabel!
    var mainController: ViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldView.layer.cornerRadius = 3
        reasonForDepositTextField.layer.cornerRadius = 3
        let spendingPercent = UserDefaults.standard.double(forKey: "spendingPercent")
        personalFundsSlider.value = Float(round(spendingPercent * 100.0)/100.0)
        personalFundsPercentLabel.text = String(format:"%.0f %%", Double(round(personalFundsSlider.value * 100.0)))
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapView(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func didChangeSlider(_ sender: Any) {
        personalFundsPercentLabel.text = String(format:"%.0f %%", Double(round(personalFundsSlider.value * 100.0)))
        amountChanged()
        personalFundsSlider.value = round(personalFundsSlider.value * 100.0)/100.0
    }
    @IBAction func didChangeAddToPersonal(_ sender: Any) {
        view.endEditing(true)
        if (sender as! UISwitch).isOn {

            UIView.animate(withDuration: 0.5, animations: {() -> () in
                self.bottomView.frame.size.height -= 110
                self.bottomView.center = CGPoint(x: self.bottomView.center.x, y: 560)
                self.totalSavedLabel.center = CGPoint(x: self.totalSavedLabel.center.x, y: 246)
                self.totalSavedAmountLabel.center = CGPoint(x: self.totalSavedAmountLabel.center.x, y: 246)
            }, completion: {(Bool) -> () in
                self.personalFundsView.isHidden = false
            })
            
        } else {
            
            UIView.animate(withDuration: 0.5, animations: {() -> () in
                self.bottomView.center = CGPoint(x: self.bottomView.center.x, y: 420)
                self.bottomView.frame.size.height += 110
                self.personalFundsView.isHidden = true
                self.totalSavedLabel.center = CGPoint(x: self.totalSavedLabel.center.x, y: 350)
                self.totalSavedAmountLabel.center = CGPoint(x: self.totalSavedAmountLabel.center.x, y: 350)
                
            })
            
        }
    }
    @IBAction func didChangeAmount(_ sender: Any) {
        amountChanged()
    }
    @IBAction func didTapDone(_ sender: Any) {
        let spendingPercentage = personalFundSwitch.isOn ? Double(round(personalFundsSlider.value * 100.0)/100.0) : 0
        let newEntry = Entry(amount: Double(mainDepositInput.text!) ?? 0, tips: Double(tipsInput.text!) ?? 0, type: "Regular Deposit", reason: reasonForDepositTextField.text, spendingPercentage: spendingPercentage)
        if newEntry.amount() == 0 {
            return dismiss(animated: true)
        }
        mainController.addEntry(entry: newEntry)
        dismiss(animated: true)
    }
    func amountChanged() {
        let totalPay = Double(mainDepositInput.text!) ?? 0, tips = Double(tipsInput.text!) ?? 0
        personalFundsTotalLabel.text = String(format: "$ %.2f", (totalPay + tips) * Double(round(personalFundsSlider.value * 100.0)/100.0))
        let total = totalPay + tips
        let personalSavings = personalFundSwitch.isOn ? total * Double(round(personalFundsSlider.value * 100.0)/100.0) : 0
        let totalsaved = total - personalSavings
        totalSavedAmountLabel.text = String(format: "$ %.2f", totalsaved)
    }
}
