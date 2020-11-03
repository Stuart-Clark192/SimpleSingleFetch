//
//  SimpleSingleFetchUITests.swift
//  SimpleSingleFetchUITests
//
//  Created by Stuart on 25/10/2020.
//

import XCTest

class SimpleSingleFetchUITests: XCTestCase {
    
    private var session: URLSession!

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        let app = XCUIApplication()
        app.launchArguments = ["UITestMode"]
        app.launch()

        let expectedNameValue = XCUIApplication().tables.staticTexts["Name: Leanne Graham"]
        _ = expectedNameValue.waitForExistence(timeout: 5)
        XCTAssertTrue(expectedNameValue.exists)
    }
}
