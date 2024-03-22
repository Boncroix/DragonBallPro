//
//  LocationsRepositoryProtocol.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 20/3/24.
//

import Foundation

protocol DetailRepositoryProtocol {
    func getLocations(params: [String: Any], token: String) async throws -> [Location]
    func getTransformations(params: [String: Any], token: String) async throws -> [Transformation]
}
