//
//  SwitchTableViewCell.swift
//  myAlarm
//
//  Created by jdcorn on 11/12/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    // MARK: - Actions
    
    @IBAction func switchValueChanged(_ sender: Any) {
    }
    
} // Class end
