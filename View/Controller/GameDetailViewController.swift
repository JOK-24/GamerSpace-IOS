//
//  GameDetailViewController.swift
//  GameSpace
//
//  Created by DAMII on 16/12/25.
//

import UIKit

class GameDetailViewController: UIViewController {

    // MARK: - Propiedades
    private let viewModel: GameDetailViewModel

    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        return tv
    }()

    // MARK: - Init
    init(viewModel: GameDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        fetchData()
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self

        // Registrar celdas
        tableView.register(GameSummaryCell.self, forCellReuseIdentifier: GameSummaryCell.identifier)
        tableView.register(GameDescriptionCell.self, forCellReuseIdentifier: GameDescriptionCell.identifier)
        tableView.register(GamePlatformsCell.self, forCellReuseIdentifier: GamePlatformsCell.identifier)
        tableView.register(GameTrailersCell.self, forCellReuseIdentifier: GameTrailersCell.identifier)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - Fetch Data
    private func fetchData() {
        viewModel.fetchGameDetail { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension GameDetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4 // Summary, Description, Platforms, Trailers
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {

        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: GameSummaryCell.identifier, for: indexPath) as! GameSummaryCell
            cell.configure(viewModel: viewModel)
            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: GameDescriptionCell.identifier, for: indexPath) as! GameDescriptionCell
            cell.configure(viewModel: viewModel)
            return cell

        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: GamePlatformsCell.identifier, for: indexPath) as! GamePlatformsCell
            cell.configure(viewModel: viewModel)
            return cell

        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: GameTrailersCell.identifier, for: indexPath) as! GameTrailersCell
            cell.configure(viewModel: viewModel)
            cell.onTrailerTap = { trailer in
                // Acción al tocar un trailer, p.ej. abrir un video player
                print("Trailer seleccionado: \(trailer.name)")
            }
            return cell

        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension GameDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 250 // Summary
        case 1: return UITableView.automaticDimension // Description
        case 2: return 60 // Platforms
        case 3: return 140 // Trailers
        default: return 44
        }
    }
}
