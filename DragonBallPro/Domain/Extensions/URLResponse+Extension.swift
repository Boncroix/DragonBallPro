//
//  URLResponse+Extension.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 18/3/24.
//

import Foundation

extension URLResponse {
    func getStatusCode() -> Int {
        if let httpResponse = self as? HTTPURLResponse{
            return httpResponse.statusCode
        } else {
            return 0
        }
    }
}
