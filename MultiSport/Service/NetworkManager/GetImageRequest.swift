//
//  GetImage.swift
//  MultiSport
//
//  Created by Витя Рябко on 18/04/23.
//

import UIKit

// для отключения проверку сертификата
class InsecureURLSessionDelegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}


class GetImageRequest {
    static let shared = GetImageRequest()
    private init() {}


    // это экземпляр URLSession без проверки сертикфиката
    private let insecureSession = URLSession(configuration: .default, delegate: InsecureURLSessionDelegate(), delegateQueue: nil)
    
    // Кеш для хранения изображений
    private let imageCache = NSCache<NSString, UIImage>()
        
    func test(with urlString: String, retryAttempts: Int = 10, delayBetweenRetries: TimeInterval = 2.0) async -> UIImage? {
        guard let url = URL(string: urlString) else {
            return nil
        }

        // Проверка, есть ли изображение в кеше
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            return cachedImage
        }

        
        for attempt in 1...retryAttempts {
            do {
                let (data, _) = try await insecureSession.data(from: url)
                if let image = UIImage(data: data) {
                    
                    imageCache.setObject(image, forKey: urlString as NSString)
                    return image
                }
            } catch {
                print("Failed to load image on attempt \(attempt): \(error.localizedDescription)")
                if attempt < retryAttempts {
                    do {
                        try await Task.sleep(nanoseconds: UInt64(delayBetweenRetries * 1_000_000_000))
                    } catch {
                        print("Error during Task.sleep: \(error.localizedDescription)")
                    }
                }
            }
        }

        return nil
    }
}




