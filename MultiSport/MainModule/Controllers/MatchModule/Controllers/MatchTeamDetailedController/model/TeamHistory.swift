// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let teamHistoryWelcome = try? JSONDecoder().decode(TeamHistoryWelcome.self, from: jsonData)

import Foundation

//// MARK: - TeamHistoryWelcome
//struct TeamHistory: Codable {
//    let welcomeGet: String
//    let errors: [JSONAny]
//    let results: Int
//    let response: [TeamHistoryResponse]
//
//    enum CodingKeys: String, CodingKey {
//        case welcomeGet = "get"
//        case errors, results, response
//    }
//}
//
//// MARK: - TeamHistoryResponse
//struct TeamHistoryResponse: Codable {
//    let fixture: TeamHistoryFixture
//    let teams: TeamHistoryTeams
//    let goals: TeamHistoryGoals
//    let score: TeamHistoryScore
//}
//
//// MARK: - TeamHistoryFixture
//struct TeamHistoryFixture: Codable {
//    let id: Int
//    let timezone: TeamHistoryTimezone
//    let date: String
//    let timestamp: Int
//}
//
//enum TeamHistoryTimezone: String, Codable {
//    case utc = "UTC"
//}
//
//
//// MARK: - TeamHistoryGoals
//struct TeamHistoryGoals: Codable {
//    let home, away: Int?
//}
//
//// MARK: - TeamHistoryScore
//struct TeamHistoryScore: Codable {
//    let fulltime: TeamHistoryGoals
//}
//
//// MARK: - TeamHistoryTeams
//struct TeamHistoryTeams: Codable {
//    let home, away: TeamHistoryAway
//}
//
//// MARK: - TeamHistoryAway
//struct TeamHistoryAway: Codable {
//    let id: Int
//    let name: String
//    let logo: String
//    let winner: Bool?
//}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let historyTeamMatchesWelcome = try? JSONDecoder().decode(HistoryTeamMatchesWelcome.self, from: jsonData)

import Foundation

// MARK: - HistoryTeamMatchesWelcome
struct HistoryTeamMatchesWelcome: Codable {
    let welcomeGet: String
    let errors: [JSONAny]
    let results: Int
    let response: [HistoryTeamMatchesResponse]?

    enum CodingKeys: String, CodingKey {
        case welcomeGet = "get"
        case errors, results, response
    }
}

// MARK: - HistoryTeamMatchesResponse
struct HistoryTeamMatchesResponse: Codable {
    let fixture: HistoryTeamMatchesFixture
    let teams, goals: HistoryTeamMatchesGoals
}

// MARK: - HistoryTeamMatchesFixture
struct HistoryTeamMatchesFixture: Codable {
    let id: Int
    let timezone: String
    let date: String
    let timestamp: Int
}

// MARK: - HistoryTeamMatchesGoals
struct HistoryTeamMatchesGoals: Codable {
    let home, away: HistoryTeamMatchesAwayUnion
}

enum HistoryTeamMatchesAwayUnion: Codable {
    case historyTeamMatchesAwayClass(HistoryTeamMatchesAwayClass)
    case integer(Int)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(HistoryTeamMatchesAwayClass.self) {
            self = .historyTeamMatchesAwayClass(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(HistoryTeamMatchesAwayUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for HistoryTeamMatchesAwayUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .historyTeamMatchesAwayClass(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

// MARK: - HistoryTeamMatchesAwayClass
struct HistoryTeamMatchesAwayClass: Codable {
    let id: Int
    let name: String
    let logo: String
    let winner: Bool?
}

