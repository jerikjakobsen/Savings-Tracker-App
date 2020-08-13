//
//  DepositPaycheckViewController.swift
//  Savings
//
//  Created by John Jakobsen on 8/1/20.
//  Copyright © 2020 John Jakobsen. All rights reserved.
//

import UIKit

class DepositPaycheckViewController: UIViewController {
    
    @IBOutlet weak var paycheckAmountInput: UITextField!
    @IBOutlet weak var tipsAmountInput: UITextField!
    @IBOutlet weak var spendingFundsPercentSlider: UISlider!
    @IBOutlet weak var spendingFundsPercentLabel: UILabel!
    @IBOutlet weak var totalPersonalFundsLabel: UILabel!
    @IBOutlet weak var totalSavedLabel: UILabel!
    var mainController: ViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        let spendingPercent = UserDefaults.standard.double(forKey: "spendingPercent")
        spendingFundsPercentSlider.value = Float(round(spendingPercent * 100.0)/100.0)
        spendingFundsPercentLabel.text = String(format:"%.0f %%", Double(round(spendingFundsPercentSlider.value * 100.0)))
        // Do any additional setup after loading the view.
    }
    @IBAction func spendingPercentSlider(_ sender: Any) {
        spendingFundsPercentLabel.text = String(format:" %.0f %%", Double(round(spendingFundsPercentSlider.value * 100.0)))
        amountChanged()
        spendingFundsPercentSlider.value = round(spendingFundsPercentSlider.value * 100.0)/100.0
    }
    @IBAction func viewTapped(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func didTapDone(_ sender: Any) {
        let totalPay = Double(paycheckAmountInput.text!), tips = Double(tipsAmountInput.text!)
        let newEntry = Entry(amount: totalPay ?? 0, tips: tips ?? 0, spendingPercentage: round(Double(spendingFundsPercentSlider.value) * 100.0)/100.0)
        if (newEntry.amount() == 0) {
            return dismiss(animated: true)
        }
        mainController.addEntry(entry: newEntry)
        dismiss(animated: true)
    }
    @IBAction func amountChanged(_ sender: Any) {
        amountChanged()
    }
    func amountChanged() {
        let totalPay = Double(paycheckAmountInput.text!) ?? 0, tips = Double(tipsAmountInput.text!) ?? 0
        totalPersonalFundsLabel.text = String(format: "$ %.2f", (totalPay + tips) * Double(round(spendingFundsPercentSlider.value * 100.0)/100.0))
        totalSavedLabel.text = String(format: "$ %.2f",totalPay + tips - (totalPay + tips) * Double(round(spendingFundsPercentSlider.value * 100.0)/100.0))
        
    }
}
