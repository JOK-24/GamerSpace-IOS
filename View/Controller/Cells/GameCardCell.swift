//
//  GameCardCell.swift
//  GameSpace
//
//  Created by DESIGN on 13/12/25.
//

import UIKit

class GameCardCell: UICollectionViewCell {
    
    static let identifier = "GameCardCell"
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        
        // Configuración del label
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .center
        nameLabel.textColor = .white
        nameLabel.shadowColor = UIColor.black.withAlphaComponent(0.8)
        nameLabel.shadowOffset = CGSize(width: 0, height: 1)
        
        let stack = UIStackView(arrangedSubviews: [imageView, nameLabel])
        stack.axis = .vertical
        stack.spacing = 6
        
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with game: Game) {
        nameLabel.text = game.name
        
        if let urlString = game.background_image,
           let url = URL(string: urlString) {
            // Descarga simple de imagen
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }.resume()
        } else {
            imageView.image = UIImage(systemName: "photo")
        }
    }
}


