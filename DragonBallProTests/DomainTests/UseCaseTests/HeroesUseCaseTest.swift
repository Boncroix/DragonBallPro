//
//  HeroesUseCaseTest.swift
//  DragonBallProTests
//
//  Created by Jose Bueno Cruz on 24/3/24.
//

import XCTest
import KeyChainJB
@testable import DragonBallPro

final class HeroesUseCaseTest: XCTestCase {
    
    private var sut: HeroesUseCase!
    private var heroes: [Hero] = []

    override func setUpWithError() throws {
        sut = HeroesUseCase(repo: HeroesRepositoryFake(), secureData: SecureDataUserDefaults())
    }

    override func tearDownWithError() throws {
        sut = nil
        heroes = []
    }
    
    func testGetHeroes() async throws {
        //When
        let expectation = XCTestExpectation(description: "Get Heros")
        heroes = try await sut.getHeroes(params: ["": ""])
        XCTAssertNotNil(heroes)
        
        //Then
        _ = await XCTWaiter().fulfillment(of: [expectation], timeout: 3)
        XCTAssertEqual(heroes.count, 2)
        XCTAssertEqual(heroes.first?.name, "Vegeta")
    }

}
