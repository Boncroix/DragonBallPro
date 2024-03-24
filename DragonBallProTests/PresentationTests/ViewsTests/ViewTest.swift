//
//  ViewTest.swift
//  DragonBallProTests
//
//  Created by Jose Bueno Cruz on 23/3/24.
//

import XCTest
@testable import DragonBallPro

final class ViewTest: XCTestCase {
    
    func testLoginView() async throws {
        let appStateVM = AppState(loginUseCase: LoginUseCaseFake())
        XCTAssertNotNil(appStateVM)
        
        appStateVM.statusLogin = .notValidate
        
        let vc = await LoginViewController(appState: appStateVM)
        XCTAssertNotNil(vc)
    }
    
    func testHeroesView() async throws {
        
        let appStateVM = AppState(loginUseCase: LoginUseCaseFake())
        XCTAssertNotNil(appStateVM)
        
        appStateVM.statusLogin = .success
        
        let vc = await HerosViewController(appState: appStateVM)
        XCTAssertNotNil(vc)
    }
    
    func testDetailView() async throws {
        
        let hero = Hero(id: UUID(), name: "Goku", description: "Hero", photo: nil, favorite: nil)
        XCTAssertNotNil(hero)
        
        let viewModel = DetailViewModel(hero: hero)
        XCTAssertNotNil(viewModel)
        
        let vc = await DetailViewController(viewModel: viewModel)
        XCTAssertNotNil(vc)
    }
    
    func testTransformationView() async throws {
        
        let transformation = Transformation(id: UUID(), name: "Goku", description: "Transformations", photo: nil, hero: nil)
        XCTAssertNotNil(transformation)
        
        let viewModel = DetailTransformationViewModel(transformation: transformation)
        XCTAssertNotNil(viewModel)
        
        let vc = await DetailTransformationViewController(viewModel: viewModel)
        XCTAssertNotNil(vc)
    }
}
