//
//  GetImage.swift
//  MultiSport
//
//  Created by Витя Рябко on 18/04/23.
//

import Foundation

class GetImageRequest {
    static let shared = GetImageRequest()
    private init() {}
    
    private func getImage(url: URL, compltion: @escaping (Result<Data,Error>) -> Void) {
//        URLSession.shared.dataTask(with: url)?÷
    }
}
