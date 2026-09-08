//
//  CalenderViewController.swift
//  birthdayReminder
//

import UIKit

class CalenderViewController: UIViewController {

    private let calendarView = UICalendarView()
    private var birthdays: [Birthday] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupUI()
        setupConstraints()
        loadBirthdays()
        NotificationCenter.default.addObserver(self, selector: #selector(handleBirthdayUpdate), name: NSNotification.Name("BirthdayDidUpdateNotification"), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func handleBirthdayUpdate() {
        loadBirthdays()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBirthdays()
    }

    private func setupNavigation() {
        title = "Takvim"
        navigationController?.navigationBar.prefersLargeTitles = true

        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = AppColors.warmCream
        appearance.largeTitleTextAttributes = [
            .foregroundColor: AppColors.deepForestDarkGreen,
            .font: UIFont.sansSerif(size: 34, weight: .bold)
        ]
        appearance.titleTextAttributes = [
            .foregroundColor: AppColors.deepForestDarkGreen,
            .font: UIFont.sansSerif(size: 18, weight: .semibold)
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func setupUI() {
        view.backgroundColor = AppColors.warmCream

        // Calendar View Setup
        calendarView.calendar = Calendar.current
        calendarView.locale = Locale(identifier: "tr_TR")
        calendarView.tintColor = AppColors.richLeafGreen
        calendarView.layer.cornerRadius = 22
        calendarView.backgroundColor = .white
        calendarView.layer.borderWidth = 1.0
        calendarView.layer.borderColor = AppColors.pastelSand.withAlphaComponent(0.6).cgColor
        calendarView.layer.shadowColor = AppColors.deepForestDarkGreen.cgColor
        calendarView.layer.shadowOpacity = 0.08
        calendarView.layer.shadowOffset = CGSize(width: 0, height: 4)
        calendarView.layer.shadowRadius = 10

        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
        calendarView.delegate = self

        view.addSubview(calendarView)
    }

    private func setupConstraints() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func loadBirthdays() {
        birthdays = CoreDataManager.shared.fetchBirthdays()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        var allComponents: [DateComponents] = []
        for year in (currentYear - 1)...(currentYear + 2) {
            for b in birthdays {
                var comp = calendar.dateComponents([.month, .day], from: b.date)
                comp.year = year
                allComponents.append(comp)
            }
        }
        calendarView.reloadDecorations(forDateComponents: allComponents, animated: true)
    }
}

// MARK: - UICalendarViewDelegate & UICalendarSelectionSingleDateDelegate
extension CalenderViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {

    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        guard let date = dateComponents.date else { return nil }

        let dayBirthdays = birthdays.filter { birthday in
            let bComponents = Calendar.current.dateComponents([.month, .day], from: birthday.date)
            let dComponents = Calendar.current.dateComponents([.month, .day], from: date)
            return bComponents.month == dComponents.month && bComponents.day == dComponents.day
        }

        if !dayBirthdays.isEmpty {
            let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold)
            let image = UIImage(systemName: "birthday.cake.fill", withConfiguration: config)
            return .image(image, color: AppColors.richLeafGreen, size: .large)
        }
        return nil
    }

    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents = dateComponents, let date = dateComponents.date else { return }

        let selectedBirthdays = birthdays.filter { birthday in
            let bComponents = Calendar.current.dateComponents([.month, .day], from: birthday.date)
            let dComponents = Calendar.current.dateComponents([.month, .day], from: date)
            return bComponents.month == dComponents.month && bComponents.day == dComponents.day
        }

        guard let firstBirthday = selectedBirthdays.first else { return }

        let detailVC = BirthdayDetailViewController(birthday: firstBirthday)
        detailVC.onUpdate = { [weak self] in
            self?.loadBirthdays()
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
