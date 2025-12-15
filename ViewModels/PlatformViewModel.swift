//
//  PlatformViewModel.swift
//  GameSpace
//
//  Created by DESIGN on 15/12/25.
//

import Foundation

class PlatformViewModel {

    private(set) var games: [Game] = []
    private let platformId: Int

    init(platformId: Int) {
        self.platformId = platformId
    }

    func fetch(completion: @escaping () -> Void) {
        RawgService.shared.getGamesByPlatform(platformId: platformId) { games in
            // Pedimos al menos 12
            self.games = Array(games.prefix(12))
            completion()
        }
    }
}

