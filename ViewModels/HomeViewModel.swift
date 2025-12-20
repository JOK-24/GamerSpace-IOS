//
//  HomeViewModel.swift
//  GameSpace
//
//  Created by DESIGN on 13/12/25.
//

import Foundation

class HomeViewModel {

    private let apiKey = "5616cbd1b2e147b49763301d930f4d22"
       
       var trendingGames: [Game] = []
       var newGames: [Game] = []
       var upcomingGames: [Game] = []
       
       func fetchGames(completion: @escaping () -> Void) {
           let group = DispatchGroup()
           
           // Trending
           group.enter()
           fetchGames(endpoint: "games/lists/main?ordering=-added&page_size=10") { games in
               self.trendingGames = games
               group.leave()
           }
           
           // New releases
           group.enter()
           fetchGames(endpoint: "games?dates=2025-01-01,2025-12-31&ordering=-released&page_size=10") { games in
               self.newGames = games
               group.leave()
           }
           
           // Upcoming
           group.enter()
           fetchGames(endpoint: "games?dates=2026-01-01,2026-12-31&ordering=-added&page_size=10") { games in
               self.upcomingGames = games
               group.leave()
           }
           
           group.notify(queue: .main) {
               completion()
           }
       }
       
       private func fetchGames(endpoint: String, completion: @escaping ([Game]) -> Void) {
           let urlString = "https://api.rawg.io/api/\(endpoint)&key=\(apiKey)"
           guard let url = URL(string: urlString) else { completion([]); return }
           
           URLSession.shared.dataTask(with: url) { data, _, _ in
               guard let data = data else { completion([]); return }
               do {
                   let response = try JSONDecoder().decode(GameResponse.self, from: data)
                   completion(response.results)
               } catch {
                   print("Error decoding: \(error)")
                   completion([])
               }
           }.resume()
       }
    //UserDefault
    func shouldShowWelcome() -> Bool {
            return !UserDefaults.standard.bool(
                forKey: AppDefaults.hasSeenWelcome
            )
        }

    func markWelcomeAsSeen() {
            UserDefaults.standard.set(
                true,
                forKey: AppDefaults.hasSeenWelcome
            )
        }
    func getUsername() -> String {
        return UserDefaults.standard.string(
            forKey: AppDefaults.username
        ) ?? ""
    }

   }
