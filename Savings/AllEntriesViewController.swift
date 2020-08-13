//
//  AllEntriesViewController.swift
//  Savings
//
//  Created by John Jakobsen on 8/5/20.
//  Copyright © 2020 John Jakobsen. All rights reserved.
//

import UIKit

class AllEntriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var allEntries = [Entry]()
    override func viewDidLoad() {
        super.viewDidLoad()
//        for i in 0..<allEntries.count {
//
//        }
        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // 2
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    // 3
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carCell", for: indexPath)

        cell.textLabel?.text = cars[indexPath.row]

        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
