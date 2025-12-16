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

    // MARK: - Populares
    func getPopularGames(completion: @escaping ([Game]) -> Void) {
        let urlString = "\(baseURL)/games?key=\(apiKey)&page_size=20"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            do {
                let result = try JSONDecoder().decode(GameResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(result.results)
                }
            } catch {
                print("Error decodificando RAWG:", error)
            }
        }.resume()
    }

    // MARK: - Búsqueda por texto
    func searchGames(query: String, completion: @escaping ([Game]) -> Void) {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURL)/games?key=\(apiKey)&search=\(encodedQuery)&page_size=10"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            do {
                let result = try JSONDecoder().decode(GameResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(result.results)
                }
            } catch {
                print("Error buscando juegos:", error)
            }
        }.resume()
    }

    // MARK: - Juegos por plataforma
    func getGamesByPlatform(platformId: Int, completion: @escaping ([Game]) -> Void) {
        let urlString = "\(baseURL)/games?key=\(apiKey)&platforms=\(platformId)&page_size=20"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            do {
                let result = try JSONDecoder().decode(GameResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(result.results)
                }
            } catch {
                print("Error plataforma:", error)
            }
        }.resume()
    }

    // MARK: - Juegos por género (slug)
    func getGamesByGenre(slug: String, completion: @escaping ([Game]) -> Void) {
        let urlString = "\(baseURL)/games?key=\(apiKey)&genres=\(slug)&page_size=20"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data else { return }

            do {
                let result = try JSONDecoder().decode(GameResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(result.results)
                }
            } catch {
                print("Error género (slug):", error)
            }
        }.resume()
    }

}
