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
    private var session = URLTestSession.testSession()
    private var url: URL!
    
    override func setUpWithError() throws {
        url = try XCTUnwrap(URL(string: "https://jsonplaceholder.typicode.com/users"))
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testFetchUsersWithValidResponseReturnsData() throws {
        URLProtocolMock.response = MockResponses.validResponse
        let publisher = sut.fetchUsers(url: url, httpMethod: .get, using: session)
        
        let validTest = evalValidResponse(publisher: publisher, description: #function)
        wait(for: validTest.expectations, timeout: 10)
        validTest.cancellable?.cancel()
    }
}
