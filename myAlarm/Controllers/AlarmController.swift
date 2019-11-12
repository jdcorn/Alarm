//
//  AlarmController.swift
//  myAlarm
//
//  Created by jdcorn on 11/12/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler: class {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm) {
        let center = UNUserNotificationCenter.current()
        let notificationInstance = UNMutableNotificationContent()
        notificationInstance.title = "ALARM!"
        notificationInstance.body = alarm.name
        notificationInstance.sound = .default()
        
        let date = alarm.fireDate
        let components = Calendar.current.dateComponents([.hour,.minute], from: date)
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let notificationRequest = UNNotificationRequest(identifier: alarm.uuid, content: notificationInstance, trigger: notificationTrigger)
        
        center.add(notificationRequest)
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
    
    
}

class AlarmController: AlarmScheduler {
    // MARK: - Properties
    
    var alarms: [Alarm] = []
    
    static var sharedInstance = AlarmController()
    
    init () {
        loadFromPersistentStore()
    }
    
    // MARK: - CRUD Functions
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let alarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        self.alarms.append(alarm)
        scheduleUserNotifications(for: alarm)
        saveToPersistentStore()
    }
    
    func updateAlarm(alarm: Alarm, fireDate: Date, name: String, enabled: Bool){
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
        saveToPersistentStore()
        
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else { return }
        alarms.remove(at: index)
        cancelUserNotifications(for: alarm)
        saveToPersistentStore()
    }
    
    func toogleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        if alarm.enabled {
            scheduleUserNotifications(for: alarm)
        } else{
            cancelUserNotifications(for: alarm)
        }
        saveToPersistentStore()
    }
    
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectoryURL = paths[0].appendingPathComponent("alarm.json")
        return documentDirectoryURL
    }
    
    func saveToPersistentStore() {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(alarms)
            try data.write(to: fileURL())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadFromPersistentStore() {
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            let alarms = try decoder.decode([Alarm].self, from: data)
            self.alarms = alarms
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
} // Class end
