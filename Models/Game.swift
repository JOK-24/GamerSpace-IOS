//
//  Game.swift
//  GameSpace
//
//  Created by DESIGN on 4/12/25.
//

import Foundation

struct GameResponse: Codable {
    let results: [Game]
}

struct Game: Codable {
    let id: Int
    let name: String
    let background_image: String?
}
