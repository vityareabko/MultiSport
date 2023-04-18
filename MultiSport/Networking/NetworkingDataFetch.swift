//
//  NetworkingDataFetch.swift
//  MultiSport
//
//  Created by Витя Рябко on 13/04/23.
//

import Foundation

class NetworkDataFetch {
    static let shared = NetworkDataFetch()
    private init() {}
 
    func fetchResponse(urlRequest: URL, response: @escaping (Welcome?, Error?) -> Void) {
        NetworkingRequest.shared.requestData(url: urlRequest) { result in
            switch result {
            case .success(let data):
                // декодируем наш json в нашу структуру
                do {
                    let model = try JSONDecoder().decode(Welcome.self, from: data)
                    response(model, nil)
                } catch let jsonError {
                    // это ошибка декодирования
                    print("Failed to decode JSON :", jsonError)
                }

            case .failure(let error):
                // это ошибка относиться к получения данных
                print(error.localizedDescription)
                response(nil, error)
            }
        }
    }
}

