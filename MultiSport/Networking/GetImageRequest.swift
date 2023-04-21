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
    
//    func getImage(urlString: String, completion: @escaping (Result<UIImage?,Error>) -> Void) {
//    
//        guard let url = URL(string: urlString) else { return }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            DispatchQueue.global(qos: .userInitiated).async {
//                guard let data = data,
//                      let image = UIImage(data: data) else {
//                    return
//                }
//                
//                DispatchQueue.main.async {
//                    completion(.success(image))
//                }
//            }
//        }.resume()
//        
//    }
    
//    func getImages(urlString: [String], compltion: @escaping (Result<[UIImage?],Error>) -> Void) {
//        var images = [UIImage?]()
//        urlString.forEach { urlS in
//            getImage(urlString: urlS) { result in
//                switch result {
//                case .success(let image):
//                    images.append(image)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
//        compltion(.success(images))
//    }
    
//    func getImages(urlString: [String], completion: @escaping (Result<[UIImage?],Error>) -> Void) {
//        var images = [UIImage?]()
//        let group = DispatchGroup()
//
//        for urlS in urlString {
//            group.enter()
//            getImage(urlString: urlS) { res in
//                switch res {
//                case .success(let image):
//                    images.append(image)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    images.append(nil)
//                }
//                group.leave()
//            }
//
//            group.notify(queue: .main) {
//                completion(.success(images))
//            }
//        }
//    }
//    
    
    func test(with urlString: String?) async -> UIImage? {
        
        guard
            let string = urlString,
            let url = URL.init(string: string)
        else {
            return nil
        }
        
        guard
            let theData = try? Data(contentsOf: url),
            let image = UIImage(data: theData)
        else {
            return nil
        }
        
        return image
    }
        
    
}
