//
//  UserViewController.swift
//  GameSpace
//
//  Created by Silvia Ferrer Rodriguez on 16/12/25.
//

import UIKit

class UserViewController: UIViewController {
    
    // MARK: - ViewModel
    private let viewModel = UserViewModel()

    // MARK: - UI Elements
    private let avatarLabel = UILabel()
    private let usernameLabel = UILabel()
    private let emailLabel = UILabel()

    private let changeUsernameButton = UIButton(type: .system)
    private let changePasswordButton = UIButton(type: .system)
    private let logoutButton = UIButton(type: .system)

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Perfil"

        setupUI()
        loadData()
    }

    // MARK: - UI Setup
    private func setupUI() {

        // Avatar (iniciales)
        avatarLabel.textAlignment = .center
        avatarLabel.font = .boldSystemFont(ofSize: 40)
        avatarLabel.textColor = .white
        avatarLabel.backgroundColor = .systemPurple
        avatarLabel.layer.cornerRadius = 45
        avatarLabel.clipsToBounds = true
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false

        // Username
        usernameLabel.font = .boldSystemFont(ofSize: 22)
        usernameLabel.textAlignment = .center

        // Email
        emailLabel.font = .systemFont(ofSize: 14)
        emailLabel.textColor = .secondaryLabel
        emailLabel.textAlignment = .center

        // Botón cambiar nombre
        changeUsernameButton.setTitle("✏️ Cambiar nombre", for: .normal)
        changeUsernameButton.addTarget(
            self,
            action: #selector(changeUsernameTapped),
            for: .touchUpInside
        )

        // Botón cambiar contraseña
        changePasswordButton.setTitle("🔒 Cambiar contraseña", for: .normal)
        changePasswordButton.addTarget(
            self,
            action: #selector(changePasswordTapped),
            for: .touchUpInside
        )

        // Botón cerrar sesión
        logoutButton.setTitle("Cerrar sesión", for: .normal)
        logoutButton.tintColor = .systemRed
        logoutButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        logoutButton.addTarget(
            self,
            action: #selector(logoutTapped),
            for: .touchUpInside
        )

        // Stack principal
        let stack = UIStackView(arrangedSubviews: [
            avatarLabel,
            usernameLabel,
            emailLabel,
            changeUsernameButton,
            changePasswordButton,
            logoutButton
        ])

        stack.axis = .vertical
        stack.spacing = 18
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        // Constraints
        NSLayoutConstraint.activate([
            avatarLabel.widthAnchor.constraint(equalToConstant: 90),
            avatarLabel.heightAnchor.constraint(equalToConstant: 90),

            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }

    // MARK: - Load Data
    private func loadData() {
        avatarLabel.text = viewModel.initials
        usernameLabel.text = viewModel.username
        emailLabel.text = viewModel.email
    }

    // MARK: - Actions

    /// Cambiar nombre
    @objc private func changeUsernameTapped() {

        let alert = UIAlertController(
            title: "Cambiar nombre",
            message: "Escribe tu nuevo nombre de usuario",
            preferredStyle: .alert
        )

        alert.addTextField {
            $0.text = self.viewModel.username
        }

        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))

        alert.addAction(UIAlertAction(title: "Guardar", style: .default) { _ in
            let newUsername = alert.textFields?.first?.text ?? ""

            self.viewModel.updateUsername(newUsername) { success, message in
                if success {
                    self.loadData()
                }

                self.showAlert(
                    title: success ? "Éxito" : "Error",
                    message: message ?? ""
                )
            }
        })

        present(alert, animated: true)
    }

    /// Cambiar contraseña
    @objc private func changePasswordTapped() {

        let alert = UIAlertController(
            title: "Cambiar contraseña",
            message: "Ingresa tu contraseña actual y la nueva",
            preferredStyle: .alert
        )

        alert.addTextField {
            $0.placeholder = "Contraseña actual"
            $0.isSecureTextEntry = true
        }

        alert.addTextField {
            $0.placeholder = "Nueva contraseña"
            $0.isSecureTextEntry = true
        }

        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))

        alert.addAction(UIAlertAction(title: "Cambiar", style: .default) { _ in
            let current = alert.textFields?[0].text ?? ""
            let new = alert.textFields?[1].text ?? ""

            self.viewModel.changePassword(
                current: current,
                new: new
            ) { success, message in
                self.showAlert(
                    title: success ? "Éxito" : "Error",
                    message: message ?? ""
                )
            }
        })

        present(alert, animated: true)
    }

    /// Cerrar sesión
    @objc private func logoutTapped() {

        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "userId")

        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginVC = storyboard.instantiateViewController(
            withIdentifier: "LoginViewController"
        )

        let nav = UINavigationController(rootViewController: loginVC)

        if let sceneDelegate = UIApplication.shared.connectedScenes
            .first?.delegate as? SceneDelegate {

            sceneDelegate.window?.rootViewController = nav
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }

    // MARK: - Alert reutilizable
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
