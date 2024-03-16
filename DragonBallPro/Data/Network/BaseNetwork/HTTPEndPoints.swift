//
//  EndPoints.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 15/3/24.
//

import Foundation

enum HTTPEndPoints: String {
    case login
    case heros
    case transformations
    case locations
    
    func endpoint() -> String {
        switch self {
        case .login:
            return "/api/auth/login"
        case .heros:
            return "/api/heros/all"
        case .transformations:
            return "/api/heros/tranformations"
        case .locations:
            return "/api/heros/locations"
        }
    }
}
