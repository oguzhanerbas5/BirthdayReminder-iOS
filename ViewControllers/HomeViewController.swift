//
//  HomeViewController.swift
//  birthdayReminder
//

import UIKit

class HomeViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let emptyStateView = EmptyStateView()

    private var allBirthdays: [Birthday] = []
    private var filteredBirthdays: [Birthday] = []

    // Header Hero Card View for vibrant visual appeal
    private let headerHeroCard = UIView()
    private let heroTitleLabel = UILabel()
    private let heroSubtitleLabel = UILabel()
    private let heroIconImageView = UIImageView()

    private let customTitleLabel = UILabel()
    private let customSearchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupUI()
        setupConstraints()
        loadData()
        NotificationCenter.default.addObserver(self, selector: #selector(handleBirthdayUpdate), name: NSNotification.Name("BirthdayDidUpdateNotification"), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        loadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setupNavigation() {
        // Navigation bar is hidden on this screen to move "Bugün" higher up and make the screen spacious.
        // Pushed child screens (like detail) will have standard navigation bar restored via viewWillDisappear.
    }

    @objc private func openGuideTapped() {
        let onboardingVC = OnboardingViewController()
        onboardingVC.isReplayMode = true
        onboardingVC.modalPresentationStyle = .fullScreen
        present(onboardingVC, animated: true)
    }

    @objc private func addBirthdayTapped() {
        tabBarController?.selectedIndex = 1
    }

    @objc private func handleBirthdayUpdate() {
        loadData()
    }

    private func setupUI() {
        view.backgroundColor = AppColors.warmCream

        customTitleLabel.text = "Bugün"
        customTitleLabel.font = .sansSerif(size: 34, weight: .bold)
        customTitleLabel.textColor = AppColors.deepForestDarkGreen
        customTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customTitleLabel)

        customSearchBar.placeholder = "Arkadaşlarında Ara..."
        customSearchBar.searchTextField.font = .sansSerif(size: 15)
        customSearchBar.searchTextField.backgroundColor = .white
        customSearchBar.tintColor = AppColors.deepForestDarkGreen
        customSearchBar.backgroundImage = UIImage()
        customSearchBar.backgroundColor = .clear
        customSearchBar.delegate = self
        customSearchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customSearchBar)

        setupHeaderHeroCard()

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BirthdayTableViewCell.self, forCellReuseIdentifier: BirthdayTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag

        view.addSubview(tableView)
        view.addSubview(emptyStateView)

        emptyStateView.isHidden = true
        emptyStateView.onAddButtonTapped = { [weak self] in
            self?.tabBarController?.selectedIndex = 1
        }
    }

    private func setupHeaderHeroCard() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 106))
        container.backgroundColor = .clear

        headerHeroCard.backgroundColor = AppColors.richLeafGreen
        headerHeroCard.layer.cornerRadius = 20
        headerHeroCard.layer.shadowColor = AppColors.deepForestDarkGreen.cgColor
        headerHeroCard.layer.shadowOpacity = 0.15
        headerHeroCard.layer.shadowOffset = CGSize(width: 0, height: 4)
        headerHeroCard.layer.shadowRadius = 10

        heroTitleLabel.text = "Günün Özeti"
        heroTitleLabel.font = .sansSerif(size: 18, weight: .bold)
        heroTitleLabel.textColor = .white

        heroSubtitleLabel.text = "Sevdiklerinizin özel günlerini kaçırmayın!"
        heroSubtitleLabel.font = .sansSerif(size: 13, weight: .medium)
        heroSubtitleLabel.textColor = UIColor.white.withAlphaComponent(0.9)
        heroSubtitleLabel.numberOfLines = 2

        if let appLogo = UIImage(named: "AppLogo") ?? UIImage(named: "AppIcon") {
            heroIconImageView.image = appLogo
            heroIconImageView.layer.cornerRadius = 12
            heroIconImageView.layer.masksToBounds = true
        } else {
            let giftConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .semibold)
            heroIconImageView.image = UIImage(systemName: "gift.fill", withConfiguration: giftConfig)
            heroIconImageView.tintColor = .white
        }
        heroIconImageView.contentMode = .scaleAspectFit

        headerHeroCard.addSubview(heroTitleLabel)
        headerHeroCard.addSubview(heroSubtitleLabel)
        headerHeroCard.addSubview(heroIconImageView)

        headerHeroCard.translatesAutoresizingMaskIntoConstraints = false
        heroTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        heroSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        heroIconImageView.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(headerHeroCard)

        NSLayoutConstraint.activate([
            headerHeroCard.topAnchor.constraint(equalTo: container.topAnchor, constant: 4),
            headerHeroCard.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            headerHeroCard.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            headerHeroCard.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8),

            heroTitleLabel.topAnchor.constraint(equalTo: headerHeroCard.topAnchor, constant: 16),
            heroTitleLabel.leadingAnchor.constraint(equalTo: headerHeroCard.leadingAnchor, constant: 18),
            heroTitleLabel.trailingAnchor.constraint(equalTo: heroIconImageView.leadingAnchor, constant: -12),

            heroSubtitleLabel.topAnchor.constraint(equalTo: heroTitleLabel.bottomAnchor, constant: 4),
            heroSubtitleLabel.leadingAnchor.constraint(equalTo: headerHeroCard.leadingAnchor, constant: 18),
            heroSubtitleLabel.trailingAnchor.constraint(equalTo: heroIconImageView.leadingAnchor, constant: -12),

            heroIconImageView.trailingAnchor.constraint(equalTo: headerHeroCard.trailingAnchor, constant: -18),
            heroIconImageView.centerYAnchor.constraint(equalTo: headerHeroCard.centerYAnchor),
            heroIconImageView.widthAnchor.constraint(equalToConstant: 44),
            heroIconImageView.heightAnchor.constraint(equalToConstant: 44)
        ])

        tableView.tableHeaderView = container
    }

    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            customTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            customTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            customTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            customSearchBar.topAnchor.constraint(equalTo: customTitleLabel.bottomAnchor, constant: 6),
            customSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            customSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            customSearchBar.heightAnchor.constraint(equalToConstant: 44),

            tableView.topAnchor.constraint(equalTo: customSearchBar.bottomAnchor, constant: 4),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            emptyStateView.topAnchor.constraint(equalTo: customSearchBar.bottomAnchor, constant: 20),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadData() {
        allBirthdays = CoreDataManager.shared.fetchBirthdays().sorted(by: { $0.daysRemaining < $1.daysRemaining })
        SharedBirthdayStore.shared.save(birthdays: allBirthdays)
        filterContentForSearchText(customSearchBar.text ?? "")
    }

    private func filterContentForSearchText(_ searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            filteredBirthdays = allBirthdays
        } else {
            filteredBirthdays = allBirthdays.filter { birthday in
                return birthday.name.lowercased().contains(searchText.lowercased())
            }
        }

        let count = filteredBirthdays.count
        if count == 0 {
            emptyStateView.isHidden = false
            tableView.isHidden = true
        } else {
            emptyStateView.isHidden = true
            tableView.isHidden = false

            let todayCount = filteredBirthdays.filter { $0.isToday }.count
            if todayCount > 0 {
                heroSubtitleLabel.text = "Bugüne ait \(todayCount) doğum günü var! Tebrik etmeyi unutmayın."
            } else if let nearest = filteredBirthdays.first {
                heroSubtitleLabel.text = "En yakın doğum günü: \(nearest.name) (\(nearest.daysRemaining) gün sonra)"
            } else {
                heroSubtitleLabel.text = "Sevdiklerinizin özel günlerini kaçırmayın!"
            }
        }

        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate & DataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBirthdays.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BirthdayTableViewCell.identifier, for: indexPath) as? BirthdayTableViewCell else {
            return UITableViewCell()
        }
        let birthday = filteredBirthdays[indexPath.row]
        cell.configure(with: birthday)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let birthday = filteredBirthdays[indexPath.row]
        let detailVC = BirthdayDetailViewController(birthday: birthday)
        detailVC.onUpdate = { [weak self] in
            self?.loadData()
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { [weak self] (_, _, completion) in
            guard let self = self else { return }
            let birthdayToDelete = self.filteredBirthdays[indexPath.row]
            CoreDataManager.shared.deleteBirthday(withId: birthdayToDelete.id)
            NotificationManager.shared.cancelNotification(for: birthdayToDelete)
            self.loadData()
            completion(true)
        }
        deleteAction.backgroundColor = AppColors.statusUrgent
        deleteAction.image = UIImage(systemName: "trash.fill")

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
