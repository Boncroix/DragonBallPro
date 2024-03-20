//
//  HTTPAuthentication.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 15/3/24.
//

import Foundation

struct HTTPAuthentication {
    static func basicCredentials(_ credentials: String) -> String {
            return "Basic \(credentials)"
        }
    static func bearerToken(_ token: String) -> String {
            return "Bearer \(token)"
        }
}
