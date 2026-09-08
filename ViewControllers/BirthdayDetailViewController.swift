//
//  BirthdayDetailViewController.swift
//  birthdayReminder
//

import UIKit

class BirthdayDetailViewController: UIViewController {

    private var birthday: Birthday
    var onUpdate: (() -> Void)?

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()

    // Header Card
    private let headerCard = UIView()
    private let nameLabel = UILabel()
    private let badgeContainer = UIView()
    private let badgeLabel = UILabel()
    private let dateInfoLabel = UILabel()

    // Message Card
    private let messageCard = UIView()
    private let messageTitleStackView = UIStackView()
    private let messageTitleIcon = UIImageView()
    private let messageTitleLabel = UILabel()
    private let messageBodyLabel = UILabel()
    private let actionButtonsStackView = UIStackView()
    private let copyButton = UIButton(type: .system)
    private let shareButton = UIButton(type: .system)

    // Footer Actions
    private let editButton = UIButton(type: .system)
    private let deleteButton = UIButton(type: .system)

    init(birthday: Birthday) {
        self.birthday = birthday
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupUI()
        setupConstraints()
        configureData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }

    private func setupNavigation() {
        title = birthday.name
        navigationItem.largeTitleDisplayMode = .never
    }

    private func setupUI() {
        view.backgroundColor = AppColors.warmCream

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fill

        // MARK: 1. Header Card
        headerCard.backgroundColor = .white
        headerCard.layer.cornerRadius = 20
        headerCard.layer.borderWidth = 1.0
        headerCard.layer.borderColor = AppColors.pastelSand.withAlphaComponent(0.6).cgColor
        headerCard.layer.shadowColor = AppColors.deepForestDarkGreen.cgColor
        headerCard.layer.shadowOpacity = 0.08
        headerCard.layer.shadowOffset = CGSize(width: 0, height: 4)
        headerCard.layer.shadowRadius = 8

        nameLabel.font = .sansSerif(size: 26, weight: .bold)
        nameLabel.textColor = AppColors.deepForestDarkGreen
        nameLabel.textAlignment = .center

        badgeContainer.layer.cornerRadius = 12
        badgeContainer.layer.masksToBounds = true

        badgeLabel.font = .sansSerif(size: 13, weight: .bold)
        badgeLabel.textColor = .white
        badgeLabel.textAlignment = .center

        dateInfoLabel.font = .sansSerif(size: 14, weight: .medium)
        dateInfoLabel.textColor = AppColors.deepForestDarkGreen.withAlphaComponent(0.75)
        dateInfoLabel.textAlignment = .center
        dateInfoLabel.numberOfLines = 0

        let headerStackView = UIStackView(arrangedSubviews: [nameLabel, badgeContainer, dateInfoLabel])
        headerStackView.axis = .vertical
        headerStackView.alignment = .center
        headerStackView.spacing = 12
        headerStackView.translatesAutoresizingMaskIntoConstraints = false

        badgeContainer.addSubview(badgeLabel)
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            badgeLabel.topAnchor.constraint(equalTo: badgeContainer.topAnchor, constant: 6),
            badgeLabel.bottomAnchor.constraint(equalTo: badgeContainer.bottomAnchor, constant: -6),
            badgeLabel.leadingAnchor.constraint(equalTo: badgeContainer.leadingAnchor, constant: 14),
            badgeLabel.trailingAnchor.constraint(equalTo: badgeContainer.trailingAnchor, constant: -14)
        ])

        headerCard.addSubview(headerStackView)
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: headerCard.topAnchor, constant: 22),
            headerStackView.bottomAnchor.constraint(equalTo: headerCard.bottomAnchor, constant: -22),
            headerStackView.leadingAnchor.constraint(equalTo: headerCard.leadingAnchor, constant: 16),
            headerStackView.trailingAnchor.constraint(equalTo: headerCard.trailingAnchor, constant: -16)
        ])

        // MARK: 2. Message Card
        messageCard.backgroundColor = .white
        messageCard.layer.cornerRadius = 20
        messageCard.layer.borderWidth = 1.0
        messageCard.layer.borderColor = AppColors.pastelSand.withAlphaComponent(0.6).cgColor
        messageCard.layer.shadowColor = AppColors.deepForestDarkGreen.cgColor
        messageCard.layer.shadowOpacity = 0.08
        messageCard.layer.shadowOffset = CGSize(width: 0, height: 4)
        messageCard.layer.shadowRadius = 8

        let iconConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        messageTitleIcon.image = UIImage(systemName: "quote.bubble.fill", withConfiguration: iconConfig)
        messageTitleIcon.tintColor = AppColors.richLeafGreen
        messageTitleIcon.contentMode = .scaleAspectFit

        messageTitleLabel.text = "HAZIRLANAN MESAJ"
        messageTitleLabel.font = .sansSerif(size: 13, weight: .bold)
        messageTitleLabel.textColor = AppColors.deepForestDarkGreen

        messageTitleStackView.axis = .horizontal
        messageTitleStackView.spacing = 8
        messageTitleStackView.alignment = .center
        messageTitleStackView.addArrangedSubview(messageTitleIcon)
        messageTitleStackView.addArrangedSubview(messageTitleLabel)

        messageBodyLabel.font = .sansSerif(size: 16, weight: .regular)
        messageBodyLabel.textColor = .label
        messageBodyLabel.numberOfLines = 0

        actionButtonsStackView.axis = .horizontal
        actionButtonsStackView.spacing = 12
        actionButtonsStackView.distribution = .fillEqually

        copyButton.setTitle(" Mesajı Kopyala", for: .normal)
        copyButton.setImage(UIImage(systemName: "doc.on.doc.fill"), for: .normal)
        copyButton.tintColor = .white
        copyButton.titleLabel?.font = .sansSerif(size: 14, weight: .bold)
        copyButton.backgroundColor = AppColors.richLeafGreen
        copyButton.setTitleColor(.white, for: .normal)
        copyButton.layer.cornerRadius = 14
        copyButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        copyButton.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)

        shareButton.setTitle(" Paylaş", for: .normal)
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = AppColors.deepForestDarkGreen
        shareButton.titleLabel?.font = .sansSerif(size: 14, weight: .bold)
        shareButton.backgroundColor = AppColors.pastelSand.withAlphaComponent(0.5)
        shareButton.setTitleColor(AppColors.deepForestDarkGreen, for: .normal)
        shareButton.layer.cornerRadius = 14
        shareButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)

        actionButtonsStackView.addArrangedSubview(copyButton)
        actionButtonsStackView.addArrangedSubview(shareButton)

        let messageStackView = UIStackView(arrangedSubviews: [messageTitleStackView, messageBodyLabel, actionButtonsStackView])
        messageStackView.axis = .vertical
        messageStackView.spacing = 14
        messageStackView.translatesAutoresizingMaskIntoConstraints = false

        messageCard.addSubview(messageStackView)
        NSLayoutConstraint.activate([
            messageStackView.topAnchor.constraint(equalTo: messageCard.topAnchor, constant: 16),
            messageStackView.bottomAnchor.constraint(equalTo: messageCard.bottomAnchor, constant: -16),
            messageStackView.leadingAnchor.constraint(equalTo: messageCard.leadingAnchor, constant: 16),
            messageStackView.trailingAnchor.constraint(equalTo: messageCard.trailingAnchor, constant: -16)
        ])

        // MARK: 3. Footer Action Buttons
        editButton.setTitle(" Düzenle", for: .normal)
        editButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        editButton.tintColor = AppColors.deepForestDarkGreen
        editButton.titleLabel?.font = .sansSerif(size: 16, weight: .bold)
        editButton.backgroundColor = AppColors.pastelSand.withAlphaComponent(0.5)
        editButton.setTitleColor(AppColors.deepForestDarkGreen, for: .normal)
        editButton.layer.cornerRadius = 14
        editButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)

        deleteButton.setTitle(" Sil", for: .normal)
        deleteButton.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        deleteButton.tintColor = AppColors.statusUrgent
        deleteButton.titleLabel?.font = .sansSerif(size: 16, weight: .bold)
        deleteButton.backgroundColor = AppColors.statusUrgent.withAlphaComponent(0.12)
        deleteButton.setTitleColor(AppColors.statusUrgent, for: .normal)
        deleteButton.layer.cornerRadius = 14
        deleteButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)

        // Assemble Main Stack
        stackView.addArrangedSubview(headerCard)
        stackView.addArrangedSubview(messageCard)
        stackView.addArrangedSubview(editButton)
        stackView.addArrangedSubview(deleteButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }

    private func configureData() {
        nameLabel.text = birthday.name
        dateInfoLabel.text = "Doğum Tarihi: \(birthday.formattedFullDateString)\nHatırlatmalar: 1 Hafta Önce • 1 Gün Önce • Doğum Günü (09:00)"

        let days = birthday.daysRemaining
        if birthday.isToday {
            badgeContainer.backgroundColor = AppColors.statusUrgent
            badgeLabel.text = "BUGÜN DOĞUM GÜNÜ!"
        } else if days <= 7 {
            badgeContainer.backgroundColor = AppColors.statusUrgent
            badgeLabel.text = "\(days) gün kaldı"
        } else if days <= 30 {
            badgeContainer.backgroundColor = AppColors.statusSoon
            badgeLabel.text = "\(days) gün kaldı"
        } else if days <= 90 {
            badgeContainer.backgroundColor = AppColors.deepForestDarkGreen
            badgeLabel.text = "\(days) gün kaldı"
        } else {
            badgeContainer.backgroundColor = AppColors.richLeafGreen
            badgeLabel.text = "\(days) gün kaldı"
        }

        if birthday.message.isEmpty {
            messageBodyLabel.text = "Hazırlanmış bir mesaj bulunmuyor."
            messageBodyLabel.textColor = .secondaryLabel
        } else {
            messageBodyLabel.text = "\"\(birthday.message)\""
            messageBodyLabel.textColor = .label
        }
    }
    
    private func refreshData() {
        let birthdays = CoreDataManager.shared.fetchBirthdays()
        if let updated = birthdays.first(where: { $0.id == birthday.id }) {
            self.birthday = updated
            configureData()
        }
    }

    // MARK: - Actions

    @objc private func copyButtonTapped() {
        guard !birthday.message.isEmpty else {
            showAlert(title: "Bilgi", message: "Kopyalanacak mesaj eklenmemiş.")
            return
        }
        UIPasteboard.general.string = birthday.message
        showAlert(title: "Kopyalandı", message: "Hazırlanan mesaj panoya kopyalandı.")
    }

    @objc private func shareButtonTapped() {
        let textToShare = birthday.message.isEmpty ? "Doğum günün kutlu olsun \(birthday.name)!" : birthday.message
        let activityVC = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        if let popover = activityVC.popoverPresentationController {
            popover.sourceView = shareButton
            popover.sourceRect = shareButton.bounds
            popover.permittedArrowDirections = [.up, .down]
        }
        present(activityVC, animated: true)
    }

    @objc private func editButtonTapped() {
        let editVC = AddBirthdayViewController()
        editVC.birthdayToEdit = birthday
        navigationController?.pushViewController(editVC, animated: true)
    }

    @objc private func deleteButtonTapped() {
        let alert = UIAlertController(
            title: "Silmek İstediğinize Emin Misiniz?",
            message: "\(birthday.name) adlı kişinin doğum günü kaydı ve bildirimleri silinecektir.",
            preferredStyle: .actionSheet
        )
        if let popover = alert.popoverPresentationController {
            popover.sourceView = deleteButton
            popover.sourceRect = deleteButton.bounds
            popover.permittedArrowDirections = [.up, .down]
        }
        alert.addAction(UIAlertAction(title: "Sil", style: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }
            CoreDataManager.shared.deleteBirthday(withId: self.birthday.id)
            NotificationManager.shared.cancelNotification(for: self.birthday)
            NotificationCenter.default.post(name: NSNotification.Name("BirthdayDidUpdateNotification"), object: nil)
            self.onUpdate?()
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Vazgeç", style: .cancel))
        present(alert, animated: true)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}
