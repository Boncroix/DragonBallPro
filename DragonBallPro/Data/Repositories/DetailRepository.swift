//
//  DetailRepository.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 20/3/24.
//

import Foundation

final class DetailRepository: DetailRepositoryProtocol {

    private var network: NetworkModelProtocol
    
    init(network: NetworkModelProtocol = NetworkModel()) {
        self.network = network
    }
    
    func getTransformations(params: [String: Any], token: String) async throws -> [Transformation] {
        try await network.getModel(endPoint: HTTPEndPoints.transformations, params: params, token: token)
    }
    
}




//MARK: - DetailRepositoryFake
final class DetailRepositoryFake: DetailRepositoryProtocol {

    private var network: NetworkModelProtocol
    
    init(network: NetworkModelProtocol = NetworkTransformationsFake()) {
        self.network = network
    }
    
    func getTransformations(params: [String: Any], token: String) async throws -> [Transformation] {
        try await network.getModel(endPoint: HTTPEndPoints.transformations, params: params, token: token)
    }
    
}
