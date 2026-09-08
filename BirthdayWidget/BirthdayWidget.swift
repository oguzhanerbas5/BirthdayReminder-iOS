//
//  BirthdayWidget.swift
//  BirthdayWidget
//

import WidgetKit
import SwiftUI

// MARK: - App Group Store for Widget Target
// Compiled into both app and extension to ensure data persistence
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

// MARK: - Timeline Entry & Provider

struct BirthdayEntry: TimelineEntry {
    let date: Date
    let birthdays: [BirthdayWidgetItem]
    let isPreview: Bool
}

struct BirthdayTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> BirthdayEntry {
        BirthdayEntry(date: Date(), birthdays: sampleBirthdays, isPreview: true)
    }

    func getSnapshot(in context: Context, completion: @escaping (BirthdayEntry) -> Void) {
        let loaded = SharedBirthdayStore.shared.loadBirthdays()
        let birthdays = loaded.isEmpty ? sampleBirthdays : loaded
        let entry = BirthdayEntry(date: Date(), birthdays: birthdays, isPreview: context.isPreview)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<BirthdayEntry>) -> Void) {
        let loaded = SharedBirthdayStore.shared.loadBirthdays()
        let currentDate = Date()
        let entry = BirthdayEntry(date: currentDate, birthdays: loaded, isPreview: false)

        let calendar = Calendar.current
        let nextUpdate = calendar.date(byAdding: .hour, value: 2, to: currentDate) ?? currentDate.addingTimeInterval(3600)
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }

    private var sampleBirthdays: [BirthdayWidgetItem] {
        [
            BirthdayWidgetItem(id: "1", name: "Kankam Mert", birthDate: Date(), daysRemaining: 9, formattedDate: "18 Eylül", isToday: false),
            BirthdayWidgetItem(id: "2", name: "Teyzem Canan", birthDate: Date(), daysRemaining: 23, formattedDate: "02 Ekim", isToday: false),
            BirthdayWidgetItem(id: "3", name: "İş Arkadaşım Ayşe", birthDate: Date(), daysRemaining: 39, formattedDate: "18 Ekim", isToday: false)
        ]
    }
}

// MARK: - Color Palette
private let warmCream = Color(red: 0.99, green: 0.98, blue: 0.97)
private let deepForestGreen = Color(red: 0.11, green: 0.23, blue: 0.17)
private let leafGreen = Color(red: 0.18, green: 0.44, blue: 0.25)
private let statusOrange = Color(red: 0.90, green: 0.49, blue: 0.13)
private let softSage = Color(red: 0.92, green: 0.95, blue: 0.93)

// MARK: - View Compatibility Helper
extension View {
    @ViewBuilder
    func widgetBackground(_ color: Color) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            containerBackground(for: .widget) {
                color
            }
        } else {
            background(color)
        }
    }
}

// MARK: - Small Widget View
struct SmallBirthdayView: View {
    let entry: BirthdayEntry

    var todayBirthday: BirthdayWidgetItem? {
        entry.birthdays.first(where: { $0.isToday })
    }

    var nextBirthday: BirthdayWidgetItem? {
        entry.birthdays.first(where: { !$0.isToday })
    }

    var secondBirthday: BirthdayWidgetItem? {
        let upcoming = entry.birthdays.filter { !$0.isToday }
        return upcoming.count > 1 ? upcoming[1] : nil
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // Header
            HStack(spacing: 5) {
                Image(systemName: "gift.fill")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(leafGreen)
                Text("Doğum Günleri")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(deepForestGreen)
                Spacer()
            }

            if let today = todayBirthday {
                // Special Today Card
                VStack(alignment: .leading, spacing: 3) {
                    Text("🎉 BUGÜN!")
                        .font(.system(size: 11, weight: .heavy))
                        .foregroundColor(.white)
                    Text(today.name)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                    Text("İyi ki doğdun! 🎂")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(Color.white.opacity(0.9))
                }
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(leafGreen)
                )
            } else if let next = nextBirthday {
                // Upcoming Birthday Card
                VStack(alignment: .leading, spacing: 3) {
                    Text(next.name)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(deepForestGreen)
                        .lineLimit(1)

                    Text(next.formattedDate)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color.secondary)

                    Spacer(minLength: 2)

                    HStack {
                        Text("\(next.daysRemaining) gün kaldı")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                Capsule()
                                    .fill(next.daysRemaining <= 7 ? statusOrange : leafGreen)
                            )
                        Spacer()
                    }
                }
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.04), radius: 3, x: 0, y: 1)
                )

                if let second = secondBirthday {
                    Text("Sonraki: \(second.name) (\(second.daysRemaining)g)")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(deepForestGreen.opacity(0.7))
                        .lineLimit(1)
                }
            } else {
                Spacer()
                VStack(spacing: 4) {
                    Image(systemName: "calendar.badge.plus")
                        .font(.system(size: 22))
                        .foregroundColor(leafGreen)
                    Text("Yaklaşan doğum günü yok")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(Color.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }
        }
        .padding(12)
    }
}

// MARK: - Medium Widget View
struct MediumBirthdayView: View {
    let entry: BirthdayEntry

    var displayItems: [BirthdayWidgetItem] {
        Array(entry.birthdays.prefix(3))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header
            HStack(spacing: 6) {
                Image(systemName: "gift.fill")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(leafGreen)
                Text("Yaklaşan Doğum Günleri")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(deepForestGreen)
                Spacer()
                if !entry.birthdays.isEmpty {
                    Text("\(entry.birthdays.count) kişi")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(deepForestGreen.opacity(0.6))
                }
            }

            if displayItems.isEmpty {
                Spacer()
                HStack {
                    Spacer()
                    VStack(spacing: 4) {
                        Image(systemName: "calendar.badge.clock")
                            .font(.system(size: 24))
                            .foregroundColor(leafGreen)
                        Text("Henüz yaklaşan doğum günü bulunmuyor")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color.secondary)
                    }
                    Spacer()
                }
                Spacer()
            } else {
                VStack(spacing: 6) {
                    ForEach(displayItems) { item in
                        HStack(spacing: 8) {
                            // Avatar Icon
                            ZStack {
                                Circle()
                                    .fill(item.isToday ? leafGreen : softSage)
                                    .frame(width: 28, height: 28)
                                Text(item.isToday ? "🎂" : String(item.name.prefix(1)).uppercased())
                                    .font(.system(size: item.isToday ? 13 : 12, weight: .bold))
                                    .foregroundColor(item.isToday ? .white : deepForestGreen)
                            }

                            // Name & Date
                            VStack(alignment: .leading, spacing: 1) {
                                Text(item.name)
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(deepForestGreen)
                                    .lineLimit(1)
                                Text(item.formattedDate)
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundColor(Color.secondary)
                            }

                            Spacer()

                            // Days Remaining Badge
                            if item.isToday {
                                Text("Bugün 🎉")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 9)
                                    .padding(.vertical, 4)
                                    .background(Capsule().fill(leafGreen))
                            } else {
                                Text("\(item.daysRemaining) gün kaldı")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(
                                        Capsule()
                                            .fill(item.daysRemaining <= 7 ? statusOrange : leafGreen)
                                    )
                            }
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                        )
                    }
                }
            }
        }
        .padding(12)
    }
}

// MARK: - Lock Screen Views (iOS 16+)

struct InlineLockScreenView: View {
    let entry: BirthdayEntry

    var body: some View {
        if let today = entry.birthdays.first(where: { $0.isToday }) {
            Text("🎂 Bugün: \(today.name)")
        } else if let next = entry.birthdays.first {
            Text("🎂 \(next.name): \(next.daysRemaining)g kaldı")
        } else {
            Text("🎂 Doğum günü yok")
        }
    }
}

struct CircularLockScreenView: View {
    let entry: BirthdayEntry

    var body: some View {
        ZStack {
            AccessoryWidgetBackground()
            VStack(spacing: 1) {
                Image(systemName: "birthday.cake.fill")
                    .font(.system(size: 13, weight: .bold))

                if let today = entry.birthdays.first(where: { $0.isToday }) {
                    Text("Bugün")
                        .font(.system(size: 9, weight: .heavy))
                } else if let next = entry.birthdays.first {
                    Text("\(next.daysRemaining)g")
                        .font(.system(size: 11, weight: .bold))
                } else {
                    Text("-")
                        .font(.system(size: 11, weight: .bold))
                }
            }
        }
    }
}

struct RectangularLockScreenView: View {
    let entry: BirthdayEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 4) {
                Image(systemName: "birthday.cake.fill")
                    .font(.system(size: 11, weight: .bold))
                Text("DOĞUM GÜNÜ")
                    .font(.system(size: 10, weight: .semibold))
            }

            if let today = entry.birthdays.first(where: { $0.isToday }) {
                Text(today.name)
                    .font(.system(size: 13, weight: .bold))
                    .lineLimit(1)
                Text("🎉 Bugün kutlanıyor!")
                    .font(.system(size: 11, weight: .medium))
            } else if let next = entry.birthdays.first {
                Text(next.name)
                    .font(.system(size: 13, weight: .bold))
                    .lineLimit(1)
                Text("\(next.formattedDate) • \(next.daysRemaining) gün kaldı")
                    .font(.system(size: 11, weight: .regular))
                    .lineLimit(1)
            } else {
                Text("Yaklaşan yok")
                    .font(.system(size: 12, weight: .medium))
            }
        }
    }
}

// MARK: - Root Entry View
struct BirthdayWidgetEntryView: View {
    var entry: BirthdayTimelineProvider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            SmallBirthdayView(entry: entry)
                .widgetBackground(warmCream)
        case .systemMedium:
            MediumBirthdayView(entry: entry)
                .widgetBackground(warmCream)
        case .accessoryInline:
            InlineLockScreenView(entry: entry)
        case .accessoryCircular:
            CircularLockScreenView(entry: entry)
        case .accessoryRectangular:
            RectangularLockScreenView(entry: entry)
        @unknown default:
            SmallBirthdayView(entry: entry)
                .widgetBackground(warmCream)
        }
    }
}

// MARK: - Widget Configuration
struct BirthdayWidget: Widget {
    let kind: String = "BirthdayWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: BirthdayTimelineProvider()) { entry in
            BirthdayWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Doğum Günü Hatırlatıcı")
        .description("Yaklaşan doğum günlerini ve kalan gün sayısını görün.")
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .accessoryInline,
            .accessoryCircular,
            .accessoryRectangular
        ])
    }
}
