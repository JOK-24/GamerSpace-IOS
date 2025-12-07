//
//  ViewController.swift
//  GameSpace
//
//  Created by DESIGN on 4/12/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    var user: UserResponseDTO?

        @IBOutlet weak var welcomeLabel: UILabel!

        override func viewDidLoad() {
            super.viewDidLoad()

            title = "Inicio"

            if let user = user {
                welcomeLabel.text = "Hola, \(user.username)"
            }
        }
    }
