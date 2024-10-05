//
//  NetworkCache.swift
//  RickAndMorty
//
//  Created by Moon Jongseek on 9/24/24.
//

import Foundation

struct CacheManger {
    private init() { }
    static private let share: CacheManger = CacheManger()
    
    
    static public var imageCache: URLCache {
        return share.image
    }
    
    static public var dataCache: URLCache {
        return share.data
    }
    
    private let image: URLCache = URLCache(memoryCapacity: 100.MB, diskCapacity: 200.MB, directory: .cachesDirectory)
    private let data: URLCache = URLCache(memoryCapacity: 50.MB, diskCapacity: 100.MB, directory: .documentsDirectory)
}
