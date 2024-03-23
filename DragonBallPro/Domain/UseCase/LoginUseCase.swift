//
//  LoginUseCase.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 16/3/24.
//

import Foundation
import KeyChainJB

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
            secureData.set(token: token, key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
            return true
        } else {
            secureData.deleteToken(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
            return false
        }
    }
    
    //MARK: - Logout
    func logout() async {
        secureData.deleteToken(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
    }
    
    //MARK: - ValidateToken
    func validateToken() async -> Bool {
        if secureData.getToken(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN) != "" {
            return true
        } else {
            return false
        }
    }
}


final class LoginUseCaseFake: LoginUseCaseProtocol {

    private let repo: LoginRepositoryProtocol
    private let secureData: SecureDataProtocol
    
    //MARK: - Inits
    init(repo: LoginRepositoryProtocol = LoginRepositoryFake(),
         secureData: SecureDataProtocol = SecureDataKeychain()) {
        self.repo = repo
        self.secureData = secureData
    }
    
    //MARK: - LoginApp
    func loginApp(user: String, password: String) async throws -> Bool {
        let token = try await repo.loginApp(user: user, password: password)
        if token != "" {
            secureData.set(token: token, key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
            return true
        } else {
            secureData.deleteToken(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
            return false
        }
    }
    
    //MARK: - Logout
    func logout() async {
        secureData.deleteToken(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
    }
    
    //MARK: - ValidateToken
    func validateToken() async -> Bool {
        return true
    }
}
