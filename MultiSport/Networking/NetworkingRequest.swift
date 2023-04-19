//
//  NetworkingRequest.swift
//  MultiSport
//
//  Created by Витя Рябко on 13/04/23.
//

import Foundation


class NetworkingRequest {
    static let shared = NetworkingRequest()
    private init() {}
    
    func requestData(url: URL, complition: @escaping (Result<Data, Error>) -> Void) {
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = getApiKey()
        
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        complition(.failure(error))
                    }
                    guard let data = data else { return }
                    complition(.success(data))
                    
                }
            }.resume()
        }
        
    }
}

