//
//  ToolsTests.swift
//  DragonBallProTests
//
//  Created by Jose Bueno Cruz on 24/3/24.
//

import XCTest
@testable import DragonBallPro

final class ToolsTests: XCTestCase {
    func testAPIURL() {
            // Given
            let expectedAPIURL = "https://dragonball.keepcoding.education"
            
            // When
            let apiURL = ConstantsApp.CONST_API_URL
            
            // Then
            XCTAssertEqual(apiURL, expectedAPIURL)
        }
        
        func testTokenIDKeychain() {
            // Given
            let expectedTokenIDKeychain = "JWTKeyChain"
            
            // When
            let tokenIDKeychain = ConstantsApp.CONST_TOKEN_ID_KEYCHAIN
            
            // Then
            XCTAssertEqual(tokenIDKeychain, expectedTokenIDKeychain)
        }

}
