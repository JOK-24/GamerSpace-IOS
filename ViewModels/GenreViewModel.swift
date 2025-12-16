//
//  GenreViewModel.swift
//  GameSpace
//
//  Created by DESIGN on 15/12/25.
//

import Foundation

class GenreViewModel {

    private(set) var games: [Game] = []
    private let genreSlug: String

    init(genreSlug: String) {
        self.genreSlug = genreSlug
    }

    func fetchGames(completion: @escaping () -> Void) {
        RawgService.shared.getGamesByGenre(slug: genreSlug) { games in
            self.games = Array(games.prefix(12))
            completion()
        }
    }

    func numberOfItems() -> Int {
        games.count
    }

    func game(at index: Int) -> Game {
        games[index]
    }
}

