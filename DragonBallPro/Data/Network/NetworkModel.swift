//
//  NetworkHeroes.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 19/3/24.
//

import Foundation

//MARK: - Protocol
protocol NetworkModelProtocol {
    func getModel<T: Decodable>(endPoint: HTTPEndPoints, params: [String: Any], token: String) async throws -> [T]
}

final class NetworkModel: NetworkModelProtocol {
    
    //MARK: - GetModel
    func getModel<T: Decodable>(endPoint: HTTPEndPoints, params: [String: Any], token: String) async throws -> [T] {

        let request = try await NetworkRequest().requestForModel(endPoint: endPoint, token: token, params: params)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = (response as? HTTPURLResponse),
              httpResponse.getStatusCode() == HTTPResponseCodes.SUCESS else {
            throw NetworkError.statusCodeError(response.getStatusCode())
        }
        guard let modelResponse = try? JSONDecoder().decode([T].self, from: data) else {
            throw NetworkError.dataDecodingFailed
        }
        return modelResponse
    }
}
