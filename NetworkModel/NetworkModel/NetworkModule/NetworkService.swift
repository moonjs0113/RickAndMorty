//
//  RNMService.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 2022/07/01.
//

import Foundation

enum NetworkService {
    static let baseURL = "https://rickandmortyapi.com/api/"
    static let manager = NetworkActor(baseURL: baseURL)
}

extension NetworkService {
    enum ModelRoute: String, RouteProtocol {
        var stringValue: String {
            self.rawValue
        }
        
        var method: HTTPMethod {
            return .GET
        }
        
        case character
        case location
        case episode
        
        static func convertToString<M: Codable>(to model: M.Type) -> ModelRoute? {
            switch model {
            case is Character.Type:
                return .character
            case is Location.Type:
                return .location
            case is Episode.Type:
                return .episode
            default:
                return nil
            }
        }
        
        static func requestTotalCount<M: Codable>(to model: M.Type) async throws -> ModelList<M> {
            guard let route = self.convertToString(to: model) else {
                throw NetworkError.invalidType
            }
            return try await manager.sendRequest(route: route, decodeTo: ModelList<M>.self)
        }
        
        static func requestObject<M: Codable>(as model: M.Type, id: Int) async throws -> M {
            guard let route = self.convertToString(to: model) else {
                throw NetworkError.invalidType
            }
            return try await manager.sendRequest(route: route, id: id, decodeTo: model)
        }
    }
}
