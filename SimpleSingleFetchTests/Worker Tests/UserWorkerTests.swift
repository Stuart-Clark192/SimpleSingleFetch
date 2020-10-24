//
//  UserWorkerTests.swift
//  SimpleSingleFetchTests
//
//  Created by Stuart on 22/10/2020.
//

import XCTest
import Combine
@testable import SimpleSingleFetch

class UserWorkerTests: XCTestCase {
    
    private var sut = UserWorker()
    private var session: URLSession!
    
    override func setUpWithError() throws {
        let url = try XCTUnwrap(URL(string: "https://jsonplaceholder.typicode.com/users"))
        let testData = UserTestData.usersDataJSON.data(using: .utf8)!
        
        URLProtocolMock.testURLs = [url: testData]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        session = URLSession(configuration: config)
    
    }
    
    override func tearDownWithError() throws {
        session = nil
    }
    
    func testFetchUsersWithValidResponseReturnsData() throws {
        URLProtocolMock.response = MockResponses.validResponse
        let url = try XCTUnwrap(URL(string: "https://jsonplaceholder.typicode.com/users"))
        let publisher = sut.fetchUsers(url: url, httpMethod: .get, using: session)
    
        let validTest = evalValidResponse(publisher: publisher, description: #function)
        wait(for: validTest.expectations, timeout: 10)
        validTest.cancellable?.cancel()
    }
}
