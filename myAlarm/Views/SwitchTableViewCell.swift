//
//  SwitchTableViewCell.swift
//  myAlarm
//
//  Created by jdcorn on 11/12/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    // MARK: - Properties
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    // MARK: - Actions
    @IBAction func switchValueChanged(_ sender: Any) {
    }
    
    // MARK: - Functions
    func updateViews() {
        guard let alarm = alarm else {return}
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
    }
} // Class end
