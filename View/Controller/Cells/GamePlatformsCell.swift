//
//  GamePlatformsCell.swift
//  GameSpace
//
//  Created by DAMII on 17/12/25.
//

import UIKit

class GamePlatformsCell: UITableViewCell {

    static let identifier = "GamePlatformsCell"

    private let platformsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(platformsLabel)

        NSLayoutConstraint.activate([
            platformsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            platformsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            platformsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            platformsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(viewModel: GameDetailViewModel) {
        platformsLabel.text = "Plataformas: " + viewModel.platforms.joined(separator: ", ")
    }
}
<<<<<<< HEAD
=======


>>>>>>> 611f1cefdf5cad74c1e555705fbd25e7d4a2a845
