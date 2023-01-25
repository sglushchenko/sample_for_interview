//
//  CacheConfig.swift
//  SampleForEmployer
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import Foundation
import SDWebImage

extension SDImageCache {
    static func cache(title: String, diskSize: UInt, memorySize: UInt) -> SDImageCache {
        let cache = SDImageCache(namespace: title)
        cache.config.maxDiskSize = diskSize
        cache.config.maxMemoryCost = memorySize
        return cache
    }
}

extension SDImageCache {
    static var defaultCache: SDImageCache {ImageCacheService.shared.defaultCache}
    static var userCache: SDImageCache {ImageCacheService.shared.userCache}
}

class ImageCacheService {
    var defaultCache: SDImageCache
    var userCache: SDImageCache
    
    static let defaultInMemorySize: UInt = 150 * 1024 * 1024
    static let defaultDiskSize: UInt = 100 * 1024 * 1024
    static let shared = ImageCacheService()
    
    private init () {
        self.defaultCache = ImageCacheService.createDefaultCache(title: "default")
        self.userCache = ImageCacheService.createDefaultCache(title: "user")

        let userpicksLoader = SDWebImageDownloader()
        
        SDImageCachesManager.shared.addCache(defaultCache)
        SDImageCachesManager.shared.addCache(userCache)

        SDWebImageManager.defaultImageCache = defaultCache
    }

    private static func createDefaultCache(title: String) -> SDImageCache {
        return SDImageCache.cache(title: title,
                                  diskSize: defaultDiskSize,
                                  memorySize: defaultInMemorySize)
    }
}
