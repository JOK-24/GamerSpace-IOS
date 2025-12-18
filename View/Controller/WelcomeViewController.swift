//
//  WelcomeViewController.swift
//  GameSpace
//
//  Created by DESIGN on 16/12/25.
//

import UIKit

class WelcomeViewController: UIViewController {

    var onAccept: (() -> Void)?

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            setupUI()
        }

        private func setupUI() {
            let titleLabel = UILabel()
            titleLabel.text = "Bienvenido a GameSpace 🎮"
            titleLabel.font = .boldSystemFont(ofSize: 22)
            titleLabel.textAlignment = .center

            let descriptionLabel = UILabel()
            descriptionLabel.text =
            """
            Aquí podrás explorar juegos populares,
            buscar por nombre, filtrar por plataformas
            y descubrir títulos por género.
            """
            descriptionLabel.numberOfLines = 0
            descriptionLabel.textAlignment = .center
            descriptionLabel.textColor = .secondaryLabel

            let button = UIButton(type: .system)
            button.setTitle("Aceptar", for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 16)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 12
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true
            button.addTarget(self, action: #selector(acceptTapped), for: .touchUpInside)

            let stack = UIStackView(arrangedSubviews: [
                titleLabel,
                descriptionLabel,
                button
            ])
            stack.axis = .vertical
            stack.spacing = 20

            view.addSubview(stack)
            stack.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
            ])
        }

        @objc private func acceptTapped() {
            onAccept?()
            dismiss(animated: true)
        }
    }
