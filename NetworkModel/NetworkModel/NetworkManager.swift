//
//  NetworkManager.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 2022/07/01.
//

import Foundation

actor NetworkActor {
    let baseURL: String
    private var session = URLSession(configuration: URLSessionConfiguration.default,
                                     delegate: nil,
                                     delegateQueue: nil)
    
    private let request: (URL, NetworkService.ModelRoute) -> URLRequest =  { url, route in
        var request = URLRequest(url: url)
        request.httpMethod = route.method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    deinit {
        self.session.finishTasksAndInvalidate()
    }
}

extension NetworkActor {
    func sendRequest<D: Codable>(route: NetworkService.ModelRoute, decodeTo: D.Type) async throws -> D {
        guard let url = URL(string: self.baseURL + route.stringValue) else {
            throw NetworkError.invalidURL
        }
        
        let request = self.request(url,route)
        let (data, _) = try await self.session.data(for: request)
        let result = try JSONDecoder().decode(D.self, from: data)
        return result
    }
}

//final class NetworkManager {
//    let baseURL: String
//    private var session = URLSession(configuration: URLSessionConfiguration.default,
//                                     delegate: nil,
//                                     delegateQueue: nil)
//
//    private let queue = DispatchQueue.global()
//
//    init(baseURL: String) {
//        self.baseURL = baseURL
//    }
//
//    deinit {
//        self.session.finishTasksAndInvalidate()
//    }
//
//    func sendRequest<E: Encodable, D: Decodable>(route: Route, params: E, decodeTo: D.Type, completion: @escaping (D?, NetworkError?) -> Void) {
//
//        queue.async { [weak self] in
//
//            guard let self = self else {
//                completion(nil, NetworkError.managerIsNil)
//                return
//            }
//
//            guard let url = URL(string: self.baseURL + route.stringValue) else {
//                completion(nil, NetworkError.invalidURL)
//                return
//            }
//
//            var request = URLRequest(url: url)
//            request.httpMethod = route.method.rawValue
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//            guard let jsonData = try? JSONEncoder().encode(params) else {
//                completion(nil, NetworkError.errorEncodingJson)
//                return
//            }
//            request.httpBody = jsonData
//
//            let task = self.session.dataTask(with: request) { data, response, error in
//
//                guard let data = data, error == nil else {
//                    completion(nil, NetworkError.nilResponse)
//                    return
//                }
//
//                guard let result = try? JSONDecoder().decode(D.self, from: data) else {
//                    completion(nil, NetworkError.errorDecodingJson)
//                    return
//                }
//
//                completion(result, nil)
//            }
//            task.resume()
//        }
//    }
//
//    func sendRequest<D: Decodable>(route: Route, decodeTo: D.Type, completion: @escaping (D?, NetworkError?) -> Void) {
//
//        queue.async { [weak self] in
//
//            guard let self = self else {
//                completion(nil, NetworkError.managerIsNil)
//                return
//            }
//
//            guard let url = URL(string: self.baseURL + route.stringValue) else {
//                completion(nil, NetworkError.invalidURL)
//                return
//            }
//
//            var request = URLRequest(url: url)
//            request.httpMethod = route.method.rawValue
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//            let task = self.session.dataTask(with: request) {  data, response, error in
//
//                guard let data = data, error == nil else {
//                    completion(nil, NetworkError.nilResponse)
//                    return
//                }
//
//                guard let result = try? JSONDecoder().decode(D.self, from: data) else {
//                    completion(nil, NetworkError.errorDecodingJson)
//                    return
//                }
//                completion(result, nil)
//            }
//
//            task.resume()
//        }
//
//    }
//}
