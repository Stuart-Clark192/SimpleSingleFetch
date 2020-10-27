//
//  MockResponses.swift
//  SimpleSingleFetchTests
//
//  Created by Stuart on 23/10/2020.
//

import Foundation

struct MockResponses {
    
    static let validResponse = HTTPURLResponse(url: URL(string: "http://localhost:8080")!,
                                            statusCode: 200,
                                            httpVersion: nil,
                                            headerFields: nil)
    
    static let urlNotFoundResponse = HTTPURLResponse(url: URL(string: "http://localhost:8080")!,
                                            statusCode: 404,
                                            httpVersion: nil,
                                            headerFields: nil)
}
