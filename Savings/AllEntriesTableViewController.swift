//
//  AllEntriesTableViewController.swift
//  Savings
//
//  Created by John Jakobsen on 8/5/20.
//  Copyright © 2020 John Jakobsen. All rights reserved.
//

import UIKit

class AllEntriesTableViewController: UITableViewController {
    var entries = [Entry]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.frame.size.height = 171
        tableView.separatorStyle = .none
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .long
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryIdentifier", for: indexPath) as! TableViewCell
        cell.personalFunds.text = String(format: "- $ %.2f", entries[indexPath.row].spendingAmount())
        cell.totalAdded.text = String(format: "$ %.2f", entries[indexPath.row].amount())
        cell.savingsDeposited.text = String(format: "$ %.2f", entries[indexPath.row].total())
        cell.dateLabel.text = dateFormatter.string(from: entries[indexPath.row].dateEntered as Date)
        cell.typeLabel.text = entries[indexPath.row].typeOfEntry()
        cell.reasonLabel.text = entries[indexPath.row].reasonForEntry()
        if cell.typeLabel.text == "Withdrawal" {
            cell.typeLabel.textColor = UIColor.red
            cell.totalAddedLabel.isHidden = true
            cell.totalAdded.isHidden = true
            cell.savingsDeposited.isHidden = true
            cell.savingsDepositedLabel.isHidden = true
            cell.personalFundsLabel.text = "Withdrawn:"
            cell.personalFunds.text = String(format: "- $ %.2f", entries[indexPath.row].total() * -1)
        } else {
            cell.typeLabel.textColor = UIColor.black
            cell.totalAddedLabel.isHidden = false
            cell.totalAdded.isHidden = false
            cell.savingsDeposited.isHidden = false
            cell.savingsDepositedLabel.isHidden = false
        }
        if (cell.reasonLabel.text!.count == 0) {
            cell.reasonLabel.text = "Nothing to see here!"
        }
        cell.personalFunds.textColor = UIColor.red
        cell.personalFundsLabel.textColor = UIColor.red
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
