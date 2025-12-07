//
//  User.swift
//  GameSpace
//
//  Created by DESIGN on 4/12/25.
//

import Foundation


struct UserResponseDTO: Codable {
    let id: Int
    let email: String
    let username: String
}

struct ApiResponse<T: Codable>: Codable {
    let success: Bool
    let message: String
    let data: T?
}
