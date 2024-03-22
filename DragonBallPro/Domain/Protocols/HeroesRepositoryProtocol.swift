//
//  HeroesRepositoryProtocol.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 19/3/24.
//

import Foundation

protocol HeroesRepositoryProtocol {
    func getHeroes(params: [String: Any], token: String) async throws -> [Hero]
}
