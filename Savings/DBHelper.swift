//
//  DBHelper.swift
//  Savings
//
//  Created by John Jakobsen on 8/3/20.
//  Copyright © 2020 John Jakobsen. All rights reserved.
//

import Foundation
import SQLite3

class DBHelper {
    init() {
        db = openDatabase()
        createTable()
    }
    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS Entry(Id TEXT PRIMARY KEY, amountEntered REAL, tipEntered REAL, typeOf TEXT, reasonFor TEXT, spendingPercent REAL, dateEntered TIMESTAMP);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Entry table created.")
            } else {
                print("Entry table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(entry: Entry)
    {
        let entries = read()
        let id = entry.id
        for e in entries
        {
            if e.id == id
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO Entry (Id, amountEntered, tipEntered, typeOf, reasonFor, spendingPercent, dateEntered) VALUES (?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (id as NSString).utf8String, -1, nil )
            sqlite3_bind_double(insertStatement, 2, entry.amountEntered)
            sqlite3_bind_double(insertStatement, 3, entry.tipEntered)
            sqlite3_bind_text(insertStatement, 4, (entry.typeOf as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (entry.reasonFor as NSString).utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 6, entry.spendingPercent)
            sqlite3_bind_double(insertStatement, 7, entry.dateToTimeInterval())
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [Entry] {
        let queryStatementString = "SELECT * FROM Entry;"
        var queryStatement: OpaquePointer? = nil
        var entries : [Entry] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id  = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let amount = sqlite3_column_double(queryStatement, 1)
                let tips = sqlite3_column_double(queryStatement, 2)
                let type = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let reason = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let spendingPercent = sqlite3_column_double(queryStatement, 5)
                let date = NSDate(timeIntervalSinceReferenceDate: sqlite3_column_double(queryStatement, 6))
                entries.append(Entry(amount: amount, tips: tips, type: type, reason: reason, spendingPercentage: spendingPercent, date: date, uid: id))
                
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return entries
    }
    func flush() {
        let deleteStatementString = "DELETE FROM Entry"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
                if sqlite3_step(deleteStatement) == SQLITE_DONE {
                    print("Successfully flushed Entry table")
                } else {
                    print("Could not delete row.")
                }
            } else {
                print("DELETE statement could not be prepared")
            }
            sqlite3_finalize(deleteStatement)
        }
    
    func deleteByID(id: String) {
        let deleteStatementString = "DELETE FROM Entry WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(deleteStatement, 1, (id as NSString).utf8String, -1, nil )
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
}
