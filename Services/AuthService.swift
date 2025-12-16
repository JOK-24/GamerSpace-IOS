//
//  AuthService.swift
//  GameSpace
//
//  Created by DESIGN on 4/12/25.
//

import Foundation

class AuthService {

    static let shared = AuthService()
    private init() {}

    // URL del BACKEND (Railway)
    private let baseURL = "https://gamerapp-backend.onrender.com/auth"

    // MARK: - LOGIN
    func login(email: String, password: String, completion: @escaping (UserResponseDTO?, String?) -> Void) {

        guard let url = URL(string: "\(baseURL)/login") else { return }

        let body: [String: Any] = [
            "email": email,
            "password": password
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(nil, error.localizedDescription)
                return
            }

            guard let data = data else {
                completion(nil, "No se recibió respuesta del servidor")
                return
            }

            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(ApiResponse<UserResponseDTO>.self, from: data)

                if apiResponse.success, let user = apiResponse.data {
                    completion(user, nil)
                } else {
                    completion(nil, apiResponse.message)
                }

            } catch {
                completion(nil, "Error al procesar la respuesta")
            }

        }.resume()
    }

    // MARK: - REGISTER
    func register(email: String, username: String, password: String, completion: @escaping (UserResponseDTO?, String?) -> Void) {

        guard let url = URL(string: "\(baseURL)/register") else { return }

        let body: [String: Any] = [
            "email": email,
            "username": username,
            "password": password
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(nil, error.localizedDescription)
                return
            }

            guard let data = data else {
                completion(nil, "No se recibió respuesta del servidor")
                return
            }

            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(ApiResponse<UserResponseDTO>.self, from: data)

                if apiResponse.success, let user = apiResponse.data {
                    completion(user, nil)
                } else {
                    completion(nil, apiResponse.message)
                }

            } catch {
                completion(nil, "Error al procesar la respuesta")
            }

        }.resume()
    }
}
