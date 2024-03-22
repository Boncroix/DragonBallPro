//
//  Transformations.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 20/3/24.
//

import Foundation

struct Transformation: Decodable{
    let id: UUID?
    let name: String?
    let description: String?
    let photo: String?
    let hero: Hero?
}
