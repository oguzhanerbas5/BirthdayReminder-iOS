//
//  MainTabBarController.swift
//  birthdayReminder
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupAppearance()
        selectedIndex = 2
    }

    private func setupTabs() {
        let homeVC = HomeViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(
            title: "Bugün",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        let addVC = AddBirthdayViewController()
        let addNav = UINavigationController(rootViewController: addVC)
        addNav.tabBarItem = UITabBarItem(
            title: "Ekle",
            image: UIImage(systemName: "plus.circle"),
            selectedImage: UIImage(systemName: "plus.circle.fill")
        )

        let calendarVC = CalenderViewController()
        let calendarNav = UINavigationController(rootViewController: calendarVC)
        calendarNav.tabBarItem = UITabBarItem(
            title: "Takvim",
            image: UIImage(systemName: "calendar"),
            selectedImage: UIImage(systemName: "calendar.badge.clock")
        )

        viewControllers = [homeNav, addNav, calendarNav]
    }

    private func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = AppColors.warmCream

        let selectedColor = AppColors.richLeafGreen
        let unselectedColor = AppColors.deepForestDarkGreen.withAlphaComponent(0.6)

        appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: selectedColor,
            .font: UIFont.sansSerif(size: 11, weight: .bold)
        ]

        appearance.stackedLayoutAppearance.normal.iconColor = unselectedColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: unselectedColor,
            .font: UIFont.sansSerif(size: 11, weight: .medium)
        ]

        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        tabBar.tintColor = selectedColor
    }
}
