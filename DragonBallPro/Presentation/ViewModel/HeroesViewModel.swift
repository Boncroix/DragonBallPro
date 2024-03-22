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
    private var heroesComplete = [Hero]()
    private var heroesUseCase: HeroesUseCaseProtocol
    
    //MARK: - Inits
    init(heroesUseCase: HeroesUseCaseProtocol = HeroesUseCase()) {
        self.heroesUseCase = heroesUseCase
        getHeroes()
    }
    
    //MARK: - GetHeroes
    func getHeroes() {
        Task {
            do {
                var heroesData = try await heroesUseCase.getHeroes(params: ["name": ""])
                heroesData.removeAll { $0.name == "Quake (Daisy Johnson)"}
                self.heroes = heroesData
                self.heroesComplete = heroesData
                self.sortHeroesByName(ascending: true)
                
            } catch {
                let errorMessage = errorMessage(for: error)
                NSLog(errorMessage)
            }
        }
    }
    
    //MARK: - FilterForName
    func filterHeroesBy(name: String) {
        if name.count == 0 {
            heroes = heroesComplete
            sortHeroesByName(ascending: true)
        } else {
            heroes = heroes.filter { $0.name?.lowercased().contains(name.lowercased()) ?? false }
        }
    }
    
    //MARK: - SortHeroes
    func sortHeroesByName(ascending: Bool) {
        if ascending {
            heroes.sort {$0.name ?? "" < $1.name ?? ""}
        } else {
            heroes.sort {$0.name ?? "" > $1.name ?? ""}
        }
    }
    
}
