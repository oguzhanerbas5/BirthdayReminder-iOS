//
//  AnimatedLaunchViewController.swift
//  birthdayReminder
//

import UIKit

class AnimatedLaunchViewController: UIViewController {

    private let logoImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let containerStack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }

    private func setupUI() {
        view.backgroundColor = AppColors.warmCream

        // App Logo Setup
        if let logoImage = UIImage(named: "AppLogo") ?? UIImage(named: "AppIcon") {
            logoImageView.image = logoImage
        } else {
            let config = UIImage.SymbolConfiguration(pointSize: 90, weight: .bold)
            logoImageView.image = UIImage(systemName: "gift.fill", withConfiguration: config)
            logoImageView.tintColor = AppColors.richLeafGreen
        }
        
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.layer.cornerRadius = 26
        logoImageView.clipsToBounds = true

        titleLabel.text = "Kutla"
        titleLabel.font = .sansSerif(size: 36, weight: .bold)
        titleLabel.textColor = AppColors.deepForestDarkGreen
        titleLabel.textAlignment = .center

        subtitleLabel.text = "Doğum Günü Hatırlatıcı"
        subtitleLabel.font = .sansSerif(size: 16, weight: .medium)
        subtitleLabel.textColor = AppColors.deepForestDarkGreen.withAlphaComponent(0.7)
        subtitleLabel.textAlignment = .center

        containerStack.axis = .vertical
        containerStack.alignment = .center
        containerStack.spacing = 16
        containerStack.translatesAutoresizingMaskIntoConstraints = false

        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true

        containerStack.addArrangedSubview(logoImageView)
        containerStack.addArrangedSubview(titleLabel)
        containerStack.addArrangedSubview(subtitleLabel)

        view.addSubview(containerStack)

        NSLayoutConstraint.activate([
            containerStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20)
        ])

        // Initial State for Animation
        containerStack.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        containerStack.alpha = 0.0
    }

    private func startAnimation() {
        // Step 1: Scale up with spring dynamics
        UIView.animate(
            withDuration: 1.0,
            delay: 0.1,
            usingSpringWithDamping: 0.65,
            initialSpringVelocity: 0.8,
            options: .curveEaseOut,
            animations: {
                self.containerStack.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                self.containerStack.alpha = 1.0
            },
            completion: { _ in
                // Step 2: Settle down to standard identity transform
                UIView.animate(withDuration: 0.3, animations: {
                    self.containerStack.transform = .identity
                }) { _ in
                    // Step 3: Wait briefly, then zoom out slightly while transitioning
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        self.proceedNextScreen()
                    }
                }
            }
        )
    }

    private func proceedNextScreen() {
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
        let targetVC: UIViewController = hasCompletedOnboarding ? MainTabBarController() : OnboardingViewController()

        guard let window = view.window else { return }

        UIView.transition(
            with: window,
            duration: 0.5,
            options: .transitionCrossDissolve,
            animations: {
                window.rootViewController = targetVC
            },
            completion: nil
        )
    }
}
