// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pastMatchesWelcome = try? JSONDecoder().decode(PastMatchesWelcome.self, from: jsonData)

import Foundation

// MARK: - PastMatchesWelcome
struct PastMatchesWelcome: Codable {
    let welcomeGet: String
    let errors: [JSONAny]
    let results: Int
    let response: [PastMatchesResponse]?

    enum CodingKeys: String, CodingKey {
        case welcomeGet = "get"
        case errors, results, response
    }
}

// MARK: - PastMatchesResponse
struct PastMatchesResponse: Codable {
    let fixture: PastMatchesFixture
    let teams, goals: PastMatchesGoals
}

// MARK: - PastMatchesFixture
struct PastMatchesFixture: Codable {
    let id: Int
    let referee: String?
    let timezone: PastMatchesTimezone
    let date: String
    let timestamp: Int
}


enum PastMatchesTimezone: String, Codable {
    case utc = "UTC"
}

// MARK: - PastMatchesGoals
struct PastMatchesGoals: Codable {
    let home, away: PastMatchesAwayUnion
}

enum PastMatchesAwayUnion: Codable {
    case integer(Int)
    case pastMatchesAwayClass(PastMatchesAwayClass)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(PastMatchesAwayClass.self) {
            self = .pastMatchesAwayClass(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(PastMatchesAwayUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for PastMatchesAwayUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .pastMatchesAwayClass(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

// MARK: - PastMatchesAwayClass
struct PastMatchesAwayClass: Codable {
    let id: Int
    let name: String
    let logo: String
    let winner: Bool?
}
