//
//  GameTrailersCell.swift
//  GameSpace
//
//  Created by DAMII on 17/12/25.
//

import UIKit

class GameTrailersCell: UITableViewCell {

    static let identifier = "GameTrailersCell"

    private var trailers: [Trailer] = []

    var onTrailerTap: ((Trailer) -> Void)?

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 120)
        layout.minimumLineSpacing = 12
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TrailerCollectionCell.self, forCellWithReuseIdentifier: TrailerCollectionCell.identifier)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(viewModel: GameDetailViewModel) {
        trailers = viewModel.trailers
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension GameTrailersCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        trailers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrailerCollectionCell.identifier, for: indexPath) as! TrailerCollectionCell
        let trailer = trailers[indexPath.item]
        cell.configure(trailer: trailer)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GameTrailersCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let trailer = trailers[indexPath.item]
        onTrailerTap?(trailer)
    }
}

// MARK: - TrailerCollectionCell
class TrailerCollectionCell: UICollectionViewCell {

    static let identifier = "TrailerCollectionCell"

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -4),
            nameLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -4),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(trailer: Trailer) {
        nameLabel.text = trailer.name
        if let url = URL(string: trailer.preview) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
<<<<<<< HEAD
=======

>>>>>>> 611f1cefdf5cad74c1e555705fbd25e7d4a2a845
