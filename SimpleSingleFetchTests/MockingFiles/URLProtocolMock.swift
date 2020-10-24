//
//  URLProtocolMock.swift
//  SimpleSingleFetchTests
//
//  Created by Stuart on 22/10/2020.
//

// Based on code from https://www.hackingwithswift.com/articles/153/how-to-test-ios-networking-code-the-easy-way
// And https://medium.com/better-programming/swift-unit-test-a-datataskpublisher-with-urlprotocol-2fbda186758e

import Foundation
@testable import SimpleSingleFetch

class URLProtocolMock: URLProtocol {
    
    // Dictionary that maps URL's to test data
    static var testURLs = [URL?: Data]()
    static var response: URLResponse?
    static var error: Error?
    static var responseDelay: Double?
    
    // We want to handle all types of request
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canInit(with task: URLSessionTask) -> Bool {
        true
    }
    
    // return the request that we are given
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        // if we have a valid URL and if we have test data for that URL
        if let url = request.url, let data = URLProtocolMock.testURLs[url] {
                
            // Load it
            self.client?.urlProtocol(self, didLoad: data)
        }
        
        // return our response if we defined one
        if let response = URLProtocolMock.response {
            self.client?.urlProtocol(self,
                                     didReceive: response,
                                     cacheStoragePolicy: .notAllowed)
        }

        // return the error if we defined one
        if let error = URLProtocolMock.error {
            self.client?.urlProtocol(self,
                                     didFailWithError: error)
        }
        
        // mark that we have finished
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    // this method is required but does not need to do anything
    override func stopLoading() { }
}
