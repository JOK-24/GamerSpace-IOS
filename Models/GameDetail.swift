//
//  GameDetail.swift
//  GameSpace
//
//  Created by DAMII on 16/12/25.
//

import Foundation

struct GameDetail: Codable {
    let id: Int
    let name: String
    let descriptionRaw: String
    let rating: Double?
    let backgroundImage: String?
    let platforms: [Platform]
    let genres: [Genre]
    let trailers: [Trailer]?

    enum CodingKeys: String, CodingKey {
        case id, name, rating
        case descriptionRaw = "description_raw"
        case backgroundImage = "background_image"
        case platforms, genres
        case trailers = "movies"
    }
}

struct Platform: Codable {
    let platform: PlatformInfo
}

struct PlatformInfo: Codable {
    let id: Int
    let name: String
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct Trailer: Codable {
    let id: Int
    let name: String
    let preview: String
    let data: TrailerData
}

struct TrailerData: Codable {
    let max: String
}
<<<<<<< HEAD
=======

>>>>>>> 611f1cefdf5cad74c1e555705fbd25e7d4a2a845
