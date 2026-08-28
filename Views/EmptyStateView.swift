//
//  EmptyStateView.swift
//  birthdayReminder
//

import UIKit

class EmptyStateView: UIView {
    
    var onAddButtonTapped: (() -> Void)?
    
    private let stackView = UIStackView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let addButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = AppColors.warmCream
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.distribution = .fill
        
        let giftConfig = UIImage.SymbolConfiguration(pointSize: 64, weight: .semibold)
        iconImageView.image = UIImage(systemName: "gift.fill", withConfiguration: giftConfig)
        iconImageView.tintColor = AppColors.richLeafGreen
        iconImageView.contentMode = .scaleAspectFit
        
        titleLabel.text = "Henüz Doğum Günü Yok"
        titleLabel.font = .sansSerif(size: 22, weight: .bold)
        titleLabel.textColor = AppColors.deepForestDarkGreen
        titleLabel.textAlignment = .center
        
        descriptionLabel.text = "Arkadaşlarınızın doğum günlerini ekleyerek hatırlatmalar oluşturabilirsiniz."
        descriptionLabel.font = .sansSerif(size: 15, weight: .regular)
        descriptionLabel.textColor = AppColors.deepForestDarkGreen.withAlphaComponent(0.7)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        
        addButton.setTitle(" Doğum Günü Ekle", for: .normal)
        addButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        addButton.tintColor = .white
        addButton.titleLabel?.font = .sansSerif(size: 16, weight: .bold)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = AppColors.richLeafGreen
        addButton.layer.cornerRadius = 20
        addButton.layer.shadowColor = AppColors.richLeafGreen.cgColor
        addButton.layer.shadowOpacity = 0.3
        addButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        addButton.layer.shadowRadius = 8
        addButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(addButton)
        
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
    }
    
    @objc private func addButtonAction() {
        onAddButtonTapped?()
    }
}
