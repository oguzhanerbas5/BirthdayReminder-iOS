//
//  Birthday.swift
//  birthdayReminder
//

import Foundation

struct Birthday {
    let id: UUID
    let name: String
    let date: Date
    let message: String
    var reminderHour: Int = 9
    var reminderMinute: Int = 0
    
    // MARK: - Computed Helpers
    
    var initials: String {
        let components = name.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")
        if components.count >= 2, let first = components.first?.first, let last = components.last?.first {
            return "\(first)\(last)".uppercased()
        } else if let firstChar = name.first {
            return String(firstChar).uppercased()
        }
        return ""
    }
    
    var nextBirthdayDate: Date {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let birthComponents = calendar.dateComponents([.month, .day], from: date)
        
        var currentYearComponents = calendar.dateComponents([.year], from: today)
        currentYearComponents.month = birthComponents.month
        currentYearComponents.day = birthComponents.day
        
        guard let thisYearBirthday = calendar.date(from: currentYearComponents) else {
            return date
        }
        
        let startOfThisYearBirthday = calendar.startOfDay(for: thisYearBirthday)
        
        if startOfThisYearBirthday >= today {
            return startOfThisYearBirthday
        } else {
            var nextYearComponents = currentYearComponents
            nextYearComponents.year = (currentYearComponents.year ?? 0) + 1
            return calendar.date(from: nextYearComponents) ?? date
        }
    }
    
    var daysRemaining: Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let targetDate = nextBirthdayDate
        let components = calendar.dateComponents([.day], from: today, to: targetDate)
        return max(0, components.day ?? 0)
    }
    
    var isToday: Bool {
        return daysRemaining == 0
    }
    
    var formattedDateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "dd MMMM"
        return formatter.string(from: date)
    }
    
    var formattedFullDateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
    
    var formattedReminderTimeString: String {
        return String(format: "%02d:%02d", reminderHour, reminderMinute)
    }
}
