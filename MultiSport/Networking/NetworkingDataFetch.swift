//
//  NetworkingDataFetch.swift
//  MultiSport
//
//  Created by Витя Рябко on 13/04/23.
//

import Foundation

// TODO: - демонстрация №3

enum DataFetchError: Error {
    case decodingError(Error)
    case networkError(Error)
}

class NetworkDataFetch {
    static let shared = NetworkDataFetch()
    private init() {}
//
//    func fetchFutureFootballMatchesResponse(urlRequest: URL, response: @escaping (FutureFootballMatches?, Error?) -> Void) {
//        NetworkingRequest.shared.requestData(url: urlRequest) { result in
//            switch result {
//            case .success(let data):
//                // декодируем наш json в нашу структуру
//                do {
//                    let model = try JSONDecoder().decode(FutureFootballMatches.self, from: data)
//                    DispatchQueue.main.async {
//                        response(model, nil)
//                    }
//                } catch let jsonError {
//                    // это ошибка декодирования
//                    print("Failed to decode JSON :", jsonError)
//                    response(nil, jsonError)
//                }
//
//            case .failure(let error):
//                // это ошибка относиться к получения данных
//                print(error.localizedDescription)
//                response(nil, error)
//            }
//        }
//    }
//
//    func fetchPastFootballMatchesResponse(urlRequest: URL, response: @escaping (PastMatchesWelcome?, Error?) -> Void) {
//        NetworkingRequest.shared.requestData(url: urlRequest) { result in
//            switch result {
//            case .success(let data):
//                // декодируем наш json в нашу структуру
//                do {
//                    let model = try JSONDecoder().decode(PastMatchesWelcome.self, from: data)
//                    DispatchQueue.main.async {
//                        response(model, nil)
//                    }
//                } catch let jsonError {
//                    // это ошибка декодирования
//                    print("Failed to decode JSON :", jsonError)
//                    response(nil, jsonError)
//                }
//
//            case .failure(let error):
//                // это ошибка относиться к получения данных
//                print(error.localizedDescription)
//                response(nil, error)
//            }
//        }
//    }
    
    
    func fetchData<T: Decodable>(urlRequest: URL, completion: @escaping (Result<T, DataFetchError>) -> Void) {
        NetworkingRequest.shared.requestData(url: urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(model))
                    }
                } catch let jsonError {
                    print("Failed to decode JSON:", jsonError)
                    completion(.failure(.decodingError(jsonError)))
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(.networkError(error)))
            }
        }
    }
    
    func fetchFutureFootballMatchesResponse(urlRequest: URL, completion: @escaping (Result<FutureFootballMatches, DataFetchError>) -> Void) {
        fetchData(urlRequest: urlRequest, completion: completion)
    }
    
    func fetchPastFootballMatchesResponse(urlRequest: URL, completion: @escaping (Result<PastMatchesWelcome, DataFetchError>) -> Void) {
        fetchData(urlRequest: urlRequest, completion: completion)
    }
    
    func fetchHistoryTeamMatches(urlRequest: URL, completion: @escaping (Result<HistoryTeamMatchesWelcome, DataFetchError>) -> Void ) {
        fetchData(urlRequest: urlRequest, completion: completion)
    }
    
    func fetchStatisticMatchByIdFixtures(urlRequest: URL, completion: @escaping (Result<StatisticMatchWelcome, DataFetchError>) -> Void ) {
        fetchData(urlRequest: urlRequest, completion: completion)
    }
}

