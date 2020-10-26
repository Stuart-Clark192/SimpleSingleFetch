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
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let expectedValue = XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Leanne Graham"]/*[[".cells[\"Leanne Graham\"].staticTexts[\"Leanne Graham\"]",".staticTexts[\"Leanne Graham\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        _ = expectedValue.waitForExistence(timeout: 5)
        XCTAssertTrue(expectedValue.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
