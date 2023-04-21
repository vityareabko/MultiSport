//
//  ConfigURL.swift
//  MultiSport
//
//  Created by Витя Рябко on 18/04/23.
//

import Foundation

enum LeaguesId: Int {
    case laLeague = 140
    case nation = 5
    case premierNational = 129
    case premierLegue = 315
}

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
    case fixtures(next: Int? = 3, leagueID: LeaguesId)
    
    // we get path - https:/api..../fixtures?
    var path: String {
        switch self {
        case .fixtures(_,_):
            return "v3/fixtures"
        }
    }
    
    // get ["next","value"] = https:/api..../fixtures?&next=10
    var parameters: [URLQueryItem] {
        var result: [URLQueryItem] = []
        switch self {
        case .fixtures(let next, let leagueId):
            if let theNext = next {
                result.append(URLQueryItem(name: "next", value: "\(theNext)"))
            }
            
            result.append(URLQueryItem(name: "league", value: "\(leagueId.rawValue)"))
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
//            url.appendPathComponent(apiPath.path)

        }
//
        
        return url
        
    }
}
