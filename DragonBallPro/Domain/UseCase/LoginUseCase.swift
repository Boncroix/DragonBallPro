//
//  LoginUseCase.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 16/3/24.
//

import Foundation
import KeychainSwift

protocol LoginUseCaseProtocol {
    func loginApp(user: String, password: String) async throws -> Bool
    func logout() async -> Void
    func validateToken() async -> Bool
}

final class LoginUseCase: LoginUseCaseProtocol {

    
    
    private let repo: LoginRepositoryProtocol
    private let secureData: SecureDataProtocol
    
    init(repo: LoginRepositoryProtocol = LoginRepository(network: NetworkLogin()),
         secureData: SecureDataProtocol = SecureDataKeychain()) {
        self.repo = repo
        self.secureData = secureData
    }
    
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
    
    func logout() async {
        secureData.deleteToken()
    }
    
    func validateToken() async -> Bool {
        if secureData.getToken() != nil {
            return true
        } else {
            return false
        }
    }
}
