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
            completion(user, error)
        }
    }
}
