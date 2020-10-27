//
//  URLTestSession.swift
//  SimpleSingleFetch
//
//  Created by Stuart on 26/10/2020.
//

import Foundation

struct URLTestSession {
    static func testSession() -> URLSession {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return URLSession.shared }
        let testData = UserTestData.usersDataJSON.data(using: .utf8)!
        
        URLProtocolMock.testURLs = [url: testData]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: config)
    }
}
