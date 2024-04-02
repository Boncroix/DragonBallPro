//
//  LocationsViewModel.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 29/3/24.
//

import Foundation
import Combine

final class LocationsViewModel: ObservableObject {
    
    @Published var locations = [Location]()
    private var locationUseCase: LocationsUseCaseProtocol
    var hero: Hero
    
    //MARK: - Inits
    init(hero: Hero, locationUseCase: LocationsUseCaseProtocol = LocationsUseCase()) {
        self.locationUseCase = locationUseCase
        self.hero = hero
        getLocations()
    }
    
    //MARK: - GetLocations
    func getLocations() {
        Task {
            do {
                let locationsData = try await locationUseCase.getLocations(params: ["id": "\(hero.id)"])
                DispatchQueue.main.async {
                    self.locations = locationsData
                }
            } catch {
                let errorMessage = errorMessage(for: error)
                NSLog(errorMessage)
            }
        }
    }
    
    func heroNameAndId() -> (String?, UUID?) {
        return (hero.name, hero.id)
    }
}
