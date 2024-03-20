//
//  LoginUseCase.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 16/3/24.
//

import Foundation
import KeychainSwift

//MARK: - Protocol
protocol LoginUseCaseProtocol {
    func loginApp(user: String, password: String) async throws -> Bool
    func logout() async -> Void
    func validateToken() async -> Bool
}

final class LoginUseCase: LoginUseCaseProtocol {

    private let repo: LoginRepositoryProtocol
    private let secureData: SecureDataProtocol
    
    //MARK: - Inits
    init(repo: LoginRepositoryProtocol = LoginRepository(network: NetworkLogin()),
         secureData: SecureDataProtocol = SecureDataKeychain()) {
        self.repo = repo
        self.secureData = secureData
    }
    
    //MARK: - LoginApp
    func loginApp(user: String, password: String) async throws -> Bool {
        let token = try await repo.loginApp(user: user, password: password)
        if token != "" {
            secureData.set(token: token)
            return true
        } else {
            secureData.deleteToken()
            return false
        }
    }
    
    //MARK: - Logout
    func logout() async {
        secureData.deleteToken()
    }
    
    //MARK: - ValidateToken
    func validateToken() async -> Bool {
        if secureData.getToken() != "" {
            return true
        } else {
            return false
        }
    }
}
