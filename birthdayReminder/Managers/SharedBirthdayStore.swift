//
//  SharedBirthdayStore.swift
//  birthdayReminder
//

import Foundation
import WidgetKit

public struct BirthdayWidgetItem: Codable, Identifiable {
    public let id: String
    public let name: String
    public let birthDate: Date
    public let daysRemaining: Int
    public let formattedDate: String
    public let isToday: Bool

    public init(
        id: String,
        name: String,
        birthDate: Date,
        daysRemaining: Int,
        formattedDate: String,
        isToday: Bool
    ) {
        self.id = id
        self.name = name
        self.birthDate = birthDate
        self.daysRemaining = daysRemaining
        self.formattedDate = formattedDate
        self.isToday = isToday
    }
}

public class SharedBirthdayStore {
    public static let shared = SharedBirthdayStore()
    public static let appGroupID = "group.com.oguzhanerbas.birthdayReminder"
    private let userDefaultsKey = "saved_widget_birthdays"

    private var defaults: UserDefaults {
        if let groupDefaults = UserDefaults(suiteName: SharedBirthdayStore.appGroupID) {
            return groupDefaults
        }
        return .standard
    }

    func save(birthdays: [Birthday]) {
        let items = birthdays.map { b in
            BirthdayWidgetItem(
                id: b.id.uuidString,
                name: b.name,
                birthDate: b.date,
                daysRemaining: b.daysRemaining,
                formattedDate: b.formattedDateString,
                isToday: b.isToday
            )
        }
        saveItems(items)
    }

    public func saveItems(_ items: [BirthdayWidgetItem]) {
        if let data = try? JSONEncoder().encode(items) {
            if let groupDefaults = UserDefaults(suiteName: SharedBirthdayStore.appGroupID) {
                groupDefaults.set(data, forKey: userDefaultsKey)
            }
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
        WidgetCenter.shared.reloadAllTimelines()
    }

    public func loadBirthdays() -> [BirthdayWidgetItem] {
        if let groupDefaults = UserDefaults(suiteName: SharedBirthdayStore.appGroupID),
           let data = groupDefaults.data(forKey: userDefaultsKey),
           let items = try? JSONDecoder().decode([BirthdayWidgetItem].self, from: data) {
            return items.sorted(by: { $0.daysRemaining < $1.daysRemaining })
        }
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let items = try? JSONDecoder().decode([BirthdayWidgetItem].self, from: data) {
            return items.sorted(by: { $0.daysRemaining < $1.daysRemaining })
        }
        return []
    }
}
