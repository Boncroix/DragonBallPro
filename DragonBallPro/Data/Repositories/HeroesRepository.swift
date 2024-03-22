//
//  HeroesRepository.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 19/3/24.
//

import Foundation

final class HeroesRepository: HeroesRepositoryProtocol {
    
    private var network: NetworkModelProtocol
    
    init(network: NetworkModelProtocol = NetworkModel()) {
        self.network = network
    }
    
    func getHeroes(params: [String: Any], token: String) async throws -> [Hero] {
        try await network.getModel(endPoint: HTTPEndPoints.heros, params: params, token: token)
    }
}
