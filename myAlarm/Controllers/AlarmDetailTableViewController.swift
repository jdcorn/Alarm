//
//  AlarmDetailTableViewController.swift
//  myAlarm
//
//  Created by jdcorn on 11/12/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    // MARK: - Properties
    var alarm: Alarm? {
        didSet {
            updateViews()
            guard let enabled = alarm?.enabled else {return}
            alarmIsOn = enabled
        }
    }
    var alarmIsOn = true
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmName: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func enableButtonTapped(_ sender: Any) {
         guard let alarm = alarm else {return}
               AlarmController.sharedInstance.toogleEnabled(for: alarm)
        }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = alarmName.text, name != "" else {return}
        if let alarm = alarm {
            let updatedDate = datePicker.date
            AlarmController.sharedInstance.updateAlarm(alarm: alarm, fireDate: updatedDate, name: name, enabled: alarmIsOn)
        } else {
            AlarmController.sharedInstance.addAlarm(fireDate: datePicker.date, name: name, enabled: alarmIsOn)
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    func updateViews() {
        loadViewIfNeeded()
        enableButton.layer.cornerRadius = 20
        guard let alarm = alarm else {return}
        datePicker.date = alarm.fireDate
        alarmName.text = alarm.name
        if alarm.enabled {
            enableButton.setTitle("Disable", for: .normal)
            enableButton.backgroundColor = .red
            enableButton.setTitleColor(.white, for: .normal)
        }
    }

} // Class end
