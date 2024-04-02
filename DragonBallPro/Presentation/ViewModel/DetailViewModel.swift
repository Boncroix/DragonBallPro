//
//  DetailViewModel.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 20/3/24.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    
    @Published var transformations = [Transformation]()
    @Published var transformationsisEmpty = Bool()
    
    private var detailUseCase: DetailUseCaseProtocol
    var hero: Hero
    
    //MARK: - Inits
    init(hero: Hero,
         detailUseCase: DetailUseCaseProtocol = DetailUseCase()) {
        self.detailUseCase = detailUseCase
        self.hero = hero
        getTransformations()
    }
    
    //MARK: - GetTransformations
    func getTransformations() {
        Task {
            do {
                let transformationsData = try await detailUseCase.getTransformations(params: ["id": "\(hero.id)"])
                DispatchQueue.main.async {
                    self.transformationsisEmpty = transformationsData.isEmpty
                    self.transformations = transformationsData
                    self.removeDuplicates()
                    self.sortTransformationsByName()
                }
            } catch {
                let errorMessage = errorMessage(for: error)
                NSLog(errorMessage)
            }
        }
    }
    
    //MARK: - SortTransformations
    private func sortTransformationsByName() {
        transformations.sort {
            let numero1 = Int($0.name?.components(separatedBy: ".").first ?? "") ?? 0
            let numero2 = Int($1.name?.components(separatedBy: ".").first ?? "") ?? 0
            return numero1 < numero2
        }
    }
    
    //MARK: - RemoveDuplicates
    private func removeDuplicates() {
        var uniqueTransformationsDict = [String: Transformation]()
        for transformation in transformations {
            if let name = transformation.name {
                uniqueTransformationsDict[name] = transformation
            }
        }
        transformations = Array(uniqueTransformationsDict.values)
    }
}
