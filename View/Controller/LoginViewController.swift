//
//  LoginViewController.swift
//  GameSpace
//
//  Created by DESIGN on 4/12/25.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

        private let viewModel = LoginViewModel()

        override func viewDidLoad() {
            super.viewDidLoad()
        }

    @IBAction func loginTapped(_ sender: UIButton) {

        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        viewModel.login(email: email, password: password) { user, error in
            DispatchQueue.main.async {

                if let user = user {
                    print("Login correcto → \(user.username)")

                    //
                    let homeVC = HomeViewController()
                    self.navigationController?.pushViewController(homeVC, animated: true)


                } else {
                    print("Error login: \(error ?? "Error desconocido")")
                }
            }
        }
    }


        @IBAction func goToRegister(_ sender: UIButton) {
            let storyboard = UIStoryboard(name: "Register", bundle: nil)
            let registerVC = storyboard.instantiateViewController(
                withIdentifier: "RegisterViewController"
            ) as! RegisterViewController

            self.navigationController?.pushViewController(registerVC, animated: true)
        }
    }
    
