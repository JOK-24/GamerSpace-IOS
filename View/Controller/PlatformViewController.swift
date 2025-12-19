//
//  PlatformViewController.swift
//  GameSpace
//
//  Created by DESIGN on 15/12/25.
//

import UIKit

class PlatformViewController: UIViewController {

    private let viewModel: PlatformViewModel
    private let collectionView: UICollectionView

    init(platformId: Int, title: String) {
        self.viewModel = PlatformViewModel(platformId: platformId)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 110, height: 160)
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollection()
        viewModel.fetch {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    private func setupCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GameGridCell.self, forCellWithReuseIdentifier: GameGridCell.identifier)
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
}

extension PlatformViewController: UICollectionViewDataSource {
    func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.games.count
    }

    func collectionView(_ cv: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = cv.dequeueReusableCell(withReuseIdentifier: GameGridCell.identifier, for: indexPath) as! GameGridCell
        cell.configure(with: viewModel.games[indexPath.item])
        return cell
    }
}


extension PlatformViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        let game = viewModel.games[indexPath.item]

        let detailVM = GameDetailViewModel(gameId: game.id)
        let detailVC = GameDetailViewController(viewModel: detailVM)

        navigationController?.pushViewController(detailVC, animated: true)
    }
}

