//
//  NetworkingDataFetch.swift
//  MultiSport
//
//  Created by Витя Рябко on 13/04/23.
//

import Foundation


enum DataFetchError: Error {
    case decodingError(Error)
    case networkError(Error)
}
class NetworkDataFetch {
    static let shared = NetworkDataFetch()
    private init() {}
    
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
