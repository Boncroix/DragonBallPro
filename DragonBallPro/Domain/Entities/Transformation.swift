//
//  Transformation.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 20/3/24.
//

import Foundation

// MARK: - Transformation
struct Transformation: Decodable, Equatable {
    static func == (lhs: Transformation, rhs: Transformation) -> Bool {
        return lhs.name == rhs.name
    }
    
    let id: UUID?
    let name: String?
    let description: String?
    let photo: String?
    let hero: Hero?
}
