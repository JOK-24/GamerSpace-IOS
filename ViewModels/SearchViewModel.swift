//
//  SearchViewModel.swift
//  GameSpace
//
//  Created by DESIGN on 15/12/25.
//

import Foundation

class SearchViewModel {

    private var games: [Game] = []

    func loadPopular(completion: @escaping () -> Void) {
        RawgService.shared.getPopularGames { games in
            self.games = Array(games.prefix(5))
            DispatchQueue.main.async {
                completion()
            }
        }
    }

    func search(query: String, completion: @escaping () -> Void) {
        guard !query.isEmpty else {
            loadPopular(completion: completion)
            return
        }

        RawgService.shared.searchGames(query: query) { games in
            self.games = games
            DispatchQueue.main.async {
                completion()
            }
        }
    }

    func numberOfRows() -> Int {
        games.count
    }

    func title(at index: Int) -> String {
        guard index < games.count else { return "" }
        return games[index].name
    }
    
    func game(at index: Int) -> Game {
            games[index]
        }
}
