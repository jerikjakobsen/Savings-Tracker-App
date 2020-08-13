//
//  TableViewCell.swift
//  Savings
//
//  Created by John Jakobsen on 8/5/20.
//  Copyright © 2020 John Jakobsen. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var personalFundsLabel: UILabel!
    @IBOutlet weak var totalAddedLabel: UILabel!
    @IBOutlet weak var personalFunds: UILabel!
    @IBOutlet weak var totalAdded: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var reasonlabelLabel: UILabel!
    @IBOutlet weak var savingsDeposited: UILabel!
    @IBOutlet weak var amountsView: UIView!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var reasonDivider: UIView!
    @IBOutlet weak var savingsDepositedLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
