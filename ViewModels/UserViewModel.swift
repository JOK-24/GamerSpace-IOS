//
//  UserViewModel.swift
//  GameSpace
//
//  Created by DESIGN on 18/12/25.
//

import Foundation

class UserViewModel {
    
    // Servicio compartido
    private let userService = UserService.shared

    // MARK: - Datos guardados localmente

    var userId: Int {
        UserDefaults.standard.integer(forKey: "userId")
    }

    var username: String {
        UserDefaults.standard.string(forKey: "username") ?? "Usuario"
    }

    var email: String {
        UserDefaults.standard.string(forKey: "email") ?? "correo@ejemplo.com"
    }

    // Iniciales para el avatar (ej: AB)
    var initials: String {
        let letters = username.prefix(2)
        return String(letters).uppercased()
    }

    // MARK: - Cambiar nombre de usuario

    /// Actualiza el nombre del usuario
    func updateUsername(
        _ newUsername: String,
        completion: @escaping (Bool, String?) -> Void
    ) {

        userService.updateProfile(
            userId: userId,
            username: newUsername
        ) { success, message in

            if success {
                // Guardamos el nuevo nombre localmente
                UserDefaults.standard.set(newUsername, forKey: "username")
            }

            completion(success, message)
        }
    }

    // MARK: - Cambiar contraseña

    /// Cambia la contraseña del usuario
    func changePassword(
        current: String,
        new: String,
        completion: @escaping (Bool, String?) -> Void
    ) {

        userService.changePassword(
            userId: userId,
            currentPassword: current,
            newPassword: new
        ) { success, message in
            completion(success, message)
        }
    }
}
