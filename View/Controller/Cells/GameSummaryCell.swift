//
//  GameSummaryCell.swift
//  GameSpace
//
//  Created by DAMII on 17/12/25.
//

import UIKit

class GameSummaryCell: UITableViewCell {

    static let identifier = "GameSummaryCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingLabel)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 180),

            titleLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),

            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            ratingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(viewModel: GameDetailViewModel) {
        titleLabel.text = viewModel.title
        ratingLabel.text = "⭐️ \(viewModel.ratingText)"
        if let url = viewModel.backgroundImageURL {
            // Puedes usar tu librería favorita como SDWebImage o Kingfisher
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.backgroundImageView.image = UIImage(data: data)
                    }
                }
            }
        } else {
            backgroundImageView.image = nil
        }
    }
}
<<<<<<< HEAD
=======


>>>>>>> 611f1cefdf5cad74c1e555705fbd25e7d4a2a845
