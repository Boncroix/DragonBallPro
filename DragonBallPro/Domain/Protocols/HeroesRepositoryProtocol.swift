//
//  HeroesRepositoryProtocol.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 19/3/24.
//

import Foundation

protocol HeroesRepositoryProtocol {
    func getModel(params: [String: Any], token: String) async throws -> [Hero]
}
