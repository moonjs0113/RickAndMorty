//
//  RNMNetworkManager.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 2022/07/01.
//

import Foundation


final class RNMNetworkManager {
    
    let baseURL: String
    
    private var session = URLSession(configuration: URLSessionConfiguration.default,
                                     delegate: nil,
                                     delegateQueue: nil)
    
    private let queue = DispatchQueue(label: "com.organization.network-manager", attributes: .concurrent)
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    deinit {
        self.session.finishTasksAndInvalidate()
    }
    func sendRequest<E: Encodable, D: Decodable>(route: RouteProtocol, params: E, decodeTo: D.Type, completion: @escaping (D?, Error?) -> Void) {
        
        queue.async { [weak self] in
            
            guard let self = self else {
                completion(nil, RNMNetworkError.managerIsNil)
                return
            }
            
            guard let url = URL(string: self.baseURL + route.stringValue) else {
                completion(nil, RNMNetworkError.invalidURL)
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = route.method
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            guard let jsonData = try? JSONEncoder().encode(params) else {
                completion(nil, RNMNetworkError.errorEncodingJson)
                return
            }
            request.httpBody = jsonData
            
            let task = self.session.dataTask(with: request) { data, response, error in
                
                guard let data = data, error == nil else {
                    completion(nil, RNMNetworkError.nilResponse)
                    return
                }
                
                guard let result = try? JSONDecoder().decode(D.self, from: data) else {
                    completion(nil, RNMNetworkError.errorDecodingJson)
                    return
                }
                
                completion(result, nil)
            }
            
            task.resume()
        }
        
    }
    func sendRequest<D: Decodable>(route: RouteProtocol, decodeTo: D.Type, completion: @escaping (D?, Error?) -> Void) {
        
        queue.async { [weak self] in
            
            guard let self = self else {
                completion(nil, RNMNetworkError.managerIsNil)
                return
            }
            
            guard let url = URL(string: self.baseURL + route.stringValue) else {
                completion(nil, RNMNetworkError.invalidURL)
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = route.method
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = self.session.dataTask(with: request) {  data, response, error in
                
                guard let data = data, error == nil else {
                    completion(nil, RNMNetworkError.nilResponse)
                    return
                }
                
                guard let result = try? JSONDecoder().decode(D.self, from: data) else {
                    completion(nil, RNMNetworkError.errorDecodingJson)
                    return
                }
                completion(result, nil)
            }
            
            task.resume()
        }
        
    }
}
