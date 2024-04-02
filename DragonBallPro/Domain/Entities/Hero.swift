//
//  Hero.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 19/3/24.
//

import Foundation

// MARK: - Hero
struct Hero: Decodable {
    let id: UUID
    let name: String?
    let description: String?
    let photo: String?
    let favorite: Bool?
}
