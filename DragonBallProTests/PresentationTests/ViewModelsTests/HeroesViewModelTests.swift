//
//  HeroesViewModelTests.swift
//  DragonBallProTests
//
//  Created by Jose Bueno Cruz on 24/3/24.
//

import XCTest
import Combine
@testable import DragonBallPro

final class HeroesViewModelTests: XCTestCase {
    
    private var sut: HeroesViewModel!
    
    override func setUpWithError() throws {
        sut = HeroesViewModel(heroesUseCase: HeroesUseCaseFake())
        XCTAssertNotNil(sut)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGetHeroes() async {
        //When
        let expectation = XCTestExpectation(description: "Get Heros")
        XCTAssertNoThrow(sut.getHeroes())
        
        //Then
        _ = await XCTWaiter().fulfillment(of: [expectation], timeout: 3)
        XCTAssertEqual(sut.heroes.count, 2)
        XCTAssertEqual(sut.heroes.first?.name, "Goku")
    }
    
    func testFilterHeroesBy() async {
        //When
        let expectation = XCTestExpectation(description: "Filter Heros")
        XCTAssertNoThrow(sut.getHeroes())
        XCTAssertNoThrow(sut.filterHeroesBy(name: "Ve"))
        
        //Then
        _ = await XCTWaiter().fulfillment(of: [expectation], timeout: 3)
        XCTAssertEqual(sut.heroes.count, 1)
        XCTAssertEqual(sut.heroes.first?.name, "Vegeta")
        
    }
}
