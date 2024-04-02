//
//  LocationsRepositoryProtocol.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 29/3/24.
//

import Foundation

protocol LocationsRepositoryProtocol {
    func getLocations(params: [String: Any], token: String) async throws -> [Location]
}
