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

        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Registro"
        }

    @IBAction func registerTapped(_ sender: UIButton) {

            let email = emailTextField.text ?? ""
            let username = usernameTextField.text ?? ""
            let password = passwordTextField.text ?? ""

            AuthService.shared.register(email: email, username: username, password: password) { user, errorMessage in

                DispatchQueue.main.async {
                    if let user = user {
                        print("Registro correcto: \(user.username)")
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        print("Error: \(errorMessage ?? "")")
                    }
                }
            }
        }
    }
