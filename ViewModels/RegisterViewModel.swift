//
//  RegisterViewModel.swift
//  GameSpace
//
//  Created by DESIGN on 16/12/25.
//


import Foundation

class RegisterViewModel {
    
func register(
        email: String,
        username: String,
        password: String,
        completion: @escaping (Bool, String?) -> Void
    ) {
        // Validación básica
        guard !email.isEmpty, !username.isEmpty, !password.isEmpty else {
            completion(false, "Completa todos los campos")
            return
        }

        AuthService.shared.register(
            email: email,
            username: username,
            password: password
        ) { user, errorMessage in

            if let user = user {
                //Guardamos username para el welcome
                UserDefaults.standard.set(user.username, forKey: AppDefaults.username)

                //Marcamos como nuevo usuario (para mostrar welcome)
                UserDefaults.standard.set(false, forKey: AppDefaults.hasSeenWelcome)

                completion(true, nil)
            } else {
                completion(false, errorMessage ?? "Error desconocido")
            }
        }
    }
}
