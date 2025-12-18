//
//  SplashViewController.swift
//  GameSpace
//
//  Created by DESIGN on 13/12/25.
//

import UIKit

class SplashViewController: UIViewController {

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "gamepad-line") // tu logo
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        setupLogo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Tiempo de 2 segundos para iniciar el splash
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.goToLogin()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }

    
    private func goToLogin() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)

        //aqui hacemos referencia al ID que le colocamos al NavigationController
        let navController = storyboard.instantiateViewController(withIdentifier: "LoginNavigation")
        
        guard let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate else {
            return
        }

        sceneDelegate.window?.rootViewController = navController
        sceneDelegate.window?.makeKeyAndVisible()

        
    }

    
    // MARK: - Setup Gradient

    private func setupGradientBackground() {
        gradientLayer.colors = [
            UIColor.splashDark.cgColor,
            UIColor.splashIndigo.cgColor,
            UIColor.splashPurple.cgColor
        ]

        gradientLayer.locations = [0.0, 0.6, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    // MARK: - Logo

    private func setupLogo() {
        view.addSubview(logoImageView)

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
extension UIColor {
    static let splashPurple = UIColor(red: 122/255, green: 76/255, blue: 224/255, alpha: 1)
    static let splashIndigo = UIColor(red: 46/255, green: 42/255, blue: 94/255, alpha: 1)
    static let splashDark = UIColor(red: 14/255, green: 18/255, blue: 32/255, alpha: 1)
}

