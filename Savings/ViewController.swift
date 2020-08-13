//
//  ViewController.swift
//  Savings
//
//  Created by John Jakobsen on 7/31/20.
//  Copyright © 2020 John Jakobsen. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    var db: DBHelper = DBHelper()
    var entries = [Entry]()
    @IBOutlet weak var totalSavedLabel: UILabel!
    @IBOutlet weak var noEntriesLabel: UILabel!
    var totalSaved: Double!
    @IBOutlet var entryViews: [UIView]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstView.layer.cornerRadius = 15
        secondView.layer.cornerRadius = 5
        totalSaved = UserDefaults.standard.double(forKey: "totalSaved")
        totalSavedLabel.text = String(format: "$ %.2f", totalSaved)
        entries = db.read()
        entries.sort { (Entry1, Entry2) -> Bool in
            Entry2.dateToTimeInterval() < Entry1.dateToTimeInterval()
        }
        updateTop3Entries()

    }
    func updateTop3Entries() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateStyle = .long
        if entries.count == 0 {
            noEntriesLabel.isHidden = false
        } else {
            noEntriesLabel.isHidden = true
        }
        for i in 0..<entries.count {
            if i > 2 {
                return
            }
            for j in 0..<entryViews[i].subviews.count {
                if let label = entryViews[i].subviews[j] as? UILabel {
                    if j == 0 {
                        if entries[i].amount() < 0 {
                            label.textColor = UIColor.red
                            label.text = String(format: "- $ %.2f", entries[i].total() * -1)
                        } else {
                            label.textColor = UIColor.black
                            label.text = String(format: "$ %.2f", entries[i].total())
                        }
                    }
                    if j == 1 {
                        label.text = entries[i].typeOfEntry()
                    }
                    if j == 2 {
                        label.text = formatter.string(from:  entries[i].dateEntered as Date)
                    }
                }
            }
            
        }
    }
    func addEntry(entry: Entry) {
        UserDefaults.standard.set(entry.spendingPercent, forKey: "spendingPercent")
        db.insert(entry: entry)
        totalSaved += entry.total()
        UserDefaults.standard.set(totalSaved, forKey: "totalSaved")
        totalSavedLabel.text = String(format: "$ %.2f", totalSaved)
        entries.insert(entry, at: 0)
        updateTop3Entries()
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        if segue.identifier == "AllEntriesSegue" {
            let allviewsController = navigationController.topViewController as! AllEntriesTableViewController
            allviewsController.entries = entries
        }
        if segue.identifier == "DepositPaycheckSegue" {
            let depositPaycheckView = navigationController.topViewController as! DepositPaycheckViewController
            depositPaycheckView.mainController = self
        }
        if segue.identifier == "DepositSegue" {
            let depositView = navigationController.topViewController as! DepositViewController
            depositView.mainController = self
        }
        if segue.identifier == "WithdrawalSegue" {
            let withdrawalView = navigationController.topViewController as! WithdrawalViewController
            withdrawalView.mainController = self
            withdrawalView.totalSavings = totalSaved
        }
    }
        
}

