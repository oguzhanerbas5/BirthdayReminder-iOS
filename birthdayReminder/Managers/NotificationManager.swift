//
//  NotificationManager.swift
//  birthdayReminder
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func requestAuthorization(completion: ((Bool) -> Void)? = nil) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification authorization error: \(error)")
            }
            DispatchQueue.main.async {
                completion?(granted)
            }
        }
    }
    
    func scheduleNotification(for birthday: Birthday) {
        // Cancel existing notifications for this birthday first
        cancelNotification(for: birthday)
        
        let calendar = Calendar.current
        let birthComponents = calendar.dateComponents([.month, .day], from: birthday.date)
        
        guard let bMonth = birthComponents.month, let bDay = birthComponents.day else { return }
        
        // Base Date for calculation using current year
        let currentYear = calendar.component(.year, from: Date())
        var baseComponents = DateComponents()
        baseComponents.year = currentYear
        baseComponents.month = bMonth
        baseComponents.day = bDay
        baseComponents.hour = 9
        baseComponents.minute = 0
        
        guard let thisYearBirthdayDate = calendar.date(from: baseComponents) else { return }
        
        // 1. Gününde (Saat 09:00)
        let todayContent = UNMutableNotificationContent()
        todayContent.title = "BUGÜN \(birthday.name.uppercased())'İN DOĞUM GÜNÜ!"
        todayContent.body = birthday.message.isEmpty ? "Bugün kutlama zamanı! Güzel bir mesaj göndermeyi unutma." : "Hazırladığın Mesaj: \"\(birthday.message)\""
        todayContent.sound = .default
        
        var todayComponents = DateComponents()
        todayComponents.month = bMonth
        todayComponents.day = bDay
        todayComponents.hour = 9
        todayComponents.minute = 0
        
        let todayTrigger = UNCalendarNotificationTrigger(dateMatching: todayComponents, repeats: true)
        let todayRequest = UNNotificationRequest(identifier: "\(birthday.id.uuidString)_today", content: todayContent, trigger: todayTrigger)
        UNUserNotificationCenter.current().add(todayRequest)
        
        // 2. 1 Gün Önce (Saat 09:00)
        if let oneDayBeforeDate = calendar.date(byAdding: .day, value: -1, to: thisYearBirthdayDate) {
            let oneDayComp = calendar.dateComponents([.month, .day], from: oneDayBeforeDate)
            
            let oneDayContent = UNMutableNotificationContent()
            oneDayContent.title = "Yarın \(birthday.name)'in Doğum Günü!"
            oneDayContent.body = "Özel gün yarın! Mesajın hazır mı?"
            oneDayContent.sound = .default
            
            var triggerComp = DateComponents()
            triggerComp.month = oneDayComp.month
            triggerComp.day = oneDayComp.day
            triggerComp.hour = 9
            triggerComp.minute = 0
            
            let oneDayTrigger = UNCalendarNotificationTrigger(dateMatching: triggerComp, repeats: true)
            let oneDayRequest = UNNotificationRequest(identifier: "\(birthday.id.uuidString)_1day", content: oneDayContent, trigger: oneDayTrigger)
            UNUserNotificationCenter.current().add(oneDayRequest)
        }
        
        // 3. 1 Hafta (7 Gün) Önce (Saat 09:00)
        if let oneWeekBeforeDate = calendar.date(byAdding: .day, value: -7, to: thisYearBirthdayDate) {
            let oneWeekComp = calendar.dateComponents([.month, .day], from: oneWeekBeforeDate)
            
            let oneWeekContent = UNMutableNotificationContent()
            oneWeekContent.title = "1 Hafta Kaldı: \(birthday.name)'in Doğum Günü"
            oneWeekContent.body = "Doğum gününe 1 hafta kaldı. Mesajını veya hediyeni hazırlamak için harika bir zaman!"
            oneWeekContent.sound = .default
            
            var triggerComp = DateComponents()
            triggerComp.month = oneWeekComp.month
            triggerComp.day = oneWeekComp.day
            triggerComp.hour = 9
            triggerComp.minute = 0
            
            let oneWeekTrigger = UNCalendarNotificationTrigger(dateMatching: triggerComp, repeats: true)
            let oneWeekRequest = UNNotificationRequest(identifier: "\(birthday.id.uuidString)_1week", content: oneWeekContent, trigger: oneWeekTrigger)
            UNUserNotificationCenter.current().add(oneWeekRequest)
        }
    }
    
    func cancelNotification(for birthday: Birthday) {
        let identifiers = [
            "\(birthday.id.uuidString)_today",
            "\(birthday.id.uuidString)_1day",
            "\(birthday.id.uuidString)_1week"
        ]
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}
