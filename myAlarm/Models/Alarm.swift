//
//  Alarm.swift
//  myAlarm
//
//  Created by jdcorn on 11/12/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import Foundation

// Alarm class that contains the Alarm model object.
// This model will represent a name, if it's on or off, UUID, a time to go off, string rep of that time.
class Alarm {
    // MARK: - Properies
    
    // fireDate stores a date representing the time the alarm will go off.
    var fireDate: Date
    var name: String
    var enabled: Bool
    
    // UUID, universally unique identifer - used to schedule and cancel local notifications
    var uuid: String
    
    init(fireDate: Date, name: String, enabled: Bool, uuid: String = UUID().uuidString) {
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
    }
    
    // Computable property
    // Returns a string representation of the time the alarm is set to fire
    var fireTimeAsString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        let result = formatter.string(from: fireDate)
        return result
    }
    
} // Class end
