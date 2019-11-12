//
//  AlarmListTableViewController.swift
//  myAlarm
//
//  Created by jdcorn on 11/12/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.sharedInstance.alarms.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as?
            SwitchTableViewCell else {return UITableViewCell()}

        let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
        cell.alarm = alarm
        cell.updateViews()
        

        return cell
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
            AlarmController.sharedInstance.deleteAlarm(alarm: alarm)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    
    // MARK: - Navigation

    // IIDOO
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlarmDetail" {
            guard let index = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? AlarmDetailTableViewController else {return}
            let alarm = AlarmController.sharedInstance.alarms[index.row]
            destinationVC.alarm = alarm
        }
    }
    

}
