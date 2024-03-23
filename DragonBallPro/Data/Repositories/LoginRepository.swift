//
//  LoginRepository.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 16/3/24.
//

import Foundation

final class LoginRepository: LoginRepositoryProtocol {

    private var network: NetworkLoginProtocol
    
    init(network: NetworkLoginProtocol) {
        self.network = network
    }
    
    func loginApp(user: String, password: String) async throws -> String {
        return try await network.loginApp(user: user, password: password)
    }
}

final class LoginRepositoryFake: LoginRepositoryProtocol {

    private var network: NetworkLoginProtocol
    
    init(network: NetworkLoginProtocol = NetworkLoginFake()) {
        self.network = network
    }
    
    func loginApp(user: String, password: String) async throws -> String {
        return try await network.loginApp(user: user, password: password)
    }
}
