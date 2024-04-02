//
//  LocationsUseCase.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 29/3/24.
//

import Foundation
import KeyChainJB

//MARK: - Protocol
protocol LocationsUseCaseProtocol {
    var repo: LocationsRepositoryProtocol {get set}
    func getLocations(params: [String: Any]) async throws -> [Location]
}

final class LocationsUseCase: LocationsUseCaseProtocol {
    
    var repo: LocationsRepositoryProtocol
    var secureData: SecureDataProtocol
    
    //MARK: - Inits
    init(repo: LocationsRepositoryProtocol = LocationsRepository(network: NetworkModel()), secureData: SecureDataProtocol = SecureDataKeychain()) {
        self.repo = repo
        self.secureData = secureData
    }
    
    //MARK: - GetLocations
    func getLocations(params: [String : Any]) async throws -> [Location] {
        guard let token = secureData.getToken(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN) else {
            throw NetworkError.tokenFormatError
        }
        return try await repo.getLocations(params: params, token: token)
    }
}
