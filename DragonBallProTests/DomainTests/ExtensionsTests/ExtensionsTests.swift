//
//  ExtensionsTests.swift
//  DragonBallProTests
//
//  Created by Jose Bueno Cruz on 24/3/24.
//

import XCTest
@testable import DragonBallPro

final class ExtensionsTests: XCTestCase {
    func testGetStatusCode() {
        // Given
        let urlResponse = HTTPURLResponse(url: URL(string: "https://myurl.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        // When
        let statusCode = urlResponse.getStatusCode()
        
        // Then
        XCTAssertEqual(statusCode, 200)
    }
    
    func testGetStatusCode0() {
        // Given
        let urlResponse = URLResponse(url: URL(string: "https://myurl.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        
        // When
        let statusCode = urlResponse.getStatusCode()
        
        // Then
        XCTAssertEqual(statusCode, 0)
    }


}
