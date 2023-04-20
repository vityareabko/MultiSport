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
    
    func getImage(urlString: String, compltion: @escaping (Result<UIImage?,Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.global(qos: .background).async {
                guard let data = try? Data(contentsOf: url) else {
                    return
                }
                DispatchQueue.main.async {
                    guard let image = UIImage(data: data) else { return }
                    compltion(.success(image))
                }
            }
        }.resume()
        
    }
    
    func getImage(urlString: [String], compltion: @escaping (Result<[UIImage?],Error>) -> Void) {
        var images = [UIImage?]()
        urlString.forEach { urlS in
            getImage(urlString: urlS) { result in
                switch result {
                case .success(let image):
                    images.append(image)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
       
        
       
        
    }
}
