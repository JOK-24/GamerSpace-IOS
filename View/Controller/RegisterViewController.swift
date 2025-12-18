//
//  RegisterViewController.swift
//  GameSpace
//
//  Created by DESIGN on 4/12/25.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    private let viewModel = RegisterViewModel()

        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Registro"
        }

        @IBAction func registerTapped(_ sender: UIButton) {

            let email = emailTextField.text ?? ""
            let username = usernameTextField.text ?? ""
            let password = passwordTextField.text ?? ""

            viewModel.register(
                email: email,
                username: username,
                password: password
            ) { [weak self] success, message in

                DispatchQueue.main.async {
                    if success {
                        // Volvemos al login o home
                        self?.navigationController?.popViewController(animated: true)
                    } else {
                        self?.showError(message ?? "Error")
                    }
                }
            }
        }

        private func showError(_ message: String) {
            let alert = UIAlertController(
                title: "Error",
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
