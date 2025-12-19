//
//  GenderViewController.swift
//  GameSpace
//
//  Created by DESIGN on 15/12/25.
//

import UIKit

class GenreViewController: UIViewController {

    private let viewModel: GenreViewModel
        private let collectionView: UICollectionView

        init(genreSlug: String, title: String) {
            self.viewModel = GenreViewModel(genreSlug: genreSlug)

            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 16, height: 180)
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 12

            self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

            super.init(nibName: nil, bundle: nil)
            self.title = title
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(GameGridCell.self, forCellWithReuseIdentifier: GameGridCell.identifier)

            view.addSubview(collectionView)
            collectionView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

            viewModel.fetchGames {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
extension GenreViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GameGridCell.identifier,
            for: indexPath
        ) as! GameGridCell

        let game = viewModel.game(at: indexPath.item)
        cell.configure(with: game)

        return cell
    }
}

extension GenreViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        let game = viewModel.game(at: indexPath.item)

        let detailVM = GameDetailViewModel(gameId: game.id)
        let detailVC = GameDetailViewController(viewModel: detailVM)

        navigationController?.pushViewController(detailVC, animated: true)
    }
}
