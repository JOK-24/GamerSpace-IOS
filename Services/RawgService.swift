//
//  RawgService.swift
//  GameSpace
//
//  Created by DESIGN on 4/12/25.
//

import Foundation

class RawgService {

    static let shared = RawgService()
    private init() {}

    private let apiKey = ""
    private let baseURL = "https://api.rawg.io/api"

    func getPopularGames(completion: @escaping ([Game]) -> Void) {

        let urlString = "\(baseURL)/games?key=\(apiKey)&page_size=20"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            let decoder = JSONDecoder()

            do {
                let result = try decoder.decode(GameResponse.self, from: data)
                completion(result.results)
            } catch {
                print("Error decodificando RAWG: \(error)")
            }
        }.resume()
    }
}

