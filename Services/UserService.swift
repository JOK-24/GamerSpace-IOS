//
//  UserService.swift
//  GameSpace
//
//  Created by DESIGN on 18/12/25.
//

import Foundation

class UserService {

    static let shared = UserService()
    private init() {}

    
    private let baseURL = "https://gamerapp-backend.onrender.com"
    
    // PUT /users/{id}/profile
    func updateProfile(
        userId: Int,
        username: String,
        completion: @escaping (Bool, String?) -> Void
    ) {

        let url = URL(string: "\(baseURL)/users/\(userId)/profile")!

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = [
            "username": username
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { _, response, error in

            guard error == nil else {
                completion(false, "Error de conexión")
                return
            }

            DispatchQueue.main.async {
                completion(true, nil)
            }

        }.resume()
    }

    // PUT /users/{id}/password
    func changePassword(
        userId: Int,
        currentPassword: String,
        newPassword: String,
        completion: @escaping (Bool, String?) -> Void
    ) {

        let url = URL(string: "\(baseURL)/users/\(userId)/password")!

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = [
            "currentPassword": currentPassword,
            "newPassword": newPassword
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { _, response, error in

            guard error == nil else {
                completion(false, "Error de conexión")
                return
            }

            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 403 {
                completion(false, "Contraseña actual incorrecta")
                return
            }

            DispatchQueue.main.async {
                completion(true, nil)
            }

        }.resume()
    }
}
