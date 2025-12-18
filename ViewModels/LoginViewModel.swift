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
        AuthService.shared.login(email: email, password: password) { user, error in
            
            if let user = user {
                // Guardamos datos del usuario
                UserDefaults.standard.set(user.username, forKey: "username")
                UserDefaults.standard.set(user.email, forKey: "email")
                UserDefaults.standard.set(user.id, forKey: "userId")
            }
            
            completion(user, error)
        }
        
    }
}

