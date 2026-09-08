//
//  AddBirthdayViewController.swift
//  birthdayReminder
//

import UIKit

class AddBirthdayViewController: UIViewController {

    weak var delegate: BirthdayDelegate?
    var birthdayToEdit: Birthday?

    // Main layout with bottom sticky button area
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()

    // Fixed Sticky Bottom Action Container (Dynamic Keyboard Responsive)
    private let bottomActionContainer = UIView()
    private let saveButton = UIButton(type: .system)
    private var bottomActionContainerBottomConstraint: NSLayoutConstraint?

    // Name Field
    private let nameLabel = UILabel()
    private let nameContainer = UIView()
    private let nameIcon = UIImageView()
    private let nameTextField = UITextField()

    // Date Picker Section (Native adaptive inline style for iOS & iPadOS)
    private let datePickerLabel = UILabel()
    private let selectedDateBadgeLabel = UILabel()
    private let dateCard = UIView()
    private let datePicker = UIDatePicker()

    // Single-Level Direct Category Selection System
    private let categoryHeaderLabel = UILabel()
    private let categoryScrollView = UIScrollView()
    private let categoryStackView = UIStackView()
    private var categoryButtons: [UIButton] = []
    
    // Flat Category List
    private struct CategoryItem {
        let title: String
        let messages: [String]
    }
    
    private var flatCategories: [CategoryItem] = []
    private var selectedCategoryIndex: Int = 0

    // Message List View
    private let messageListScrollView = UIScrollView()
    private let messageListStackView = UIStackView()
    private var messageCards: [UIView] = []
    private var selectedMessageIndex: Int? = nil
    
    // Message Input
    private let messageLabel = UILabel()
    private let messageTextView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFlatCategories()
        setupNavigation()
        setupUI()
        setupConstraints()
        setupActions()
        setupKeyboardDismiss()
        configureForEditIfNeeded()
        NotificationManager.shared.requestAuthorization()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.setContentOffset(.zero, animated: false)
    }

    private func setupFlatCategories() {
        flatCategories = [
            CategoryItem(title: "Sevgili", messages: MessageTemplates.sevgiliMessages),
            CategoryItem(title: "Anne", messages: MessageTemplates.anneMessages),
            CategoryItem(title: "Baba", messages: MessageTemplates.babaMessages),
            CategoryItem(title: "Kardeş", messages: MessageTemplates.kardesMessages),
            CategoryItem(title: "Abla", messages: MessageTemplates.ablaMessages),
            CategoryItem(title: "Abi", messages: MessageTemplates.abiMessages),
            CategoryItem(title: "Kanka", messages: MessageTemplates.kankaMessages),
            CategoryItem(title: "En Yakın Arkadaş", messages: MessageTemplates.enYakinArkadasMessages),
            CategoryItem(title: "Uzak Arkadaş", messages: MessageTemplates.uzakArkadasMessages),
            CategoryItem(title: "Flört", messages: MessageTemplates.flortMessages),
            CategoryItem(title: "Hoşlandığım", messages: MessageTemplates.hoslandigimMessages),
            CategoryItem(title: "İş Arkadaşı", messages: MessageTemplates.isArkadasiMessages)
        ]
    }

    private func setupNavigation() {
        title = birthdayToEdit == nil ? "Doğum Günü Ekle" : "Doğum Günü Düzenle"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = AppColors.warmCream
        appearance.largeTitleTextAttributes = [
            .foregroundColor: AppColors.deepForestDarkGreen,
            .font: UIFont.sansSerif(size: 32, weight: .bold)
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

        view.addSubview(scrollView)
        view.addSubview(bottomActionContainer)

        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        bottomActionContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fill

        // Sticky Bottom Container & Save Button
        bottomActionContainer.backgroundColor = AppColors.warmCream
        
        saveButton.setTitle(birthdayToEdit == nil ? " Doğum Günü Kaydet" : " Değişiklikleri Kaydet", for: .normal)
        saveButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        saveButton.tintColor = .white
        saveButton.titleLabel?.font = .sansSerif(size: 17, weight: .bold)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = AppColors.richLeafGreen
        saveButton.layer.cornerRadius = 22
        saveButton.layer.shadowColor = AppColors.richLeafGreen.cgColor
        saveButton.layer.shadowOpacity = 0.35
        saveButton.layer.shadowOffset = CGSize(width: 0, height: 6)
        saveButton.layer.shadowRadius = 12
        saveButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        bottomActionContainer.addSubview(saveButton)

        // Form Field 1: Kişi Adı
        nameLabel.text = "KİŞİ ADI"
        nameLabel.font = .sansSerif(size: 13, weight: .bold)
        nameLabel.textColor = AppColors.deepForestDarkGreen.withAlphaComponent(0.8)

        nameContainer.backgroundColor = .white
        nameContainer.layer.cornerRadius = 18
        nameContainer.layer.borderWidth = 1.0
        nameContainer.layer.borderColor = AppColors.pastelSand.withAlphaComponent(0.6).cgColor
        nameContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true

        let personConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
        nameIcon.image = UIImage(systemName: "person.fill", withConfiguration: personConfig)
        nameIcon.tintColor = AppColors.deepForestDarkGreen
        nameIcon.contentMode = .scaleAspectFit

        nameTextField.placeholder = "Örn: Ahmet Yılmaz"
        nameTextField.borderStyle = .none
        nameTextField.font = .sansSerif(size: 16, weight: .medium)
        nameTextField.textColor = AppColors.deepForestDarkGreen
        nameTextField.autocapitalizationType = .words
        nameTextField.autocorrectionType = .no
        nameTextField.returnKeyType = .done
        nameTextField.delegate = self
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.addTarget(self, action: #selector(nameTextFieldDidChange), for: .editingChanged)

        nameContainer.addSubview(nameIcon)
        nameContainer.addSubview(nameTextField)
        nameIcon.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameIcon.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor, constant: 16),
            nameIcon.centerYAnchor.constraint(equalTo: nameContainer.centerYAnchor),
            nameIcon.widthAnchor.constraint(equalToConstant: 22),
            nameIcon.heightAnchor.constraint(equalToConstant: 22),

            nameTextField.leadingAnchor.constraint(equalTo: nameIcon.trailingAnchor, constant: 12),
            nameTextField.trailingAnchor.constraint(equalTo: nameContainer.trailingAnchor, constant: -16),
            nameTextField.centerYAnchor.constraint(equalTo: nameContainer.centerYAnchor)
        ])

        // Form Field 2: Doğum Tarihi (Header + Dynamic Badge)
        datePickerLabel.text = "DOĞUM TARİHİ"
        datePickerLabel.font = .sansSerif(size: 13, weight: .bold)
        datePickerLabel.textColor = AppColors.deepForestDarkGreen.withAlphaComponent(0.8)

        selectedDateBadgeLabel.font = .sansSerif(size: 13, weight: .bold)
        selectedDateBadgeLabel.textColor = AppColors.richLeafGreen
        selectedDateBadgeLabel.textAlignment = .right

        let dateHeaderStack = UIStackView(arrangedSubviews: [datePickerLabel, selectedDateBadgeLabel])
        dateHeaderStack.axis = .horizontal
        dateHeaderStack.distribution = .equalSpacing
        dateHeaderStack.alignment = .center

        dateCard.backgroundColor = .white
        dateCard.layer.cornerRadius = 22
        dateCard.layer.borderWidth = 1.0
        dateCard.layer.borderColor = AppColors.pastelSand.withAlphaComponent(0.6).cgColor
        dateCard.clipsToBounds = true

        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "tr_TR")
        datePicker.tintColor = AppColors.richLeafGreen
        datePicker.maximumDate = Date()

        let calendar = Calendar.current
        if let minDate = calendar.date(byAdding: .year, value: -120, to: Date()) {
            datePicker.minimumDate = minDate
        }

        if birthdayToEdit == nil {
            if let defaultDate = calendar.date(byAdding: .year, value: -20, to: Date()) {
                datePicker.date = defaultDate
            }
        }

        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false

        dateCard.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: dateCard.topAnchor, constant: 4),
            datePicker.bottomAnchor.constraint(equalTo: dateCard.bottomAnchor, constant: -4),
            datePicker.leadingAnchor.constraint(equalTo: dateCard.leadingAnchor, constant: 8),
            datePicker.trailingAnchor.constraint(equalTo: dateCard.trailingAnchor, constant: -8),
            datePicker.heightAnchor.constraint(equalToConstant: 216)
        ])

        updateDatePreview()

        // Direct Horizontal Category Bar
        categoryHeaderLabel.text = "YAKINLIK"
        categoryHeaderLabel.font = .sansSerif(size: 13, weight: .bold)
        categoryHeaderLabel.textColor = AppColors.deepForestDarkGreen.withAlphaComponent(0.8)

        categoryScrollView.showsHorizontalScrollIndicator = false
        categoryStackView.axis = .horizontal
        categoryStackView.spacing = 8
        categoryStackView.translatesAutoresizingMaskIntoConstraints = false
        categoryScrollView.addSubview(categoryStackView)

        NSLayoutConstraint.activate([
            categoryStackView.topAnchor.constraint(equalTo: categoryScrollView.topAnchor),
            categoryStackView.leadingAnchor.constraint(equalTo: categoryScrollView.leadingAnchor),
            categoryStackView.trailingAnchor.constraint(equalTo: categoryScrollView.trailingAnchor),
            categoryStackView.bottomAnchor.constraint(equalTo: categoryScrollView.bottomAnchor),
            categoryStackView.heightAnchor.constraint(equalTo: categoryScrollView.heightAnchor)
        ])
        categoryScrollView.heightAnchor.constraint(equalToConstant: 38).isActive = true

        setupCategoryChips()

        // Message List Scroll View
        messageListScrollView.showsHorizontalScrollIndicator = false
        messageListStackView.axis = .horizontal
        messageListStackView.spacing = 12
        messageListStackView.translatesAutoresizingMaskIntoConstraints = false
        messageListScrollView.addSubview(messageListStackView)

        NSLayoutConstraint.activate([
            messageListStackView.topAnchor.constraint(equalTo: messageListScrollView.topAnchor),
            messageListStackView.leadingAnchor.constraint(equalTo: messageListScrollView.leadingAnchor),
            messageListStackView.trailingAnchor.constraint(equalTo: messageListScrollView.trailingAnchor),
            messageListStackView.bottomAnchor.constraint(equalTo: messageListScrollView.bottomAnchor),
            messageListStackView.heightAnchor.constraint(equalTo: messageListScrollView.heightAnchor)
        ])
        messageListScrollView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        updateMessageListForSelectedCategory()

        // Form Field 4: Hazırlanan Mesaj
        messageLabel.text = "HAZIRLANAN MESAJ (DÜZENLEYEBİLİRSİNİZ)"
        messageLabel.font = .sansSerif(size: 13, weight: .bold)
        messageLabel.textColor = AppColors.deepForestDarkGreen.withAlphaComponent(0.8)

        messageTextView.backgroundColor = .white
        messageTextView.layer.cornerRadius = 20
        messageTextView.layer.borderWidth = 1.0
        messageTextView.layer.borderColor = AppColors.pastelSand.withAlphaComponent(0.6).cgColor
        messageTextView.font = .sansSerif(size: 15, weight: .regular)
        messageTextView.textColor = .label
        messageTextView.textContainerInset = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        messageTextView.heightAnchor.constraint(equalToConstant: 110).isActive = true

        // Assemble Stack
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(nameContainer)
        stackView.setCustomSpacing(6, after: nameLabel)
        stackView.setCustomSpacing(14, after: nameContainer)

        stackView.addArrangedSubview(dateHeaderStack)
        stackView.addArrangedSubview(dateCard)
        stackView.setCustomSpacing(6, after: dateHeaderStack)
        stackView.setCustomSpacing(14, after: dateCard)
        
        stackView.addArrangedSubview(categoryHeaderLabel)
        stackView.addArrangedSubview(categoryScrollView)
        stackView.setCustomSpacing(8, after: categoryHeaderLabel)
        stackView.setCustomSpacing(10, after: categoryScrollView)
        
        stackView.addArrangedSubview(messageListScrollView)
        stackView.setCustomSpacing(12, after: messageListScrollView)

        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(messageTextView)
        stackView.setCustomSpacing(6, after: messageLabel)
    }

    private func setupConstraints() {
        let bottomConstraint = bottomActionContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        bottomActionContainerBottomConstraint = bottomConstraint

        let stackLeading = stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18)
        stackLeading.priority = UILayoutPriority(999)
        let stackTrailing = stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18)
        stackTrailing.priority = UILayoutPriority(999)

        let saveLeading = saveButton.leadingAnchor.constraint(equalTo: bottomActionContainer.leadingAnchor, constant: 20)
        saveLeading.priority = UILayoutPriority(999)
        let saveTrailing = saveButton.trailingAnchor.constraint(equalTo: bottomActionContainer.trailingAnchor, constant: -20)
        saveTrailing.priority = UILayoutPriority(999)

        NSLayoutConstraint.activate([
            bottomActionContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomActionContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomConstraint,
            bottomActionContainer.heightAnchor.constraint(equalToConstant: 72),

            saveButton.topAnchor.constraint(equalTo: bottomActionContainer.topAnchor, constant: 8),
            saveButton.centerXAnchor.constraint(equalTo: bottomActionContainer.centerXAnchor),
            saveButton.widthAnchor.constraint(lessThanOrEqualToConstant: 680),
            saveLeading,
            saveTrailing,

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomActionContainer.topAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.widthAnchor.constraint(lessThanOrEqualToConstant: 680),
            stackLeading,
            stackTrailing,
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }

    private func setupCategoryChips() {
        categoryButtons.removeAll()
        categoryStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for (index, cat) in flatCategories.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(cat.title, for: .normal)
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            button.titleLabel?.font = .sansSerif(size: 13, weight: .bold)
            button.layer.cornerRadius = 12
            button.layer.masksToBounds = true
            button.tag = index

            if index == selectedCategoryIndex {
                button.backgroundColor = AppColors.richLeafGreen
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = AppColors.pastelSand.withAlphaComponent(0.5)
                button.setTitleColor(AppColors.deepForestDarkGreen, for: .normal)
            }

            button.addTarget(self, action: #selector(categoryChipTapped(_:)), for: .touchUpInside)
            categoryButtons.append(button)
            categoryStackView.addArrangedSubview(button)
        }
    }

    private func formatTemplateMessage(_ template: String, forName name: String) -> String {
        var text = template
        if name.isEmpty {
            text = text.replacingOccurrences(of: " {NAME}", with: "")
            text = text.replacingOccurrences(of: "{NAME} ", with: "")
            text = text.replacingOccurrences(of: "{NAME}", with: "")
        } else {
            text = text.replacingOccurrences(of: "{NAME}", with: name)
        }
        text = text.replacingOccurrences(of: "  ", with: " ")
        text = text.replacingOccurrences(of: " ,", with: ",")
        text = text.replacingOccurrences(of: " .", with: ".")
        text = text.replacingOccurrences(of: " !", with: "!")
        text = text.replacingOccurrences(of: " ?", with: "?")
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func updateMessageListForSelectedCategory() {
        messageListStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        messageCards.removeAll()

        guard selectedCategoryIndex < flatCategories.count else { return }
        let category = flatCategories[selectedCategoryIndex]

        let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        for (index, msg) in category.messages.enumerated() {
            let formattedMsg = formatTemplateMessage(msg, forName: name)

            let card = UIView()
            card.backgroundColor = .white
            card.layer.cornerRadius = 16
            card.layer.borderWidth = 1.5
            card.layer.borderColor = AppColors.pastelSand.withAlphaComponent(0.5).cgColor
            card.tag = index
            card.widthAnchor.constraint(equalToConstant: 280).isActive = true

            if let selIdx = selectedMessageIndex, selIdx == index {
                card.layer.borderColor = AppColors.richLeafGreen.cgColor
                card.backgroundColor = AppColors.richLeafGreen.withAlphaComponent(0.15)
            }

            let label = UILabel()
            label.text = formattedMsg
            label.font = .sansSerif(size: 12, weight: .medium)
            label.textColor = AppColors.deepForestDarkGreen
            label.numberOfLines = 5
            label.translatesAutoresizingMaskIntoConstraints = false

            card.addSubview(label)
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: card.topAnchor, constant: 10),
                label.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -10),
                label.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 12),
                label.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -12)
            ])

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(messageCardTapped(_:)))
            card.addGestureRecognizer(tapGesture)
            card.isUserInteractionEnabled = true
            card.accessibilityValue = formattedMsg

            messageCards.append(card)
            messageListStackView.addArrangedSubview(card)
        }
        
        messageListScrollView.setContentOffset(.zero, animated: false)
    }

    @objc private func categoryChipTapped(_ sender: UIButton) {
        selectedCategoryIndex = sender.tag
        selectedMessageIndex = nil
        for (idx, btn) in categoryButtons.enumerated() {
            if idx == selectedCategoryIndex {
                btn.backgroundColor = AppColors.richLeafGreen
                btn.setTitleColor(.white, for: .normal)
            } else {
                btn.backgroundColor = AppColors.pastelSand.withAlphaComponent(0.5)
                btn.setTitleColor(AppColors.deepForestDarkGreen, for: .normal)
            }
        }
        updateMessageListForSelectedCategory()
    }

    @objc private func nameTextFieldDidChange() {
        let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if let selIdx = selectedMessageIndex,
           selectedCategoryIndex < flatCategories.count,
           selIdx < flatCategories[selectedCategoryIndex].messages.count {
            let rawMsg = flatCategories[selectedCategoryIndex].messages[selIdx]
            messageTextView.text = formatTemplateMessage(rawMsg, forName: name)
        }
        updateMessageListForSelectedCategory()
    }

    @objc private func messageCardTapped(_ gesture: UITapGestureRecognizer) {
        guard let card = gesture.view, let text = card.accessibilityValue else { return }
        
        selectedMessageIndex = card.tag
        for (idx, c) in messageCards.enumerated() {
            if idx == selectedMessageIndex {
                c.layer.borderColor = AppColors.richLeafGreen.cgColor
                c.backgroundColor = AppColors.richLeafGreen.withAlphaComponent(0.15)
            } else {
                c.layer.borderColor = AppColors.pastelSand.withAlphaComponent(0.5).cgColor
                c.backgroundColor = .white
            }
        }
        
        messageTextView.text = text
    }

    private func setupActions() {
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDatePreview()
    }

    private func updateDatePreview() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "dd MMMM yyyy"
        let dateString = formatter.string(from: datePicker.date)
        
        let age = Calendar.current.dateComponents([.year], from: datePicker.date, to: Date()).year ?? 0
        if age > 0 {
            selectedDateBadgeLabel.text = "\(dateString) (\(age) Yaş)"
        } else {
            selectedDateBadgeLabel.text = dateString
        }
    }

    private func configureForEditIfNeeded() {
        guard let birthday = birthdayToEdit else {
            updateDatePreview()
            return
        }

        nameTextField.text = birthday.name
        datePicker.date = birthday.date
        messageTextView.text = birthday.message
        updateDatePreview()
    }

    @objc private func saveButtonTapped() {
        view.endEditing(true)

        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty else {
            showAlert(title: "Uyarı", message: "Lütfen arkadaşınızın adını girin.")
            nameTextField.becomeFirstResponder()
            return
        }

        let selectedDate = datePicker.date
        if selectedDate > Date() {
            showAlert(title: "Uyarı", message: "Doğum tarihi gelecekte bir tarih olamaz.")
            return
        }

        let message = messageTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        let birthday = Birthday(
            id: birthdayToEdit?.id ?? UUID(),
            name: name,
            date: selectedDate,
            message: message,
            reminderHour: 9,
            reminderMinute: 0
        )

        CoreDataManager.shared.saveBirthday(birthday)
        NotificationManager.shared.scheduleNotification(for: birthday)
        NotificationCenter.default.post(name: NSNotification.Name("BirthdayDidUpdateNotification"), object: nil)
        delegate?.didAddBirthday(birthday)

        if birthdayToEdit == nil {
            nameTextField.text = ""
            messageTextView.text = ""
            
            let alert = UIAlertController(
                title: "Başarılı Kayıt",
                message: "\(birthday.name) için doğum günü kaydedildi! Otomatik olarak 1 hafta önce, 1 gün önce ve doğum günü sabahı saat 09:00'da bildirimler ayarlandı.",
                preferredStyle: .alert
            )
            if let popover = alert.popoverPresentationController {
                popover.sourceView = saveButton
                popover.sourceRect = saveButton.bounds
                popover.permittedArrowDirections = [.up, .down]
            }
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                if let nav = self.navigationController, nav.viewControllers.count > 1 {
                    nav.popViewController(animated: true)
                } else if self.presentingViewController != nil {
                    self.dismiss(animated: true)
                } else {
                    self.tabBarController?.selectedIndex = 0
                }
            }))
            present(alert, animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    private func setupKeyboardDismiss() {
        // 1. Dismiss on tap anywhere outside interactive controls
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)

        // 2. Dismiss on scroll / drag
        scrollView.keyboardDismissMode = .interactive

        // 3. Accessory Toolbar with "Tamam" button above keyboard
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Tamam", style: .done, target: self, action: #selector(dismissKeyboard))
        doneBarButton.tintColor = AppColors.richLeafGreen
        toolbar.setItems([flexibleSpace, doneBarButton], animated: false)

        nameTextField.inputAccessoryView = toolbar
        messageTextView.inputAccessoryView = toolbar

        // 4. Keyboard Show / Hide Notifications for dynamic sticky container lifting and scroll insets
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardFrameInView = view.convert(keyboardFrame, from: nil)
        let visibleIntersection = view.bounds.intersection(keyboardFrameInView)
        let keyboardHeight = visibleIntersection.height
        
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
        let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt ?? 7
        let options = UIView.AnimationOptions(rawValue: curveRaw << 16)
        
        // Dynamically lift bottomActionContainer above keyboard so it is never covered
        let safeAreaBottom = view.safeAreaInsets.bottom
        let offset = max(0, keyboardHeight - safeAreaBottom)
        bottomActionContainerBottomConstraint?.constant = -offset
        
        let totalBottomInset = keyboardHeight + 80
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: totalBottomInset, right: 0)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: totalBottomInset, right: 0)
        
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
        let curveRaw = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt ?? 7
        let options = UIView.AnimationOptions(rawValue: curveRaw << 16)
        
        bottomActionContainerBottomConstraint?.constant = 0
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
        
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let popover = alert.popoverPresentationController {
            popover.sourceView = saveButton
            popover.sourceRect = saveButton.bounds
            popover.permittedArrowDirections = [.up, .down]
        }
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension AddBirthdayViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UIGestureRecognizerDelegate
extension AddBirthdayViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // Prevent background tap gesture from swallowing touches on UIDatePicker, buttons, or text controls
        var currentView = touch.view
        while let v = currentView {
            if v is UIControl || v is UIDatePicker || v is UITextView {
                return false
            }
            currentView = v.superview
        }
        return true
    }
}

