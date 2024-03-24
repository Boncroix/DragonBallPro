//
//  KeyChainTest.swift
//  DragonBallProTests
//
//  Created by Jose Bueno Cruz on 22/3/24.
//

import XCTest
import KeyChainJB

final class KeyChainTest: XCTestCase {
    
    func testKeyChainLibrary() throws {
        
        let key = "testKey"
        let token = "testToken"
        
        let kc = SecureDataKeychain()
        XCTAssertNotNil(kc)
        
        kc.set(token: token, key: key)
        XCTAssertEqual(kc.getToken(key: key), token)
        
        XCTAssertNoThrow(kc.deleteToken(key: key))
    }
    
    func testUserDefaultLibrary() throws {
        
        let key = "testKey"
        let token = "testToken"
        
        let kc = SecureDataUserDefaults()
        XCTAssertNotNil(kc)
        
        kc.set(token: token, key: key)
        XCTAssertEqual(kc.getToken(key: key), token)
        
        XCTAssertNoThrow(kc.deleteToken(key: key))
    }
}
