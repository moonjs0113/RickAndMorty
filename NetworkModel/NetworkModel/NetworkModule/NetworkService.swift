//
//  RNMService.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 2022/07/01.
//

import Foundation

typealias NetworkClosure<D: Codable> = (D?, NetworkError?) -> Void

enum NetworkService {
    static let baseURL = "https://rickandmortyapi.com/api/"
    static let manager = NetworkManager(baseURL: baseURL)
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
        
        static func requestTotalCount<M: Codable>(to model: M.Type, completeHandler: @escaping NetworkClosure<ModelList<M>>) {
            guard let route = self.convertToString(to: model) else {
                completeHandler(nil, NetworkError.invalidType)
                return
            }
            
            manager.sendRequest(route: route, decodeTo: ModelList<M>.self) { info, error in
                completeHandler(info, error)
            }
            
        }
        
        static func requestObject<M: Codable>(as model: M.Type, id: Int, completeHandler: @escaping NetworkClosure<M>) {
            guard let route = self.convertToString(to: model) else {
                completeHandler(nil, NetworkError.invalidType)
                return
            }
            
            manager.sendRequest(route: route, id: id, decodeTo: model.self) { result, error in
                completeHandler(result, error)
            }
        }
    }
}
