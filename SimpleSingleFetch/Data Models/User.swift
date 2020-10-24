//
//  User.swift
//  SimpleSingleFetch
//
//  Created by Stuart on 21/10/2020.
//

import Foundation

struct User: Codable, Identifiable {
    
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

// MARK: - Address
struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo: Codable {
    let lat: String
    let lng: String
}

// MARK: - Company
struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}