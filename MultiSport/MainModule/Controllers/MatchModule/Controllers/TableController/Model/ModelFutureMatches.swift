// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct FutureFootballMatches: Codable {
    let welcomeGet: String?
    let errors: [JSONAny]?
    let results: Int?
    let response: [Response]?

    enum CodingKeys: String, CodingKey {
        case welcomeGet = "get"
        case errors, results, response
    }
}

// MARK: - Response
struct Response: Codable {
    let fixture: Fixture
    let league: League
    let teams, goals: Goals
}

// MARK: - Fixture
struct Fixture: Codable {
    let id: Int
    let timezone: String
    let date: String
    let timestamp: Int
}

// MARK: - Goals
struct Goals: Codable {
    let home, away: Away?
}

// MARK: - Away
struct Away: Codable {
    let id: Int
    let name: String
    let logo: String
    let winner: JSONNull?
}

// MARK: - League
struct League: Codable {
    let id: Int
    let name, country: String
    let logo: String
}

