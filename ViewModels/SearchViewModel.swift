//
//  SearchViewModel.swift
//  GameSpace
//
//  Created by DESIGN on 15/12/25.
//

import Foundation

class SearchViewModel {

    // MARK: - Games (ya lo tenías)
    private var games: [Game] = []

    // MARK: - Genres (NUEVO)
    let genres: [GenreFilter] = [
        GenreFilter(name: "RPG", slug: "role-playing-games-rpg"),
        GenreFilter(name: "Acción", slug: "action"),
        GenreFilter(name: "Aventura", slug: "adventure"),
        GenreFilter(name: "Estrategia", slug: "strategy"),
        GenreFilter(name: "Indie", slug: "indie")
    ]

    // MARK: - Games logic
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

    // MARK: - TableView helpers
    func numberOfRows() -> Int {
        games.count
    }

    func title(at index: Int) -> String {
        guard index < games.count else { return "" }
        return games[index].name
    }

    // MARK: - Genre helpers (NUEVO)
    func numberOfGenres() -> Int {
        genres.count
    }

    func genre(at index: Int) -> GenreFilter {
        genres[index]
    }
    func game(at index: Int) -> Game {
              games[index]
          }

    
    func game(at index: Int) -> Game {
            games[index]
        }
}
