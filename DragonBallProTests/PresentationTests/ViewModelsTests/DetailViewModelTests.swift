//
//  DetailViewModelTests.swift
//  DragonBallProTests
//
//  Created by Jose Bueno Cruz on 24/3/24.
//

import XCTest
import Combine
@testable import DragonBallPro

final class DetailViewModelTests: XCTestCase {
    
    private var sut: DetailViewModel!
    private var hero: Hero!

    override func setUpWithError() throws {
        hero = Hero(id: UUID(), name: "Goku", description: "El jefe", photo: "", favorite: false)
        XCTAssertNotNil(hero)
        sut = DetailViewModel(hero: hero, detailUseCase: DetailUseCaseFake())
        XCTAssertNotNil(sut)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGetTransformations() async {
        //When
        let expectation = XCTestExpectation(description: "Get Transformations")
        XCTAssertNoThrow(sut.getTransformations())
        
        //Then
        _ = await XCTWaiter().fulfillment(of: [expectation], timeout: 3)
        XCTAssertEqual(sut.transformations.count, 2)
        XCTAssertEqual(sut.transformations.first?.name, "1. Oozaru – Gran Mono")
    }
    
    func testchekTransformations() async {
        //When
        let expectation = XCTestExpectation(description: "Chek Transformations")
        XCTAssertNoThrow(sut.getTransformations())
        let isEmpty = sut.checkTransformations()
        
        //Then
        _ = await XCTWaiter().fulfillment(of: [expectation], timeout: 3)
        XCTAssertEqual(isEmpty , false)
    }

}
