//
//  UseCaseTest.swift
//  DragonBallProTests
//
//  Created by Jose Bueno Cruz on 23/3/24.
//

import XCTest
import KeyChainJB
@testable import DragonBallPro

final class UseCaseTest: XCTestCase {
    
    func testLoginFake() async throws {
        let kc = SecureDataUserDefaults()
        XCTAssertNotNil(kc)
        
        let obj = LoginUseCaseFake()
        XCTAssertNotNil(obj)
        
        let resp = await obj.validateToken()
        XCTAssertEqual(resp, true)
        
        let login = try await obj.loginApp(user: "", password: "")
        XCTAssertEqual(login, true)
        
        var token = kc.getToken(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        XCTAssertNotEqual(token, "")
        
        await obj.logout()
        token = kc.getToken(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        XCTAssertEqual(token, "")
    }
    
    func testLogin() async throws {
        let kc = SecureDataUserDefaults()
        XCTAssertNotNil(kc)
        
        kc.set(token: "", key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        
        let useCase = LoginUseCase(repo: LoginRepositoryFake(), secureData: kc)
        XCTAssertNotNil(useCase)
        
        let resp = await useCase.validateToken()
        XCTAssertEqual(resp, false)
        
        let login = try await useCase.loginApp(user: "", password: "")
        XCTAssertEqual(login, true)
        
        var token = kc.getToken(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        XCTAssertNotEqual(token, "")
        
        await useCase.logout()
        token = kc.getToken(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        XCTAssertEqual(token, "")
    }
    
}
