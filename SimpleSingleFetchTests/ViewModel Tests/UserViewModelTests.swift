//
//  UserViewModelTests.swift
//  SimpleSingleFetchTests
//
//  Created by Stuart on 23/10/2020.
//

import XCTest
import Combine
import Foundation
@testable import SimpleSingleFetch

class UserViewModelTests: XCTestCase {
    
    private var sut = UserViewModel()
    private var session: URLSession!
    private var cancellationToken: AnyCancellable?
    private var stateChanges = [ViewState]()
    
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
    
    func testLoadUsersSetsUsersAndViewStateToData() throws {
        URLProtocolMock.response = MockResponses.validResponse
        let expectation = self.expectation(description: #function)
        
        let testSub2: AnyPublisher<ViewModelPublished, Never> = sut.$viewData.eraseToAnyPublisher()
        stateChanges.removeAll()
        
        cancellationToken = testSub2
            .sink { [weak self] viewModelData in
                self?.stateChanges.append(viewModelData.viewState)
                if !viewModelData.users.isEmpty {
                    expectation.fulfill()
                }
            }
        
        sut.loadUsers(using: session)
        
        waitForExpectations(timeout: 15, handler: nil)
        
        XCTAssertEqual(sut.viewData.users.count, 1, "ViewModel users should equal 1 in - \(#function)")
        XCTAssertEqual(sut.viewData.viewState, ViewState.data, "ViewModel viewState should = .data in - \(#function)")
        XCTAssertEqual(stateChanges.count, 4, "We should have 4 state changes \(#function)")
        XCTAssertEqual(stateChanges, [.noData, .loading, .data, .data], "State changes does not match expected in - \(#function)")
    }
    
    func testLoadUsersSetsViewStateToErrorOnURLFail() throws {
        URLProtocolMock.response = MockResponses.urlNotFoundResponse
        let expectation = self.expectation(description: #function)
        
        let testSub2: AnyPublisher<ViewModelPublished, Never> = sut.$viewData.eraseToAnyPublisher()
        stateChanges.removeAll()
        
        cancellationToken = testSub2
            .sink { [weak self] viewModelData in
                self?.stateChanges.append(viewModelData.viewState)
                
                if self?.stateChanges.count == 3 {
                    expectation.fulfill()
                }
            }
        
        sut.loadUsers(using: session)
        
        waitForExpectations(timeout: 15, handler: nil)
        
        XCTAssertEqual(sut.viewData.users.count, 0, "ViewModel users should equal 0 in - \(#function)")
        XCTAssertEqual(sut.viewData.viewState, ViewState.error, "ViewModel viewState should = .error in - \(#function)")
        XCTAssertEqual(stateChanges.count, 3, "We should have 3 state changes in - \(#function)")
        XCTAssertEqual(stateChanges, [.noData, .loading, .error], "State changes does not match expected in - \(#function)")
    }
}
