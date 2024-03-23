//
//  KeyChainTest.swift
//  DragonBallProTests
//
//  Created by Jose Bueno Cruz on 22/3/24.
//

import XCTest
import KeychainSwift

final class KeyChainTest: XCTestCase {
    
    func testKeyChainLibrary() throws {
        let kc = KeychainSwift()
        XCTAssertNotNil(kc)
    }

}
