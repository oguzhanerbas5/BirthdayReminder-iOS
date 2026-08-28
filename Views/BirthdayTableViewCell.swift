//
//  BirthdayTableViewCell.swift
//  birthdayReminder
//

import UIKit

class BirthdayTableViewCell: UITableViewCell {
    
    static let identifier = "BirthdayTableViewCell"
    
    private let containerView = UIView()
    private let textStackView = UIStackView()
    private let nameLabel = UILabel()
    private let detailLabel = UILabel()
    private let badgeContainer = UIView()
    private let badgeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 18
        containerView.layer.masksToBounds = false
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = AppColors.pastelSand.withAlphaComponent(0.6).cgColor
        containerView.layer.shadowColor = AppColors.deepForestDarkGreen.cgColor
        containerView.layer.shadowOpacity = 0.06
        containerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        containerView.layer.shadowRadius = 6
        contentView.addSubview(containerView)
        
        textStackView.axis = .vertical
        textStackView.spacing = 4
        textStackView.distribution = .fill
        containerView.addSubview(textStackView)
        
        nameLabel.font = .sansSerif(size: 17, weight: .bold)
        nameLabel.textColor = AppColors.deepForestDarkGreen
        
        detailLabel.font = .sansSerif(size: 13, weight: .medium)
        detailLabel.textColor = AppColors.deepForestDarkGreen.withAlphaComponent(0.75)
        
        textStackView.addArrangedSubview(nameLabel)
        textStackView.addArrangedSubview(detailLabel)
        
        badgeContainer.layer.cornerRadius = 12
        badgeContainer.layer.masksToBounds = true
        containerView.addSubview(badgeContainer)
        
        badgeLabel.font = .sansSerif(size: 12, weight: .bold)
        badgeLabel.textColor = .white
        badgeLabel.textAlignment = .center
        badgeContainer.addSubview(badgeLabel)
    }
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        badgeContainer.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            textStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 18),
            textStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            textStackView.trailingAnchor.constraint(lessThanOrEqualTo: badgeContainer.leadingAnchor, constant: -12),
            
            badgeContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            badgeContainer.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            badgeContainer.heightAnchor.constraint(equalToConstant: 30),
            
            badgeLabel.topAnchor.constraint(equalTo: badgeContainer.topAnchor, constant: 6),
            badgeLabel.bottomAnchor.constraint(equalTo: badgeContainer.bottomAnchor, constant: -6),
            badgeLabel.leadingAnchor.constraint(equalTo: badgeContainer.leadingAnchor, constant: 12),
            badgeLabel.trailingAnchor.constraint(equalTo: badgeContainer.trailingAnchor, constant: -12)
        ])
    }
    
    func configure(with birthday: Birthday) {
        nameLabel.text = birthday.name
        detailLabel.text = "Doğum Tarihi: \(birthday.formattedDateString)"
        
        let days = birthday.daysRemaining
        
        if birthday.isToday {
            badgeContainer.backgroundColor = AppColors.statusUrgent
            badgeLabel.text = "BUGÜN!"
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
    }
}
