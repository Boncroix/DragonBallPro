//
//  DetailTransformationViewModelTests.swift
//  DragonBallProTests
//
//  Created by Jose Bueno Cruz on 24/3/24.
//

import XCTest
import Combine
@testable import DragonBallPro

final class DetailTransformationViewModelTests: XCTestCase {
    
    private var sut: DetailTransformationViewModel!
    private var transformation: Transformation!

    override func tearDownWithError() throws {
        sut = nil
        transformation = nil
    }
    
    func testDetailTransformationViewModel() {
        transformation = Transformation(id: UUID(), name: "", description: "", photo: "", hero: nil)
        XCTAssertNotNil(transformation)
        sut = DetailTransformationViewModel(transformation: transformation)
        XCTAssertNotNil(sut)
    }
    

}
