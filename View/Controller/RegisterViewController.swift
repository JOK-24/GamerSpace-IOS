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
    
    
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelPassword: UILabel!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    private let viewModel = RegisterViewModel()
    
    // MARK: - Title and Subtitle
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Crear Cuenta"
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Únete a GameSpace"
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
            configureLabels()
            configureButtons()
        }
    
    // MARK: - UI Setup
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
        
        // Agregar título
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        
        // Ocultar navigation bar
        //navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    private func setupConstraints() {
        // Activar constraints programáticos
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        labelUsername.translatesAutoresizingMaskIntoConstraints = false
        labelPassword.translatesAutoresizingMaskIntoConstraints = false
        btnRegister.translatesAutoresizingMaskIntoConstraints = false
        //btnBackToLogin.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            
            // Subtitle Label
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            
            // Email Label
            labelEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            labelEmail.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -8),
            
            // Email TextField
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 60),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Username Label
            labelUsername.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            labelUsername.bottomAnchor.constraint(equalTo: usernameTextField.topAnchor, constant: -8),
            
            // Username TextField
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 36),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Password Label
            labelPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            labelPassword.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -8),
            
            // Password TextField
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 36),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Register Button
            btnRegister.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnRegister.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 32),
            btnRegister.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            btnRegister.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            btnRegister.heightAnchor.constraint(equalToConstant: 50),
            
            // Back to Login Button
            /*btnBackToLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnBackToLogin.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)*/
        ])
    }
    
    
    private func configureLabels() {
        // Estilo para label Email
        labelEmail.text = "Email"
        labelEmail.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        labelEmail.textColor = UIColor.white.withAlphaComponent(0.9)
        
        // Estilo para label Username
        labelUsername.text = "Nombre de usuario"
        labelUsername.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        labelUsername.textColor = UIColor.white.withAlphaComponent(0.9)
        
        // Estilo para label Password
        labelPassword.text = "Contraseña"
        labelPassword.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        labelPassword.textColor = UIColor.white.withAlphaComponent(0.9)
    }
    
    
    private func configureButtons() {
        // Estilo del botón de Register
        btnRegister.backgroundColor = UIColor.purple
        btnRegister.layer.cornerRadius = 16
        btnRegister.setTitle("Crear Cuenta", for: .normal)
        btnRegister.setTitleColor(.white, for: .normal)
        btnRegister.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        // Estilo del botón de Back to Login
        /*btnBackToLogin.backgroundColor = .clear
        btnBackToLogin.setTitle("¿Ya tienes cuenta? Inicia sesión", for: .normal)
        btnBackToLogin.setTitleColor(UIColor.purple, for: .normal)
        btnBackToLogin.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)*/
    }
    
    
    private func styleTextField(_ textField: UITextField, placeholder: String, iconName: String) {
        // Fondo con esquinas redondeadas
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
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
        styleTextField(emailTextField, placeholder: "ejemplo@email.com", iconName: "envelope.fill")
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        
        // Configurar usernameTextField
        styleTextField(usernameTextField, placeholder: "nombre_usuario", iconName: "person.fill")
        usernameTextField.autocapitalizationType = .none
        
        // Configurar passwordTextField
        styleTextField(passwordTextField, placeholder: "••••••••", iconName: "lock.fill")
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

        @IBAction func registerTapped(_ sender: UIButton) {
            
            // Animación del botón
            UIView.animate(withDuration: 0.1, animations: {
                sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { _ in
                UIView.animate(withDuration: 0.1) {
                    sender.transform = .identity
                }
            }

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
