//
//  DetailUseCaseTest.swift
//  DragonBallProTests
//
//  Created by Jose Bueno Cruz on 24/3/24.
//

import XCTest
import KeyChainJB
@testable import DragonBallPro

final class DetailUseCaseTest: XCTestCase {
    
    private var sut: DetailUseCase!
    private var transformations: [Transformation] = []

    override func setUpWithError() throws {
        sut = DetailUseCase(repo: DetailRepositoryFake(), secureData: SecureDataUserDefaults())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testGetTransformations() async throws {
        //When
        let expectation = XCTestExpectation(description: "Get Transformations")
        transformations = try await sut.getTransformations(params: ["": ""])
        XCTAssertNotNil(transformations)
        
        //Then
        _ = await XCTWaiter().fulfillment(of: [expectation], timeout: 3)
        XCTAssertEqual(transformations.count, 2)
        XCTAssertEqual(transformations.first?.name, "4. Super Saiyan")
    }
}
