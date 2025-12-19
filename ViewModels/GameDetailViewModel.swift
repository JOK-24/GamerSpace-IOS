//
//  GameDetailViewModel.swift
//  GameSpace
//
//  Created by DAMII on 16/12/25.
//

import Foundation

class GameDetailViewModel {

    private let gameId: Int
    private let service: RawgService

    private(set) var gameDetail: GameDetail?

    // MARK: - Init
    init(gameId: Int, service: RawgService = .shared) {
        self.gameId = gameId
        self.service = service
    }

    // MARK: - Carga de datos
    func fetchGameDetail(completion: @escaping () -> Void) {
        service.getGameDetail(id: gameId) { [weak self] detail in
            self?.gameDetail = detail
            completion()
        }
    }

    // MARK: - Datos formateados para la UI
    var title: String {
        gameDetail?.name ?? "Cargando..."
    }

    var descriptionText: String {
        gameDetail?.descriptionRaw ?? ""
    }

    var ratingText: String {
        if let rating = gameDetail?.rating {
            return String(format: "%.1f", rating)
        }
        return "N/A"
    }

    var backgroundImageURL: URL? {
        guard let urlString = gameDetail?.backgroundImage else { return nil }
        return URL(string: urlString)
    }

    var platforms: [String] {
        gameDetail?.platforms.map { $0.platform.name } ?? []
    }

    var genres: [String] {
        gameDetail?.genres.map { $0.name } ?? []
    }

    var trailers: [Trailer] {
        gameDetail?.trailers ?? []
    }
}

