//
//  DiskCache.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/7/25.
//

import UIKit

class DiskCache {
    static let shared = DiskCache()
    private let fileManager = FileManager.default
        
    private init() {}
    
    // Load image from disk cache
    func loadImage(_ url: URL) -> UIImage? {
        if let filePath = checkPath(url), fileManager.fileExists(atPath: filePath) {
            return UIImage(contentsOfFile: filePath)
        }
        
        return nil
    }
    
    // Save image to disk cache
    func saveImage(_ image: UIImage, _ url: URL, _ option: CacheOption) {
        guard option != .onlyMemory,
              option != .nothing else {
            return
        }
        
        if let filePath = checkPath(url), !(fileManager.fileExists(atPath: filePath)) {
            // Save image to Disk
            fileManager.createFile(atPath: filePath,
                                   contents: image.jpegData(compressionQuality: 1.0),
                                   attributes: nil)
        }
    }
    
    // Check if the path of the file is valid
    private func checkPath(_ url: URL) -> String? {
        let key = url.absoluteString
        let documentsURL = try? fileManager.url(for: .cachesDirectory,
                                                in: .userDomainMask,
                                                appropriateFor: nil,
                                                create: true)
        let fileURL = documentsURL?.appendingPathComponent(key)
        
        return fileURL?.path
    }
}
