//
//  NetworkingRequest.swift
//  MultiSport
//
//  Created by Витя Рябко on 13/04/23.
//

import Foundation

// TODO: - демонстрация №6

class NetworkingRequest {
    static let shared = NetworkingRequest()
    private let cache = NSCache<NSURL, NSData>()
    private init() {}
    
    func requestData(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = getApiKey()
        
        
        // Проверяем, есть ли данные в кэше
        if let cachedData = cache.object(forKey: url as NSURL) {
            DispatchQueue.main.async {
                completion(.success(cachedData as Data))
            }
            return
        }
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                                    
                if let data = data {
                    // Сохраняем данные в кэше
                    self.cache.setObject(data as NSData, forKey: url as NSURL)
                    completion(.success(data))
                    print("CASHE")
                }
            }
        }.resume()
        
        
    }
}

