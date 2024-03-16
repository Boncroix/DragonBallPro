//
//  NetworkLogin.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 15/3/24.
//

import Foundation


protocol NetworkLoginProtocol {
    func loginApp(user: String, password: String) async throws -> String
}


final class NetworkLogin: NetworkLoginProtocol {
    
    func loginApp(user: String, password: String) async throws -> String {
        var token: String = ""
        do {
            let request = try await NetworkRequest().requestForLogin(user: user, password: password)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let resp = response as? HTTPURLResponse{
                if resp.statusCode == HTTPResponseCodes.SUCESS {
                    token = String(decoding: data, as: UTF8.self)
                }
            }
        } catch {
            throw NetworkError.tokenFormatError
        }
        return token
    }
}
