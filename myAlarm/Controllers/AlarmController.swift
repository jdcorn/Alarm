//
//  AlarmController.swift
//  myAlarm
//
//  Created by jdcorn on 11/12/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import Foundation

class AlarmController {
    // MARK: - Properties
    
    var alarms: [Alarm] = []
    
    static var sharedInstance = AlarmController()
    
    // MARK: - CRUD Functions
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let alarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        self.alarms.append(alarm)
    }
    
    func updateAlarm(alarm: Alarm, fireDate: Date, name: String, enabled: Bool){
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else { return }
        alarms.remove(at: index)
        
    }
    
    
} // Class end
