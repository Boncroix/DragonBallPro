//
//  HeroesUseCase.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 19/3/24.
//

import Foundation
import KeyChainJB

//MARK: - Protocol
protocol HeroesUseCaseProtocol {
    var repo: HeroesRepositoryProtocol {get set}
    func getHeroes(params: [String: Any]) async throws -> [Hero]
}

final class HeroesUseCase: HeroesUseCaseProtocol {
    
    var repo: HeroesRepositoryProtocol
    var secureData: SecureDataProtocol
    
    //MARK: - Inits
    init(repo: HeroesRepositoryProtocol = HeroesRepository(network: NetworkModel()),
         secureData: SecureDataProtocol = SecureDataKeychain()) {
        self.repo = repo
        self.secureData = secureData
        
    }
    
    //MARK: - GetHeroes
    func getHeroes(params: [String: Any]) async throws -> [Hero] {
        guard let token = secureData.getToken(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN) else {
            throw NetworkError.tokenFormatError
        }
        return try await repo.getHeroes(params: params, token: token)
    }
}




//MARK: HeroesUseCaseFake
final class HeroesUseCaseFake: HeroesUseCaseProtocol {
    
    var repo: HeroesRepositoryProtocol
    var secureData: SecureDataProtocol
    
    //MARK: - Inits
    init(repo: HeroesRepositoryProtocol = HeroesRepository(network: NetworkHerosFake()),
         secureData: SecureDataProtocol = SecureDataUserDefaults()) {
        self.repo = repo
        self.secureData = secureData
        
    }
    
    //MARK: - GetHeroes
    func getHeroes(params: [String: Any]) async throws -> [Hero] {
        guard let token = secureData.getToken(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN) else {
            throw NetworkError.tokenFormatError
        }
        return try await repo.getHeroes(params: params, token: token)
    }
}
