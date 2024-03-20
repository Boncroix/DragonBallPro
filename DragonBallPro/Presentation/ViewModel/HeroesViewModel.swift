//
//  HeroesViewModel.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 19/3/24.
//

import Foundation
import Combine

final class HeroesViewModel: ObservableObject {
    
    @Published var heroes = [Hero]()
    private var heroesUseCase: HeroesUseCaseProtocol
    
    //MARK: - Initializer
    init(heroesUseCase: HeroesUseCaseProtocol = HeroesUseCase()) {
        self.heroesUseCase = heroesUseCase
        getHeroes()
    }
    
    //MARK: - Obtener Heroes
    func getHeroes() {
        Task {
            do {
                var heroesData = try await heroesUseCase.getHeroes(params: ["name": ""])
                heroesData.removeAll { $0.name == "Quake (Daisy Johnson)"}
                heroes = heroesData
                sortHeroesByName(ascending: true)
            } catch {
                let errorMessage = errorMessage(for: error)
                print(errorMessage)
            }
        }
    }
    
    //MARK: - Ordenar Heroes
    func sortHeroesByName(ascending: Bool) {
        if ascending {
            heroes.sort {$0.name ?? "" < $1.name ?? ""}
        } else {
            heroes.sort {$0.name ?? "" > $1.name ?? ""}
        }
    }
}
