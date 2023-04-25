// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let statisticMatchWelcome = try? JSONDecoder().decode(StatisticMatchWelcome.self, from: jsonData)

import Foundation

// MARK: - StatisticMatchWelcome
struct StatisticMatchWelcome: Codable {
    let welcomeGet: String
    let errors: [JSONAny]
    let results: Int
    let response: [StatisticMatchResponse]?

    enum CodingKeys: String, CodingKey {
        case welcomeGet = "get"
        case errors, results, response
    }
}

// MARK: - StatisticMatchResponse
struct StatisticMatchResponse: Codable {
    let fixture: StatisticMatchFixture
    let teams, goals: StatisticMatchTeamsClass
    let score: StatisticMatchScore
    let statistics: [StatisticMatchResponseStatistic]
}

// MARK: - StatisticMatchTeam
struct StatisticMatchTeam: Codable {
    let id: Int
    let name: String
    let logo: String
}


// MARK: - StatisticMatchFixture
struct StatisticMatchFixture: Codable {
    let id: Int
    let date: String
    let timestamp: Int
}

// MARK: - StatisticMatchTeamsClass
struct StatisticMatchTeamsClass: Codable {
    let home, away: StatisticMatchAway
}

enum StatisticMatchAway: Codable {
    case integer(Int)
    case statisticMatchTeam(StatisticMatchTeam)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(StatisticMatchTeam.self) {
            self = .statisticMatchTeam(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(StatisticMatchAway.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for StatisticMatchAway"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .statisticMatchTeam(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}


// MARK: - StatisticMatchPlayerStatistic
struct StatisticMatchPlayerStatistic: Codable {
    let offsides: Int?
    let shots: StatisticMatchShots
    let goals: StatisticMatchStatisticGoals
    let passes: StatisticMatchPasses
    let tackles: StatisticMatchTackles
    let duels: StatisticMatchDuels
    let dribbles: StatisticMatchDribbles
    let fouls: StatisticMatchFouls
    let cards: StatisticMatchCards
    let penalty: StatisticMatchPenalty
}

// MARK: - StatisticMatchCards
struct StatisticMatchCards: Codable {
    let yellow, red: Int
}

// MARK: - StatisticMatchDribbles
struct StatisticMatchDribbles: Codable {
    let attempts, success, past: Int?
}

// MARK: - StatisticMatchDuels
struct StatisticMatchDuels: Codable {
    let total, won: Int?
}

// MARK: - StatisticMatchFouls
struct StatisticMatchFouls: Codable {
    let drawn, committed: Int?
}

// MARK: - StatisticMatchStatisticGoals
struct StatisticMatchStatisticGoals: Codable {
    let total: Int?
    let conceded: Int
    let assists, saves: Int?
}

// MARK: - StatisticMatchPasses
struct StatisticMatchPasses: Codable {
    let total, key: Int?
    let accuracy: String?
}

// MARK: - StatisticMatchPenalty
struct StatisticMatchPenalty: Codable {
    let won, commited: JSONNull?
    let scored, missed: Int
    let saved: Int?
}

// MARK: - StatisticMatchShots
struct StatisticMatchShots: Codable {
    let total, on: Int?
}

// MARK: - StatisticMatchTackles
struct StatisticMatchTackles: Codable {
    let total, blocks, interceptions: Int?
}

// MARK: - StatisticMatchScore
struct StatisticMatchScore: Codable {
    let halftime, fulltime, extratime, penalty: StatisticMatchTeamsClass
}

// MARK: - StatisticMatchResponseStatistic
struct StatisticMatchResponseStatistic: Codable {
    let team: StatisticMatchTeam
    let statistics: [StatisticMatchStatisticStatistic]
}

// MARK: - StatisticMatchStatisticStatistic
struct StatisticMatchStatisticStatistic: Codable {
    let type: String
    let value: StatisticMatchValue
}

enum StatisticMatchValue: Codable {
    case integer(Int)
    case string(String)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(StatisticMatchValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for StatisticMatchValue"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}


