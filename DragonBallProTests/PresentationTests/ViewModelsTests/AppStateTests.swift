//
//  LoginViewModelTests.swift
//  DragonBallProTests
//
//  Created by Jose Bueno Cruz on 24/3/24.
//

import XCTest
@testable import DragonBallPro

final class AppStateTests: XCTestCase {
    
    private var sut: AppState!

    override func setUpWithError() throws {
        sut = AppState(loginUseCase: LoginUseCaseFake())
        XCTAssertNotNil(sut)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testValidateDataEmail() {
        //Given
        let email = "pepeillogmail.com"
        let password = "1234"
        
        //When
        XCTAssertNoThrow(sut.onLoginButton(email: email, password: password))
        
        //Then
        XCTAssertEqual(sut.statusLogin, .showErrorEmail(NSLocalizedString("errorEmail", comment: "ErrorEmail")))
    }
    
    func testValidateDataPassword() {
        //Given
        let email = "pepe@gmail.com"
        let password = "123"
        
        //When
        XCTAssertNoThrow(sut.onLoginButton(email: email, password: password))
        
        //Then
        XCTAssertEqual(sut.statusLogin, .showErrorPassword(NSLocalizedString("errorPassword", comment: "ErrorPassword")))
    }
    
    func testLoginApp() async {
        //Given
        let email = "pepe@gmail.com"
        let password = "1234"
        
        //When
        let expectation = XCTestExpectation(description: "Login completion")
        XCTAssertNoThrow(sut.loginApp(user: email, password: password))
        
        //Then
        _ = await XCTWaiter().fulfillment(of: [expectation], timeout: 1)
        XCTAssertEqual(sut.statusLogin, .success)
    }
    
    func testValidateControlLogin() async {
        //When
        let expectation = XCTestExpectation(description: "Validate token")
        XCTAssertNoThrow(sut.validateControlLogin())
        
        //Then
        _ = await XCTWaiter().fulfillment(of: [expectation], timeout: 1)
        XCTAssertEqual(sut.statusLogin, .success)
    }
    
    func testCloseSessionUser() async {
        //When
        let expectation = XCTestExpectation(description: "Session Closed")
        XCTAssertNoThrow(sut.closeSessionUser())
        
        //Then
        _ = await XCTWaiter().fulfillment(of: [expectation], timeout: 1)
        XCTAssertEqual(sut.statusLogin, .none)
    }
    
}
