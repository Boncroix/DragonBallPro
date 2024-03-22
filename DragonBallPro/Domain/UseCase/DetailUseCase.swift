//
//  DetailUseCase.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 20/3/24.
//

import Foundation

//MARK: - Protocol
protocol DetailUseCaseProtocol {
    var repo: DetailRepositoryProtocol {get set}
    func getLocations(params: [String: Any]) async throws -> [Location]
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
    
    //MARK: - GetLocations
    func getLocations(params: [String: Any]) async throws -> [Location] {
        guard let token = secureData.getToken() else {
            throw NetworkError.tokenFormatError
        }
        return try await repo.getLocations(params: params, token: token)
    }
    
    //MARK: - GetTransformations
    func getTransformations(params: [String: Any]) async throws -> [Transformation] {
        guard let token = secureData.getToken() else {
            throw NetworkError.tokenFormatError
        }
        return try await repo.getTransformations(params: params, token: token)
    }
}
