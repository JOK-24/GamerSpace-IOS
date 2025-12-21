//
//  SearchViewController.swift
//  GameSpace
//
//  Created by DESIGN on 15/12/25.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let viewModel = SearchViewModel()
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let platformStack = UIStackView()
    private let mainStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchBar()
        setupLayout()
        loadInitialData()
    }
    
    
    private func setupUI() {
        // Fondo con gradiente
        view.backgroundColor = UIColor.darkBlue
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.darkBlue.cgColor,
            UIColor.indigo.withAlphaComponent(0.3).cgColor,
            UIColor.darkBlue.cgColor
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // Configurar navigation bar
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.darkBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = UIColor.purple
    }
    
    // MARK: - SearchBar
    private func setupSearchBar() {
        searchBar.placeholder = "Buscar juegos"
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        
        // Estilo del search bar
        searchBar.searchTextField.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.leftView?.tintColor = UIColor.purple
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Buscar juegos",
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )
        
        navigationItem.titleView = searchBar
    }
    
    // MARK: - Layout
    private func setupLayout() {
        
        mainStack.axis = .vertical
        mainStack.spacing = 16
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        setupGenreFilters()
        setupTableView()
        setupPlatformFilters()
        
        mainStack.addArrangedSubview(genreStack)
        mainStack.addArrangedSubview(tableView)
        mainStack.addArrangedSubview(platformStack)
    }
    
    // MARK: - TableView
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 60
        tableView.backgroundColor = .clear
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.1)
        tableView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        tableView.layer.cornerRadius = 12
        tableView.clipsToBounds = true
    }
    
    // MARK: - Platform Filters
    private func setupPlatformFilters() {
        
        let platforms: [(String, Int)] = [
            ("PC", 4),
            ("PS3", 16),
            ("PS4", 18),
            ("PS5", 187)
        ]
        
        platformStack.axis = .horizontal
        platformStack.spacing = 12
        platformStack.distribution = .fillEqually
        
        platforms.forEach { item in
            var config = UIButton.Configuration.filled()
            config.title = item.0
            config.baseBackgroundColor = UIColor.purple
            config.baseForegroundColor = .white
            config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)
            config.cornerStyle = .small
            
            let button = UIButton(configuration: config)
            button.tag = item.1
            button.addTarget(self, action: #selector(platformTapped(_:)), for: .touchUpInside)
            platformStack.addArrangedSubview(button)
            
            
            
            /*button.layer.cornerRadius = 14
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true
            button.addTarget(self, action: #selector(platformTapped(_:)), for: .touchUpInside)
            platformStack.addArrangedSubview(button)*/
        }
    }
    
    private let genreStack = UIStackView()
    
    private func setupGenreFilters() {
        genreStack.axis = .horizontal
        genreStack.spacing = 12
        genreStack.distribution = .fillEqually

        for index in 0..<viewModel.numberOfGenres() {
            let genre = viewModel.genre(at: index)

            let button = UIButton(type: .system)
            button.setTitle(genre.name, for: .normal)
            button.backgroundColor = UIColor.white.withAlphaComponent(0.1)
            button.tintColor = .white
            button.layer.cornerRadius = 14
            button.tag = index
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true

            button.addTarget(
                self,
                action: #selector(genreTapped(_:)),
                for: .touchUpInside
            )

            genreStack.addArrangedSubview(button)
        }
    }

    @objc private func genreTapped(_ sender: UIButton) {
        let genre = viewModel.genre(at: sender.tag)

        let vc = GenreViewController(
            genreSlug: genre.slug,
            title: genre.name
        )

        navigationController?.pushViewController(vc, animated: true)
    }

    
    // MARK: - Data
    private func loadInitialData() {
        viewModel.loadPopular {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Actions
    @objc private func platformTapped(_ sender: UIButton) {
        let vc = PlatformViewController(
            platformId: sender.tag,
            title: sender.currentTitle ?? ""
        )
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(query: searchText) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.title(at: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
}
extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let game = viewModel.game(at: indexPath.row)

        let detailVM = GameDetailViewModel(gameId: game.id)
        let detailVC = GameDetailViewController(viewModel: detailVM)

        navigationController?.pushViewController(detailVC, animated: true)
    }
}
