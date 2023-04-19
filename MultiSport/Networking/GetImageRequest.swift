//
//  GetImage.swift
//  MultiSport
//
//  Created by Витя Рябко on 18/04/23.
//

import UIKit

class GetImageRequest {
    static let shared = GetImageRequest()
    private init() {}
    
    func getImage(urlString: String, compltion: @escaping (Result<Data,Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async {
                compltion(.success(data))
            }
        }
    }
}
