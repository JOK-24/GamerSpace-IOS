//
//  ProfileOptionButton.swift
//  GameSpace
//
//  Created by DESIGN on 18/12/25.
//

import UIKit

class ProfileOptionButton: UIButton {

    init(icon: String, title: String, isDestructive: Bool = false) {
        super.init(frame: .zero)

        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = isDestructive ? .systemRed : .purple
        iconView.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = isDestructive ? .systemRed : .white
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let arrow = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrow.tintColor = .gray
        arrow.translatesAutoresizingMaskIntoConstraints = false

        let container = UIView()
        container.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        container.layer.cornerRadius = 14
        container.translatesAutoresizingMaskIntoConstraints = false

        addSubview(container)
        container.addSubview(iconView)
        container.addSubview(titleLabel)
        container.addSubview(arrow)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),

            iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            iconView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 22),

            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),

            arrow.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            arrow.centerYAnchor.constraint(equalTo: container.centerYAnchor),

            heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

