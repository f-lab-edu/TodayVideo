//
//  ImageCache.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/7/25.
//

import UIKit

/*
 캐시 로직 출처
 https://velog.io/@o_joon_/Swift-Image-caching%EC%9D%B4%EB%AF%B8%EC%A7%80-%EC%BA%90%EC%8B%B1
 https://github.com/vhzkclq0705/Swift/tree/main/PracticeCaching
 */

enum CacheOption {
    case onlyMemory // 메모리에만 캐시 저장
    case onlyDisk // 디스크에만 캐시 저장
    case both // 메모리와 디스크 모두에 캐시 저장(기본값)
    case nothing // 캐시 저장 안함
}

class ImageCache {
    static let shared = ImageCache()
    private let memoryCache = NSCache<NSString, UIImage>()
    private let imageBaseUrl = Bundle.main.imageBaseUrl
    
    private init() {}
    
    func loadImage(_ path: String?, _ option: CacheOption = .both, completion: @escaping (UIImage?) -> Void) {
        let path = path ?? ""
        guard let url = URL(string: "\(imageBaseUrl)\(path)") else {
            completion(nil)
            return
        }
        let key = url.absoluteString
        
        // Load image from Memory
        if let cachedImage = memoryCache.object(forKey: key as NSString) {
            completion(cachedImage)
        }

        // Load image from disk
        DispatchQueue.global(qos: .utility).async {
            if let cachedImage = DiskCache.shared.loadImage(url) {
                self.saveImage(cachedImage, url, option)
                completion(cachedImage)
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    self.saveImage(image, url, option)
                    DiskCache.shared.saveImage(image, url, option)
                    completion(image)
                } else {
                    completion(nil)
                }
            }.resume()
        }
    }
    
    // Save image to memory
    func saveImage(_ image: UIImage, _ url: URL, _ option: CacheOption) {
        if option == .onlyDisk || option == .nothing {
            return
        }
        
        
        let key = url.absoluteString as NSString
        memoryCache.setObject(image, forKey: key)
    }
}
