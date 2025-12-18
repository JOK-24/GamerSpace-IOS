import UIKit

class UserViewController: UIViewController {

    private let viewModel = UserViewModel()

    private let avatarImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let emailLabel = UILabel()
    private let logoutButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Perfil"

        setupUI()
        loadData()
    }

    private func setupUI() {

        avatarImageView.image = UIImage(systemName: "person.circle.fill")
        avatarImageView.tintColor = .systemBlue
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        usernameLabel.font = .boldSystemFont(ofSize: 24)
        usernameLabel.textAlignment = .center

        emailLabel.font = .systemFont(ofSize: 16)
        emailLabel.textColor = .secondaryLabel
        emailLabel.textAlignment = .center

        logoutButton.setTitle("Cerrar sesión", for: .normal)
        logoutButton.tintColor = .systemRed
        logoutButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)

        let infoLabel = UILabel()
        infoLabel.text = "🎮 Gamer registrado en GameSpace"
        infoLabel.font = .systemFont(ofSize: 14)
        infoLabel.textColor = .secondaryLabel
        infoLabel.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [
            avatarImageView,
            usernameLabel,
            emailLabel,
            infoLabel,
            logoutButton
        ])

        stack.axis = .vertical
        stack.spacing = 18
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 130),
            avatarImageView.heightAnchor.constraint(equalToConstant: 130),

            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }


    private func loadData() {
        usernameLabel.text = viewModel.username
        emailLabel.text = viewModel.email
    }

    @objc private func logoutTapped() {

        // 1. Cargar storyboard del Login
        let storyboard = UIStoryboard(name: "Login", bundle: nil)

        // 2. Instanciar LoginViewController
        let loginVC = storyboard.instantiateViewController(
            withIdentifier: "LoginViewController"
        )

        // 3. Envolver el Login en un UINavigationController (CLAVE)
        let nav = UINavigationController(rootViewController: loginVC)

        // 4. Cambiar el rootViewController
        if let sceneDelegate = UIApplication.shared.connectedScenes
            .first?.delegate as? SceneDelegate {

            sceneDelegate.window?.rootViewController = nav
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }


}
