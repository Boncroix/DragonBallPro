//
//  NetworkRequest.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 15/3/24.
//

import Foundation

struct  NetworkRequest {
    private let host = URL(string: ConstantsApp.CONST_API_URL)
    
    //MARK: - Request For Login
    func requestForLogin(user: String, password: String) async throws -> URLRequest {
        guard let url = host?.appendingPathComponent(HTTPEndPoints.login.rawValue) else {
            throw NetworkError.malformedURL
        }
        
        let encodeCredentials = "\(user):\(password)".data(using: .utf8)?.base64EncodedString()
        guard let segCredential = encodeCredentials else {
            throw NetworkError.dataEncodingFailed
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.post
        request.setValue(HTTPAuthentication.basicCredentials(segCredential),
                         forHTTPHeaderField: HTTPHeader.authorization)
        return request
    }

    //MARK: - Request For Rest
    func requestForRest(endPoint: HTTPEndPoints, token: UUID, params: [String: Any]) async throws -> URLRequest {
        guard let url = host?.appendingPathComponent(endPoint.endpoint()) else {
            throw NetworkError.malformedURL
        }
        
        guard let jsonParameters = try? JSONSerialization.data(withJSONObject: params) else {
            throw NetworkError.dataEncodingFailed
        }
            
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.post
        request.httpBody = jsonParameters
        request.setValue(HTTPAuthentication.bearerToken(token), forHTTPHeaderField: HTTPHeader.authorization)
        request.setValue(HTTPMethods.content, forHTTPHeaderField: HTTPHeader.contentType)
        return request
    }
}
