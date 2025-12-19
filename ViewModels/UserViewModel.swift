//
//  UserViewModel.swift
//  GameSpace
//
//  Created by DESIGN on 18/12/25.
//

import Foundation

class UserViewModel {
    
    // Obtenemos el username guardado
    var username: String {
        UserDefaults.standard.string(forKey: "username") ?? "Usuario"
    }

    // Obtenemos el email guardado
    var email: String {
        UserDefaults.standard.string(forKey: "email") ?? "correo@ejemplo.com"
    }

    // Función para cerrar sesión
    func logout() {
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "userId")
    }
}
