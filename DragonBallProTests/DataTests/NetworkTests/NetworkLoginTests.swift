//
//  NetworkTests.swift
//  DragonBallProTests
//
//  Created by Jose Bueno Cruz on 16/3/24.
//

import XCTest
@testable import DragonBallPro

final class NetworkLoginTests: XCTestCase {
    
    func testNetworkLogin() async throws {
        
        let obj1 = NetworkLogin()
        XCTAssertNotNil(obj1)
        let obj2 = NetworkLoginFake()
        XCTAssertNotNil(obj2)
        
        let tokenFake = try await obj2.loginApp(user: "", password: "")
        XCTAssertNotEqual(tokenFake, "")
        
        do {
            _ = try await obj1.loginApp(user: "jose", password: "12345")
        } catch {
            let errorMessage = errorMessage(for: error)
            XCTAssertEqual(errorMessage, "ERROR CODE 401")
        }
    }
}
