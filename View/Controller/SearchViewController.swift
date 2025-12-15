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
        view.backgroundColor = .systemBackground
        setupSearchBar()
        setupLayout()
        loadInitialData()
    }

    // MARK: - SearchBar
    private func setupSearchBar() {
        searchBar.placeholder = "Buscar juegos"
        searchBar.delegate = self
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

        setupTableView()
        setupPlatformFilters()

        mainStack.addArrangedSubview(tableView)
        mainStack.addArrangedSubview(platformStack)
    }

    // MARK: - TableView
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 44
        tableView.heightAnchor.constraint(equalToConstant: 250).isActive = true
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
            let button = UIButton(type: .system)
            button.setTitle(item.0, for: .normal)
            button.tag = item.1
            button.backgroundColor = .systemGray5
            button.layer.cornerRadius = 14
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true
            button.addTarget(self, action: #selector(platformTapped(_:)), for: .touchUpInside)
            platformStack.addArrangedSubview(button)
        }
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
