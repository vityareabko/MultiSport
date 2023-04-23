//
//  ConfigURL.swift
//  MultiSport
//
//  Created by Витя Рябко on 18/04/23.
//

//V3 - Fixtures by team id

// нужны параметры
// status = FT - всегда это уже законченые матчи
// last = последнее матчи
// team - это id команды

import Foundation

struct ServerData {
    static var shared = ServerData()
    var scheme: String {
        "https"
    }
    var host: String {
        Host.developer.rawValue
    }
    var baseURL: URL? {
        URL(string: "\(scheme)://\(host)")
    }
}

enum Host: String {
    case release = "release.api-football-beta.p.rapidapi.com"
    case developer = "api-football-beta.p.rapidapi.com"
}

enum APIPath {
    case fixturesNext(next: Int? = 5, leagueID: LeagueID)
    case fixturesLast(last: Int? = 5, leagueID: LeagueID)
    case fixturesByTeamId(status: String = "FT", last: Int? = 15, teamID: Int)
    
    // we get path - https:/api..../fixtures?
    var path: String {
        switch self {
        case .fixturesNext(_,_):
            return "v3/fixtures"
        case .fixturesLast(_,_):
            return "v3/fixtures"
        case .fixturesByTeamId(_,_,_):
            return "v3/fixtures"
        }
    }
    
    // get ["next","value"] = https:/api..../{path}?&next=10
    var parameters: [URLQueryItem] {
        var result: [URLQueryItem] = []
        switch self {
        case .fixturesNext(let next, let leagueId):
            if let theNext = next {
                result.append(URLQueryItem(name: "next", value: "\(theNext)"))
            }
            
            result.append(URLQueryItem(name: "league", value: "\(leagueId.rawValue)"))
        
        case .fixturesLast(let last, let leagueId):
            if let theLast = last {
                result.append(URLQueryItem(name: "last", value: "\(theLast)"))
            }
            
            result.append(URLQueryItem(name: "league", value: "\(leagueId.rawValue)"))
            
        case .fixturesByTeamId(let status, let last, let teamID):
            
            result.append(URLQueryItem(name: "status", value: "\(status)"))
            
            result.append(URLQueryItem(name: "team", value: "\(teamID)"))
            
            if let theLast = last {
                result.append(URLQueryItem(name: "last", value: "\(theLast)"))
            }
        }

        return result
    }
}

// "https://api-football-v1.p.rapidapi.com/v3/fixtures?league=140&next=10"

struct NetworkManager {
    let serverData: ServerData = ServerData.shared
    static var shared = NetworkManager()
    
    func request(with apiPath: APIPath) -> URL? {
        guard var url = serverData.baseURL else {
            print("url is invalid")
            return nil
        }
        
//        var urlComponents = URLComponents.init(url: url, resolvingAgainstBaseURL: false)
//        urlComponents?.path = apiPath.path
//        urlComponents?.queryItems = apiPath.parameters
//
//
        if #available(iOS 16.0, *) {
            url.append(path: apiPath.path)
            url.append(queryItems: apiPath.parameters)
        } else {
            // Fallback on earlier versions
        }
//
        print(url)
        return url
        
    }
}
