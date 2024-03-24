//
//  NetworkModelTests.swift
//  DragonBallProTests
//
//  Created by Jose Bueno Cruz on 24/3/24.
//

import XCTest
@testable import DragonBallPro

final class NetworkModelTests: XCTestCase {
    
    private var heroes: [Hero] = []
    private var transformations: [Transformation] = []
    
    func testNetworkModel() async throws {
        //Given
        let obj1 = NetworkModel()
        XCTAssertNotNil(obj1)
        let obj2 = NetworkHerosFake()
        XCTAssertNotNil(obj2)
        let obj3 = NetworkTransformationsFake()
        XCTAssertNotNil(obj3)
        
        heroes = try await obj2.getModel(endPoint: HTTPEndPoints.heros, params: ["" : ""], token: "")
        XCTAssertNotNil(heroes)
        
        transformations = try await obj3.getModel(endPoint: HTTPEndPoints.transformations, params: ["" : ""], token: "")
        XCTAssertNotNil(transformations)
        
        do {
            heroes = try await obj1.getModel(endPoint: HTTPEndPoints.heros, params: ["name" : ""], token: "")
        } catch {
            let errorMessage = errorMessage(for: error)
            XCTAssertEqual(errorMessage, "ERROR CODE 401")
        }
    }
}
