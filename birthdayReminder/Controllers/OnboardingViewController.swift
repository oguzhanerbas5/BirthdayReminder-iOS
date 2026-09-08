//
//  OnboardingViewController.swift
//  birthdayReminder
//

import UIKit

struct OnboardingSlide {
    let title: String
    let description: String
    let symbolName: String
    let badgeText: String
}

class OnboardingViewController: UIViewController {

    private let slides: [OnboardingSlide] = [
        OnboardingSlide(
            title: "Sevdiklerinizin Özel Günlerini Asla Unutmayın",
            description: "Arkadaşlarınızın ve ailenizin doğum günlerini kaydedin, yaklaşan özel günlerin takibini kolayca yapın.",
            symbolName: "gift.fill",
            badgeText: "ADIM 1 / 3"
        ),
        OnboardingSlide(
            title: "Otomatik Akıllı Hatırlatmalar",
            description: "1 Hafta önce, 1 gün önce ve doğum günü sabahı saat 09:00'da bildirimler alarak hediyelerinizi zamanında hazırlayın.",
            symbolName: "bell.badge.fill",
            badgeText: "ADIM 2 / 3"
        ),
        OnboardingSlide(
            title: "100+ Hazır Kutlama Mesajı",
            description: "Sevgiliye, eşe, arkadaşa veya patrona özel hazırlanmış mesajları tek tıkla kopyalayın veya doğrudan paylaşın.",
            symbolName: "quote.bubble.fill",
            badgeText: "ADIM 3 / 3"
        )
    ]

    private var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Başlamaya Hazırım!", for: .normal)
            } else {
                nextButton.setTitle("Devam Et", for: .normal)
            }
        }
    }

    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let pageControl = UIPageControl()
    private let skipButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)
    private let bottomContainer = UIView()

    var isReplayMode: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        renderSlides()
    }

    private func setupUI() {
        view.backgroundColor = AppColors.warmCream

        // Skip button (Top Right)
        skipButton.setTitle("Atla", for: .normal)
        skipButton.titleLabel?.font = .sansSerif(size: 15, weight: .bold)
        skipButton.setTitleColor(AppColors.deepForestDarkGreen.withAlphaComponent(0.7), for: .normal)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(skipButton)

        // Scroll View Setup
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)

        // Page Control
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = AppColors.richLeafGreen
        pageControl.pageIndicatorTintColor = AppColors.pastelSand
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)

        // Next Button
        nextButton.setTitle("Devam Et", for: .normal)
        nextButton.titleLabel?.font = .sansSerif(size: 17, weight: .bold)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = AppColors.richLeafGreen
        nextButton.layer.cornerRadius = 24
        nextButton.layer.shadowColor = AppColors.richLeafGreen.cgColor
        nextButton.layer.shadowOpacity = 0.35
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 6)
        nextButton.layer.shadowRadius = 12
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            scrollView.topAnchor.constraint(equalTo: skipButton.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),

            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -24),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            nextButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    private func renderSlides() {
        for slide in slides {
            let slideView = UIView()
            slideView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(slideView)
            slideView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

            // Badge
            let badgeContainer = UIView()
            badgeContainer.backgroundColor = AppColors.pastelSand.withAlphaComponent(0.6)
            badgeContainer.layer.cornerRadius = 12
            badgeContainer.translatesAutoresizingMaskIntoConstraints = false

            let badgeLabel = UILabel()
            badgeLabel.text = slide.badgeText
            badgeLabel.font = .sansSerif(size: 12, weight: .bold)
            badgeLabel.textColor = AppColors.deepForestDarkGreen
            badgeLabel.translatesAutoresizingMaskIntoConstraints = false
            badgeContainer.addSubview(badgeLabel)

            NSLayoutConstraint.activate([
                badgeLabel.topAnchor.constraint(equalTo: badgeContainer.topAnchor, constant: 4),
                badgeLabel.bottomAnchor.constraint(equalTo: badgeContainer.bottomAnchor, constant: -4),
                badgeLabel.leadingAnchor.constraint(equalTo: badgeContainer.leadingAnchor, constant: 12),
                badgeLabel.trailingAnchor.constraint(equalTo: badgeContainer.trailingAnchor, constant: -12)
            ])

            // Circular Icon Background
            let iconCircle = UIView()
            iconCircle.backgroundColor = .white
            iconCircle.layer.cornerRadius = 70
            iconCircle.layer.borderWidth = 2
            iconCircle.layer.borderColor = AppColors.pastelSand.cgColor
            iconCircle.layer.shadowColor = AppColors.deepForestDarkGreen.cgColor
            iconCircle.layer.shadowOpacity = 0.1
            iconCircle.layer.shadowOffset = CGSize(width: 0, height: 6)
            iconCircle.layer.shadowRadius = 12
            iconCircle.translatesAutoresizingMaskIntoConstraints = false

            let iconImageView = UIImageView()
            let config = UIImage.SymbolConfiguration(pointSize: 64, weight: .semibold)
            iconImageView.image = UIImage(systemName: slide.symbolName, withConfiguration: config)
            iconImageView.tintColor = AppColors.richLeafGreen
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.translatesAutoresizingMaskIntoConstraints = false
            iconCircle.addSubview(iconImageView)

            NSLayoutConstraint.activate([
                iconCircle.widthAnchor.constraint(equalToConstant: 140),
                iconCircle.heightAnchor.constraint(equalToConstant: 140),
                iconImageView.centerXAnchor.constraint(equalTo: iconCircle.centerXAnchor),
                iconImageView.centerYAnchor.constraint(equalTo: iconCircle.centerYAnchor)
            ])

            // Text Stack
            let titleLabel = UILabel()
            titleLabel.text = slide.title
            titleLabel.font = .sansSerif(size: 26, weight: .bold)
            titleLabel.textColor = AppColors.deepForestDarkGreen
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0

            let descriptionLabel = UILabel()
            descriptionLabel.text = slide.description
            descriptionLabel.font = .sansSerif(size: 16, weight: .regular)
            descriptionLabel.textColor = AppColors.deepForestDarkGreen.withAlphaComponent(0.75)
            descriptionLabel.textAlignment = .center
            descriptionLabel.numberOfLines = 0

            let textStack = UIStackView(arrangedSubviews: [badgeContainer, iconCircle, titleLabel, descriptionLabel])
            textStack.axis = .vertical
            textStack.alignment = .center
            textStack.spacing = 20
            textStack.translatesAutoresizingMaskIntoConstraints = false

            slideView.addSubview(textStack)

            NSLayoutConstraint.activate([
                textStack.centerXAnchor.constraint(equalTo: slideView.centerXAnchor),
                textStack.centerYAnchor.constraint(equalTo: slideView.centerYAnchor, constant: -10),
                textStack.leadingAnchor.constraint(equalTo: slideView.leadingAnchor, constant: 32),
                textStack.trailingAnchor.constraint(equalTo: slideView.trailingAnchor, constant: -32)
            ])
        }
    }

    @objc private func skipTapped() {
        finishOnboarding()
    }

    @objc private func nextTapped() {
        if currentPage < slides.count - 1 {
            currentPage += 1
            let offset = CGPoint(x: CGFloat(currentPage) * view.frame.width, y: 0)
            scrollView.setContentOffset(offset, animated: true)
        } else {
            finishOnboarding()
        }
    }

    private func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")

        if isReplayMode {
            dismiss(animated: true, completion: nil)
        } else {
            guard let window = view.window else { return }
            UIView.transition(
                with: window,
                duration: 0.5,
                options: .transitionCrossDissolve,
                animations: {
                    window.rootViewController = MainTabBarController()
                },
                completion: nil
            )
        }
    }
}

// MARK: - UIScrollViewDelegate
extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x / view.frame.width))
        if page != currentPage && page >= 0 && page < slides.count {
            currentPage = page
        }
    }
}
