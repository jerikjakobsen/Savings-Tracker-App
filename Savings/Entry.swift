//
//  Entry.swift
//  Savings
//
//  Created by John Jakobsen on 7/31/20.
//  Copyright © 2020 John Jakobsen. All rights reserved.
//

import Foundation

class Entry {
    let dateEntered: NSDate
    let amountEntered: Double
    let tipEntered: Double
    let typeOf: String
    let reasonFor: String
    let spendingPercent: Double
    let id: String
    init(amount: Double, tips: Double = 0.0, type: String = "Deposit Paycheck", reason: String = "", spendingPercentage: Double = 0.0, date: NSDate = NSDate(), uid: String = UUID().uuidString) {
        if type == "Withdrawal" && amount >= 0 && tips >= 0 {
            amountEntered = amount * -1
        } else {
            amountEntered = amount
        }
        tipEntered = tips
        id = uid
        dateEntered = date
        typeOf = type
        reasonFor = reason
        spendingPercent = spendingPercentage
    }
    func getID() -> String {
        return id
    }
    func amount() -> Double {
        return (amountEntered + tipEntered)
    }
    func typeOfEntry() -> String {
        return typeOf
    }
    func reasonForEntry() -> String {
        return reasonFor
    }
    func spendingAmount() -> Double {
        return amount() * spendingPercent
    }
    func total() -> Double {
        return amount() - spendingAmount()
    }
    func dateToTimeInterval() -> Double {
        return dateEntered.timeIntervalSinceReferenceDate
    }
}
