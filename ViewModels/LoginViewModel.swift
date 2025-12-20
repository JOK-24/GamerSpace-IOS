//
//  LoginViewModel.swift
//  GameSpace
//
//  Created by DESIGN on 13/12/25.
//

import Foundation

class LoginViewModel {
    
    func login(
            email: String,
            password: String,
            completion: @escaping (UserResponseDTO?, String?) -> Void
        ) {

            // Validación básica
            guard !email.isEmpty, !password.isEmpty else {
                completion(nil, "Por favor completa todos los campos")
                return
            }

            // Validación simple de email
            guard isValidEmail(email) else {
                completion(nil, "El email no tiene un formato válido")
                return
            }

            // Llamada al servicio
            AuthService.shared.login(email: email, password: password) { user, error in

                if let user = user {

                    // 🔐 Guardamos datos del usuario
                    UserDefaults.standard.set(user.id, forKey: AppDefaults.userId)
                    UserDefaults.standard.set(user.username, forKey: AppDefaults.username)
                    UserDefaults.standard.set(user.email, forKey: AppDefaults.email)

                    // ⚠️ Importante:
                    // En login NO tocamos hasSeenWelcome
                    // (solo se resetea en register)

                    completion(user, nil)

                } else {
                    completion(nil, error ?? "Error desconocido")
                }
            }
        }

        // MARK: - Helpers
        private func isValidEmail(_ email: String) -> Bool {
            email.contains("@") && email.contains(".")
        }
    }

