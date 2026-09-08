# 🎂 Birthday Reminder

A modern, native UIKit-based iOS application for managing birthdays, scheduling custom local reminders, preparing celebration messages, and tracking upcoming dates.

---

## 🚀 Key Features

* **🎂 Birthday Management & Local Storage (Core Data)**
  * Save, edit, and delete birthdays with persistent Core Data storage.
  * Automatic sorting by upcoming birthdays.

* **🔔 Custom Local Notifications**
  * Schedule annual repeating local notifications at a custom time (hour & minute) tailored for each person.
  * Instant permission management via `UserNotifications`.

* **🔍 Search & Filtering**
  * Live search bar to filter birthdays by name or birth month.

* **💬 Ready Message Templates & Sharing**
  * Quick-select message templates (Classic, Fun, Emotional) that dynamically fill recipient names.
  * One-tap **Copy Message** to clipboard and **Share** via SMS, WhatsApp, Mail, and social apps (`UIActivityViewController`).

* **🗓️ Interactive Calendar View**
  * Modern `UICalendarView` integration with custom pink badge decorations on birthday dates.
  * Single date selection to view birthdays occurring on that specific day.

* **📱 Modern iOS UI & Aesthetics**
  * UIKit, Auto Layout, SF Symbols, custom cards, initials avatar badges, countdown indicators ("🎉 BUGÜN!", "X gün kaldı").

---

## 🛠️ Architecture & Technologies

* **Swift 5** & **UIKit** (100% Programmatic UI with Auto Layout)
* **Core Data** (`CoreDataManager` for persistent CRUD operations)
* **UserNotifications** (`NotificationManager` for annual calendar notification triggers)
* **UICalendarView** & **UITableView**
* **MVC Pattern** & **Delegate Pattern** (`BirthdayDelegate`)

---

## 📱 Tab Bar Structure

1. **Ana Sayfa (`HomeViewController`)**: List of upcoming birthdays, search bar, swipe-to-delete, empty state view.
2. **Ekle (`AddBirthdayViewController`)**: Add/Edit birthday form with date picker, custom notification time picker, and preset templates.
3. **Takvim (`CalenderViewController`)**: Visual calendar displaying marked birthday dates and daily breakdown.
