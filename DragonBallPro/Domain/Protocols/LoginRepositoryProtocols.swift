//
//  LoginRepositoryProtocols.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 16/3/24.
//

import Foundation

protocol LoginRepositoryProtocol {
    func loginApp(user: String, password: String) async throws -> String
}
