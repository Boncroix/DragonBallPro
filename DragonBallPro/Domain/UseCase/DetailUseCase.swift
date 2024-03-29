//
//  DetailUseCase.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 20/3/24.
//

import Foundation
import KeyChainJB

//MARK: - Protocol
protocol DetailUseCaseProtocol {
    var repo: DetailRepositoryProtocol {get set}
    func getTransformations(params: [String: Any]) async throws -> [Transformation]
}

final class DetailUseCase: DetailUseCaseProtocol {

    var repo: DetailRepositoryProtocol
    var secureData: SecureDataProtocol
    
    //MARK: - Inits
    init(repo: DetailRepositoryProtocol = DetailRepository(network: NetworkModel()),
         secureData: SecureDataProtocol = SecureDataKeychain()) {
        self.repo = repo
        self.secureData = secureData
    }
    
    //MARK: - GetTransformations
    func getTransformations(params: [String: Any]) async throws -> [Transformation] {
        guard let token = secureData.getToken(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN) else {
            throw NetworkError.tokenFormatError
        }
        return try await repo.getTransformations(params: params, token: token)
    }
}




//MARK: - Fake DetailUseCase
final class DetailUseCaseFake: DetailUseCaseProtocol {

    var repo: DetailRepositoryProtocol
    var secureData: SecureDataProtocol
    
    //MARK: - Inits
    init(repo: DetailRepositoryProtocol = DetailRepository(network: NetworkTransformationsFake()),
         secureData: SecureDataProtocol = SecureDataUserDefaults()) {
        self.repo = repo
        self.secureData = secureData
    }
    
    //MARK: - GetTransformations
    func getTransformations(params: [String: Any]) async throws -> [Transformation] {
        guard let token = secureData.getToken(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN) else {
            throw NetworkError.tokenFormatError
        }
        return try await repo.getTransformations(params: params, token: token)
    }
}
