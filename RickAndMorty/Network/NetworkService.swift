//
//  RNMService.swift
//  RickAndMorty
//
//  Created by Moon Jongseek on 2022/07/01.
//

import Foundation

typealias NetworkClosure<D: Codable> = (D?, NetworkError?) -> Void

enum NetworkService {
    private static let manager = NetworkManager()
    
    // Single Object From URL String
    static func getSingleObject<M: ModelProtocol>(from urlString: String) async throws -> M {
        try await manager.request(to: urlString)
    }
    
    // Single Object From ID
    static func getSingleObject<M: ModelProtocol>(fromID id: Int) async throws -> M {
        try await manager.request(from: M.dataType, with: "\(id)")
    }
    
    // Multiple Object From ID
    static func getMultipleObjects<M: ModelProtocol>(fromIDs ids: [Int]) async throws -> [M] {
        try await manager.request(from: M.dataType, with: ids.map(String.init).joined(separator: ","))
    }
    
    // Object Page
    static func getObjectPage<M: ModelProtocol>(from page: Int = 1) async throws -> ModelList<M> {
        try await manager.request(from: M.dataType, with: "?page=\(page)")
    }
    
    // Image
    static func imageLoad(from urlString: String) async throws -> Data {
        try await manager.request(to: urlString, .GET, .image)
    }
    
//    static func requestTotalObject<M: Codable>(as model: M.Type, pageURL: String?, completeHandler: @escaping NetworkClosure<ModelList<M>>) {
//        guard let route = ModelRoute.convertToString(to: model) else {
//            completeHandler(nil, NetworkError.invalidType)
//            return
//        }
//        guard let pageURL = pageURL else {
//            manager.sendRequest(route: route, decodeTo: ModelList<M>.self) { info, error in
//                completeHandler(info, error)
//            }
//            return
//        }
//        manager.sendRequest(urlString: pageURL, decodeTo: ModelList<M>.self) { info, error in
//            completeHandler(info, error)
//        }
//    }
    
//    static func requestObject<M: Codable, F: FilterProtocol>(as model: M.Type, filterBy filter: [F] = [], completeHandler: @escaping NetworkClosure<ModelList<M>>) {
//        guard let route = ModelRoute.convertToString(to: model) else {
//            completeHandler(nil, NetworkError.invalidType)
//            return
//        }
//        
//        manager.sendRequest(route: route, filterBy: filter, decodeTo: ModelList<M>.self) { info, error in
//            completeHandler(info, error)
//        }
//    }
    
    // Single or Multile Object(s)
//    static func requestSingleObject<M: Codable>(as model: M.Type, id: Int, completeHandler: @escaping NetworkClosure<M>) {
//        guard let route = ModelRoute.convertToString(to: model) else {
//            completeHandler(nil, NetworkError.invalidType)
//            return
//        }
//        
//        manager.sendRequest(route: route, ids: [id], decodeTo: model.self) { result, error in
//            completeHandler(result, error)
//        }
//    }
    
//    static func requestMultipleObjects<M: Codable>(as model: M.Type, id: [Int], completeHandler: @escaping NetworkClosure<[M]>) {
//        guard let route = ModelRoute.convertToString(to: model) else {
//            completeHandler(nil, NetworkError.invalidType)
//            return
//        }
//        
//        manager.sendRequest(route: route, ids: id, decodeTo: [M].self) { result, error in
//            completeHandler(result, error)
//        }
//    }
}
