//
//  WithdrawalViewController.swift
//  Savings
//
//  Created by John Jakobsen on 8/4/20.
//  Copyright © 2020 John Jakobsen. All rights reserved.
//

import UIKit

class WithdrawalViewController: UIViewController {
    var totalSavings: Double! = 0
    var mainController: ViewController!
    @IBOutlet weak var reasonInput: UITextView!
    @IBOutlet weak var totalSavingsLabel: UILabel!
    @IBOutlet weak var totalWithdrawnLabel: UILabel!
    @IBOutlet weak var updatedSavingsLabel: UILabel!
    @IBOutlet weak var withdrawalAmountInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        totalSavingsLabel.text = String(format: "$ %.2f", totalSavings)
    }
    
    
    @IBAction func didTapDone(_ sender: Any) {
        let totalWithdrawn = Double(withdrawalAmountInput.text!) ?? 0
        if totalWithdrawn == 0 {
            return dismiss(animated: true)
        }
        let newEntry = Entry(amount: totalWithdrawn, type: "Withdrawal", reason: reasonInput.text! )
        mainController.addEntry(entry: newEntry)
        dismiss(animated: true)
    }
    @IBAction func didCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func didTapView(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func amountChanged(_ sender: Any) {
        let totalWithdrawn = Double(withdrawalAmountInput.text!) ?? 0
        let updatedSavings = totalSavings - totalWithdrawn
        if totalWithdrawn > totalSavings {
            updatedSavingsLabel.textColor = UIColor.red
            
        } else {
            updatedSavingsLabel.textColor = UIColor.black
        }
        totalWithdrawnLabel.text = String(format: "- $ %.2f", totalWithdrawn)
        updatedSavingsLabel.text = String(format: "$ %.2f", updatedSavings)
    }
    
}
