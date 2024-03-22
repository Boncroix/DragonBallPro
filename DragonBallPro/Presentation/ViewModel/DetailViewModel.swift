//
//  DetailViewModel.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 20/3/24.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    
    @Published var locations = [Location]()
    @Published var transformations = [Transformation]()
    @Published var numberOfTransformations: Int = 0
    
    private var detailUseCase: DetailUseCaseProtocol
    var hero: Hero
    
    //MARK: Inits
    init(hero: Hero,
         detailUseCase: DetailUseCaseProtocol = DetailUseCase()) {
        self.detailUseCase = detailUseCase
        self.hero = hero
        getLocations()
        getTransformations()
    }
    
    //MARK: GetLocations
    func getLocations() {
        Task {
            do {
                let locationsData = try await detailUseCase.getLocations(params: ["id": "\(hero.id)"])
                self.locations = locationsData
            } catch {
                let errorMessage = errorMessage(for: error)
                NSLog(errorMessage)
            }
        }
    }
    
    //MARK: GetTransformations
    func getTransformations() {
        Task {
            do {
                let transformationsData = try await detailUseCase.getTransformations(params: ["id": "\(hero.id)"])
                self.transformations = transformationsData
                self.sortTransformationsByName()
            } catch {
                let errorMessage = errorMessage(for: error)
                NSLog(errorMessage)
            }
        }
    }
    
    //MARK: - SortTransformations
    func sortTransformationsByName() {
        transformations.sort {
            let numero1 = Int($0.name?.components(separatedBy: ".").first ?? "") ?? 0
            let numero2 = Int($1.name?.components(separatedBy: ".").first ?? "") ?? 0
            return numero1 < numero2
        }
    }
    
    //MARK: - CheckTransformations
    func checkTransformations() -> Bool {
        return transformations.isEmpty
    }
}
