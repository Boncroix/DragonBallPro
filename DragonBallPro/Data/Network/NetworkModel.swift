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




//MARK: - NetworkHerosFake
final class NetworkHerosFake: NetworkModelProtocol {
    
    func getModel<T: Decodable>(endPoint: HTTPEndPoints, params: [String: Any], token: String) async throws -> [T] {
        
        let model1 = Hero(id: UUID(), name: "Vegeta", description: "Vegeta es todo lo contrario. Es arrogante, cruel y despreciable. Quiere conseguir las bolas de Dragón y se enfrenta a todos los protagonistas, matando a Yamcha, Ten Shin Han, Piccolo y Chaos. Es despreciable porque no duda en matar a Nappa, quien entonces era su compañero, como castigo por su fracaso. Tras el intenso entrenamiento de Goku, el guerrero se enfrenta a Vegeta y estuvo a punto de morir. Lejos de sobreponerse, Vegeta huye del planeta Tierra sin saber que pronto tendrá que unirse a los que considera sus enemigos.", photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/vegetita.jpg?width=300", favorite: true)
        
        let model2 = Hero(id: UUID(), name: "Goku", description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.", photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300", favorite: true)
        
        if T.self == Hero.self {
            return [model1 as! T, model2 as! T]
        }
        return []
    }
}




//MARK: - NetworkTransformationsFake
final class NetworkTransformationsFake: NetworkModelProtocol {
    
    func getModel<T: Decodable>(endPoint: HTTPEndPoints, params: [String: Any], token: String) async throws -> [T] {
        
        let model1 = Transformation(id: UUID(), name: "4. Super Saiyan", description: "Cuando Goku ve como Freezer mata a sangre fría a su mejor amigo Krilin entra en un estado de ira que no puede contener, su cabello se va tornando rubio y de punta mientras advierte a su hijo Son Gohan que huya del planeta Namek puesto que no sabe si va a poder controlar este nuevo poder. Freezer temía de la leyenda del Super Saiyan y por eso su plan de exterminar a toda la especie y al Planeta Vegeta, con lo que no contaba es con que Goku sería el primer Super Saiyan que verían sus ojos.", photo: "https://areajugones.sport.es/wp-content/uploads/2021/05/wp4113614.jpg.webp", hero: nil)
        
        let model2 = Transformation(id: UUID(), name: "1. Oozaru – Gran Mono", description: "Cómo todos los Saiyans con cola, Goku es capaz de convertirse en un mono gigante si mira fijamente a la luna llena. Así es como Goku cuando era un infante liberaba todo su potencial a cambio de perder todo el raciocinio y transformarse en una auténtica bestia. Es por ello que sus amigos optan por cortarle la cola para que no ocurran desgracias, ya que Goku mató a su propio abuelo adoptivo Son Gohan estando en este estado. Después de beber el Agua Ultra Divina, Goku liberó todo su potencial sin necesidad de volver a convertirse en Oozaru", photo: "https://areajugones.sport.es/wp-content/uploads/2021/05/ozarru.jpg.webp", hero: nil)
        
        
        if T.self == Transformation.self {
            return [model1 as! T, model2 as! T]
        }
        return []
    }
}
