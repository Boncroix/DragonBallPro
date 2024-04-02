//
//  LocationsRepository.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 29/3/24.
//

import Foundation

final class LocationsRepository: LocationsRepositoryProtocol {
    
    private var network: NetworkModelProtocol
    
    init(network: NetworkModelProtocol = NetworkModel()) {
        self.network = network
    }
    
    func getLocations(params: [String: Any], token: String) async throws -> [Location] {
        try await network.getModel(endPoint: HTTPEndPoints.locations, params: params, token: token)
    }
}
