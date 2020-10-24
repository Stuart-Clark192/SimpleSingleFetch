//
//  UserWorker.swift
//  SimpleSingleFetch
//
//  Created by Stuart on 21/10/2020.
//

import Foundation
import Combine

enum APIError: Error, LocalizedError {
    case unknown, apiError(reason: String)
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason):
            return reason
        }
    }
}

enum HTTPMethod: String {
    case get = "get"
    case post = "post"
    case put = "put"
}

protocol UserFetcher {
    func fetchUsers(url: URL, httpMethod: HTTPMethod, using session: URLSession) -> AnyPublisher<[User], APIError>
}

// Define an extension so that we can provide a default value if we want
extension UserFetcher {
    func fetchUsers(url: URL, httpMethod: HTTPMethod, using session: URLSession = URLSession.shared) -> AnyPublisher<[User], APIError> {
        fetchUsers(url: url, httpMethod: httpMethod, using: session)
    }
}

struct UserWorker: UserFetcher {
    
    // A basic non generic data fetch
    
    private let sessionProcessingQueue = DispatchQueue(label: "SessionProcessingQueue")
    
    func fetchUsers(url: URL, httpMethod: HTTPMethod, using session: URLSession) -> AnyPublisher<[User], APIError> {
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        return session.dataTaskPublisher(for: request)
            .receive(on: sessionProcessingQueue)
            .tryMap { data, response in
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.unknown
                }
                
                guard 200..<300 ~= httpResponse.statusCode else {
                    throw APIError.unknown // Would really want to throw an appropriate error code here
                }
                
                let model = try JSONDecoder().decode([User].self, from: data)
                
                return model
            }
            .mapError { error in
                if let error = error as? APIError {
                    return error
                } else {
                    return APIError.apiError(reason: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
}
