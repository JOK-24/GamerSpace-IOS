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
    
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelPassword: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var btnRegister: UIButton!
    
        private let viewModel = LoginViewModel()
    
    // CODE PARA LAOS ATRIBUTOS
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // Aquí puedes usar tu logo: imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "GameSpace"
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Inicia sesión para continuar"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor.white.withAlphaComponent(0.7)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            setupConstraints()
            configureTextFields()
            configureButtons()
            configureLabels()
        }
    
    // CODE PARA LOS ESTILOS
    private func setupUI() {
        // Fondo sólido darkBlue
        view.backgroundColor = UIColor.darkBlue
        
        // Gradiente morado en esquina superior izquierda
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.purple.withAlphaComponent(0.3).cgColor,
            UIColor.clear.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // Agregar logo y título si no usas Storyboard para estos elementos
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
        ])
    }
    
    private func setupConstraints() {
        // Activar constraints programáticos para los TextFields
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        btnRegister.translatesAutoresizingMaskIntoConstraints = false
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        labelPassword.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            
            // Subtitle Label
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            
            // Email Label
            labelEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            labelEmail.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -8),
            
            // Email TextField
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 80),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Password Label
            labelPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            labelPassword.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -8),
            
            // Password TextField
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 36),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Login Button
            btnLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnLogin.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 32),
            btnLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            btnLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            btnLogin.heightAnchor.constraint(equalToConstant: 50),
            
            // Register Button
            btnRegister.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnRegister.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
            
        ])
    }
    
    private func configureLabels() {
        // Estilo para label Email
        labelEmail.text = "Email"
        labelEmail.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        labelEmail.textColor = UIColor.white.withAlphaComponent(0.9)
        
        // Estilo para label Password
        labelPassword.text = "Contraseña"
        labelPassword.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        labelPassword.textColor = UIColor.white.withAlphaComponent(0.9)
    }
    
    private func configureButtons() {
        // Estilo del botón de Login
        btnLogin.backgroundColor = UIColor.purple
        btnLogin.layer.cornerRadius = 16
        btnLogin.setTitle("Iniciar Sesión", for: .normal)
        btnLogin.setTitleColor(.white, for: .normal)
        btnLogin.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        // Estilo del botón de Registro
        btnRegister.backgroundColor = .clear
        btnRegister.setTitle("¿No tienes cuenta? Regístrate", for: .normal)
        btnRegister.setTitleColor(UIColor.purple, for: .normal)
        btnRegister.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    private func styleTextField(_ textField: UITextField, placeholder: String, iconName: String) {
        // Fondo con esquinas redondeadas
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        textField.layer.cornerRadius = 16
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.purple.withAlphaComponent(0.3).cgColor
        
        // Padding interno
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        textField.leftViewMode = .always
        
        // Icono
        let iconImageView = UIImageView(image: UIImage(systemName: iconName))
        iconImageView.tintColor = UIColor.purple
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.frame = CGRect(x: 15, y: 15, width: 20, height: 20)
        textField.leftView?.addSubview(iconImageView)
        
        // Placeholder
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )
        
        // Texto
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 16)
    }
    
    private func configureTextFields() {
        // Configurar emailTextField
        styleTextField(emailTextField, placeholder: "Email", iconName: "envelope.fill")
        
        // Configurar passwordTextField
        styleTextField(passwordTextField, placeholder: "Contraseña", iconName: "lock.fill")
        passwordTextField.isSecureTextEntry = true
        
        // Agregar botón para mostrar/ocultar contraseña
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.fill"), for: .selected)
        eyeButton.tintColor = UIColor.white.withAlphaComponent(0.6)
        eyeButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always
    }
    
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
            sender.isSelected.toggle()
            passwordTextField.isSecureTextEntry = !sender.isSelected
        }

    @IBAction func loginTapped(_ sender: UIButton) {
        // Animación del botón
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            }
        }

        // Validación básica
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Por favor completa todos los campos")
            return
        }

        viewModel.login(email: email, password: password) { user, error in
            DispatchQueue.main.async {

                if let user = user {
                    print("Login correcto → \(user.username)")

                    // Cambiamos la navegacion para que sea visible el bottom navigation
                    let tabBar = TabBarController()
                    
                    guard let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate else {
                        return
                    }
                    
                    sceneDelegate.window?.rootViewController = tabBar
                    sceneDelegate.window?.makeKeyAndVisible()
                    


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
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    }

extension UIColor {
    static let purple = UIColor(red: 122/255, green: 76/255, blue: 224/255, alpha: 1)
    static let indigo = UIColor(red: 46/255, green: 42/255, blue: 94/255, alpha: 1)
    static let darkBlue = UIColor(red: 14/255, green: 18/255, blue: 32/255, alpha: 1)
}

    

