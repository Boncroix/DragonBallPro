//
//  HeroTests.swift
//  DragonBallProTests
//
//  Created by Jose Bueno Cruz on 24/3/24.
//

import XCTest
@testable import DragonBallPro

final class ModelsTests: XCTestCase {
    
    func testHeroModel() {
        //Given
        let model = Hero(id: UUID(), name: "Goku", description: "el jefe", photo: "", favorite: false)
        
        //Then
        XCTAssertNotNil(model)
        XCTAssertEqual(model.name, "Goku")
        XCTAssertEqual(model.description, "el jefe")
        XCTAssertEqual(model.favorite, false)
    }
    
    func testTransformationModel() {
        //Given
        let model = Transformation(id: UUID(), name: "gran mono", description: "el monazo", photo: "", hero: nil)
        
        //Then
        XCTAssertNotNil(model)
        XCTAssertEqual(model.name, "gran mono")
        XCTAssertEqual(model.description, "el monazo")
        XCTAssertNil(model.hero)
    }
    
    func testLoginStatus() {
        // Given
        let loadingStatus1 = LoginStatus.loading(true)
        let loadingStatus2 = LoginStatus.loading(true)
        let loadingStatus3 = LoginStatus.loading(false)
        
        let emailError1 = LoginStatus.showErrorEmail("Invalid email")
        let emailError2 = LoginStatus.showErrorEmail("Invalid email")
        let emailError3 = LoginStatus.showErrorEmail("Another error")
        
        // Then
        XCTAssertEqual(loadingStatus1, loadingStatus2)
        XCTAssertNotEqual(loadingStatus1, loadingStatus3)
        XCTAssertEqual(emailError1, emailError2)
        XCTAssertNotEqual(emailError1, emailError3)
        
        XCTAssertNotEqual(LoginStatus.none, LoginStatus.success)
        XCTAssertNotEqual(LoginStatus.none, LoginStatus.loading(true))
        XCTAssertNotEqual(LoginStatus.none, LoginStatus.showErrorEmail("Invalid email"))
    }
}
