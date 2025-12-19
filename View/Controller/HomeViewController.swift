//
//  ViewController.swift
//  GameSpace
//
//  Created by DESIGN on 4/12/25.
//

import UIKit

    enum HomeSection: Int, CaseIterable {
        case trending, newReleases, upcoming
        
        var title: String {
            switch self {
            case .trending: return "Populares / Trending"
            case .newReleases: return "Nuevos lanzamientos"
            case .upcoming: return "Próximos estrenos"
            }
        }
    }

    class HomeViewController: UIViewController {
        
        var viewModel: HomeViewModel!

        
        private let scrollView = UIScrollView()
        private let contentStack = UIStackView()
        private var collections: [UICollectionView] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            viewModel = HomeViewModel()
            setupNavigationBar()
            setupLayout()
            setupSections()
            
            viewModel.fetchGames { [weak self] in
                self?.collections.forEach { $0.reloadData() }
            }
        }
        
    //
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            showWelcomeIfNeeded()
        }
    //
        private func showWelcomeIfNeeded() {
            if viewModel.shouldShowWelcome() {
                showWelcomeAlert()
            }
        }

    //
        private func showWelcomeAlert() {
            let username = viewModel.getUsername()
            
            let alert = UIAlertController(
                title: "Bienvenido a GameSpace,\(username) 🎮",
                message: """
                Aquí podrás descubrir juegos populares, nuevos lanzamientos
                y explorar por géneros.

                Usa el buscador para encontrar tus juegos favoritos.
                """,
                preferredStyle: .alert
            )

            let acceptAction = UIAlertAction(title: "Entendido", style: .default) { [weak self] _ in
                self?.viewModel.markWelcomeAsSeen()
            }

            alert.addAction(acceptAction)
            present(alert, animated: true)
        }


    //
        
        private func setupNavigationBar() {
            let logo = UIImageView(image: UIImage(named: "logo"))//falta img
            logo.contentMode = .scaleAspectFit
            logo.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logo)
            
           
            let searchButton = UIButton(type: .system)
                searchButton.setTitle("Buscar juegos", for: .normal)
                searchButton.backgroundColor = .systemGray6
                searchButton.layer.cornerRadius = 10
                searchButton.frame = CGRect(x: 0, y: 0, width: 200, height: 36)
                searchButton.addTarget(self, action: #selector(openSearch), for: .touchUpInside)

                navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
        }
        
        @objc private func openSearch() {
            let searchVC = SearchViewController()
            navigationController?.pushViewController(searchVC, animated: true)
        }
        
        private func setupLayout() {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            contentStack.translatesAutoresizingMaskIntoConstraints = false
            contentStack.axis = .vertical
            contentStack.spacing = 24
            
            view.addSubview(scrollView)
            scrollView.addSubview(contentStack)
            
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
                contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
                contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
                contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
            ])
        }
        
        private func setupSections() {
            HomeSection.allCases.forEach { section in
                addGameSection(title: section.title, section: section)
            }
            addGenreSection()
        }
        
        private func addGameSection(title: String, section: HomeSection) {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.font = .boldSystemFont(ofSize: 20)
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 160, height: 220)
            layout.minimumLineSpacing = 12
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = .clear
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.heightAnchor.constraint(equalToConstant: 230).isActive = true
            
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.tag = section.rawValue
            collectionView.register(GameCardCell.self, forCellWithReuseIdentifier: GameCardCell.identifier)
            
            collections.append(collectionView)
            
            contentStack.addArrangedSubview(titleLabel)
            contentStack.addArrangedSubview(collectionView)
        }
        
        private let genres: [(name: String, slug: String)] = [
            ("RPG", "role-playing-games-rpg"),
            ("Acción", "action"),
            ("Aventura", "adventure"),
            ("Estrategia", "strategy"),
            ("Indie", "indie")
        ]
        
        private func addGenreSection() {
            let titleLabel = UILabel()
            titleLabel.text = "Por género"
            titleLabel.font = .boldSystemFont(ofSize: 20)

            let genreStack = UIStackView()
            genreStack.axis = .horizontal
            genreStack.spacing = 12
            genreStack.distribution = .fillEqually

            genres.enumerated().forEach { index, genre in
                let button = UIButton(type: .system)
                button.setTitle(genre.name, for: .normal)
                button.backgroundColor = .systemGray5
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

            contentStack.addArrangedSubview(titleLabel)
            contentStack.addArrangedSubview(genreStack)
        }
        
        @objc private func genreTapped(_ sender: UIButton) {
            let genre = genres[sender.tag]
            let vc = GenreViewController(
                genreSlug: genre.slug,
                title: genre.name
            )
            navigationController?.pushViewController(vc, animated: true)
        }

    }

    extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            guard let section = HomeSection(rawValue: collectionView.tag) else { return 0 }
            switch section {
            case .trending: return viewModel.trendingGames.count
            case .newReleases: return viewModel.newGames.count
            case .upcoming: return viewModel.upcomingGames.count
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCardCell.identifier, for: indexPath) as! GameCardCell
            guard let section = HomeSection(rawValue: collectionView.tag) else { return cell }
            
            let game: Game
            switch section {
            case .trending: game = viewModel.trendingGames[indexPath.item]
            case .newReleases: game = viewModel.newGames[indexPath.item]
            case .upcoming: game = viewModel.upcomingGames[indexPath.item]
            }
            
            cell.configure(with: game)
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

                    guard let section = HomeSection(rawValue: collectionView.tag) else { return }

                    let game: Game
                    switch section {
                    case .trending:
                        game = viewModel.trendingGames[indexPath.item]
                    case .newReleases:
                        game = viewModel.newGames[indexPath.item]
                    case .upcoming:
                        game = viewModel.upcomingGames[indexPath.item]
                    }

                    let detailViewModel = GameDetailViewModel(gameId: game.id)

                    let detailVC = GameDetailViewController(viewModel: detailViewModel)

                    navigationController?.pushViewController(detailVC, animated: true)
                }
    }
